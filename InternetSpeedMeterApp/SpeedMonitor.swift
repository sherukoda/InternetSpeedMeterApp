import Foundation
import Combine
import Network
import Darwin

class SpeedMonitor: ObservableObject {
    @Published var downloadSpeed: String = "0 KB/s"
    @Published var uploadSpeed: String = "0 KB/s"
    @Published var totalDownloaded: String = "0 MB"
    @Published var totalUploaded: String = "0 MB"

    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue.global(qos: .background)
    private var timer: Timer?

    private var previousRx: UInt64 = 0
    private var previousTx: UInt64 = 0
    private var sessionStartRx: UInt64 = 0
    private var sessionStartTx: UInt64 = 0
    
    // UserDefaults keys
    private let totalDownloadedKey = "totalDownloadedBytes"
    private let totalUploadedKey = "totalUploadedBytes"
    
    init() {
        // Load saved totals from UserDefaults
        let savedDownloaded = UInt64(UserDefaults.standard.integer(forKey: totalDownloadedKey))
        let savedUploaded = UInt64(UserDefaults.standard.integer(forKey: totalUploadedKey))
        
        if savedDownloaded > 0 {
            totalDownloaded = formatBytes(savedDownloaded)
        }
        if savedUploaded > 0 {
            totalUploaded = formatBytes(savedUploaded)
        }
    }

    func startMonitoring() {
        monitor.pathUpdateHandler = { _ in }
        monitor.start(queue: queue)

        // Start timer loop for speed polling
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            self.updateNetworkUsage()
        }
    }

    private func updateNetworkUsage() {
        let (rx, tx) = self.getNetworkBytes()

        if previousRx > 0 && previousTx > 0 {
            let dl = Int(rx - previousRx)
            let ul = Int(tx - previousTx)

            DispatchQueue.main.async {
                self.downloadSpeed = self.formatSpeed(dl)
                self.uploadSpeed   = self.formatSpeed(ul)
                
                // Update total usage
                if self.sessionStartRx == 0 {
                    self.sessionStartRx = rx
                    self.sessionStartTx = tx
                }
                
                let currentDownloaded = rx - self.sessionStartRx
                let currentUploaded = tx - self.sessionStartTx
                
                // Add to saved totals
                let savedDownloaded = UInt64(UserDefaults.standard.integer(forKey: self.totalDownloadedKey))
                let savedUploaded = UInt64(UserDefaults.standard.integer(forKey: self.totalUploadedKey))
                
                let totalDown = savedDownloaded + currentDownloaded
                let totalUp = savedUploaded + currentUploaded
                
                self.totalDownloaded = self.formatBytes(totalDown)
                self.totalUploaded = self.formatBytes(totalUp)
                
                // Save periodically (every update)
                UserDefaults.standard.set(Int(totalDown), forKey: self.totalDownloadedKey)
                UserDefaults.standard.set(Int(totalUp), forKey: self.totalUploadedKey)
            }
        } else {
            // Initialize session start values
            sessionStartRx = rx
            sessionStartTx = tx
        }

        previousRx = rx
        previousTx = tx
    }

    private func getNetworkBytes() -> (UInt64, UInt64) {
        var rx: UInt64 = 0
        var tx: UInt64 = 0

        var addrs: UnsafeMutablePointer<ifaddrs>?
        if getifaddrs(&addrs) == 0, let firstAddr = addrs {
            var ptr: UnsafeMutablePointer<ifaddrs>? = firstAddr

            while let current = ptr {
                if let dataPtr = current.pointee.ifa_data {
                    let ifdata = dataPtr.assumingMemoryBound(to: if_data.self).pointee
                    rx += UInt64(ifdata.ifi_ibytes)
                    tx += UInt64(ifdata.ifi_obytes)
                }
                ptr = current.pointee.ifa_next
            }

            freeifaddrs(addrs)
        }

        return (rx, tx)
    }

    private func formatSpeed(_ bytes: Int) -> String {
        let kb = Double(bytes) / 1024
        let mb = kb / 1024

        if mb >= 1 {
            return String(format: "%.2f MB/s", mb)
        }
        return String(format: "%.2f KB/s", kb)
    }
    
    private func formatBytes(_ bytes: UInt64) -> String {
        let kb = Double(bytes) / 1024
        let mb = kb / 1024
        let gb = mb / 1024

        if gb >= 1 {
            return String(format: "%.2f GB", gb)
        } else if mb >= 1 {
            return String(format: "%.2f MB", mb)
        } else {
            return String(format: "%.2f KB", kb)
        }
    }
    
    func resetTotalUsage() {
        UserDefaults.standard.set(0, forKey: totalDownloadedKey)
        UserDefaults.standard.set(0, forKey: totalUploadedKey)
        
        DispatchQueue.main.async {
            self.totalDownloaded = "0 MB"
            self.totalUploaded = "0 MB"
        }
        
        // Reset session counters
        sessionStartRx = previousRx
        sessionStartTx = previousTx
    }
}
