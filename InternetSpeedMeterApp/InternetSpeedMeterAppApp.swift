import SwiftUI
import Combine

@main
struct InternetSpeedMeterApp: App {
    @StateObject private var speedMonitor = SpeedMonitor()

    var body: some Scene {
        MenuBarExtra {
            VStack(alignment: .leading, spacing: 12) {
                Text("Internet Speed Meter")
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .center)

                Divider()

                VStack(alignment: .leading, spacing: 8) {
                    Text("Current Speed")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                    
                    HStack {
                        Text("↑ Upload:")
                            .frame(width: 80, alignment: .leading)
                        Text(speedMonitor.uploadSpeed)
                            .fontWeight(.medium)
                            .foregroundColor(.blue)
                    }
                    
                    HStack {
                        Text("↓ Download:")
                            .frame(width: 80, alignment: .leading)
                        Text(speedMonitor.downloadSpeed)
                            .fontWeight(.medium)
                            .foregroundColor(.green)
                    }
                }

                Divider()

                VStack(alignment: .leading, spacing: 8) {
                    Text("Total Data Usage")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                    
                    HStack {
                        Text("↑ Uploaded:")
                            .frame(width: 80, alignment: .leading)
                        Text(speedMonitor.totalUploaded)
                            .fontWeight(.medium)
                    }
                    
                    HStack {
                        Text("↓ Downloaded:")
                            .frame(width: 80, alignment: .leading)
                        Text(speedMonitor.totalDownloaded)
                            .fontWeight(.medium)
                    }
                }

                Divider()

                Button("Reset Stats") {
                    speedMonitor.resetTotalUsage()
                }
                .frame(maxWidth: .infinity)
            }
            .padding()
            .frame(width: 250)
            .onAppear {
                speedMonitor.startMonitoring()
            }
        } label: {
            Text("↑ \(speedMonitor.uploadSpeed)  ↓ \(speedMonitor.downloadSpeed)")
                .font(.system(size: 11, weight: .medium, design: .monospaced))
        }
        .menuBarExtraStyle(.menu)
    }
}
