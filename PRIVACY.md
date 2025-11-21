# Privacy Policy

**Last updated: November 21, 2025**

## Overview

Internet Speed Meter App ("the App") is committed to protecting your privacy. This document explains our data collection and usage practices.

## Data Collection

**We DO NOT collect any data whatsoever.**

Specifically, the App does not:
- ❌ Collect personal information
- ❌ Track browsing history or URLs visited
- ❌ Inspect network traffic content
- ❌ Use analytics or tracking services
- ❌ Send data to external servers
- ❌ Communicate over the internet
- ❌ Share information with third parties

## What the App Does

The App operates entirely locally on your Mac and only:
- ✅ Reads system-level network byte counters (available to all apps via macOS APIs)
- ✅ Calculates speed by comparing byte counts over time
- ✅ Stores cumulative usage totals locally in UserDefaults
- ✅ Displays statistics in the menu bar

## Local Data Storage

The App stores minimal data locally using macOS UserDefaults:

**Data Stored:**
- Total bytes downloaded (cumulative counter)
- Total bytes uploaded (cumulative counter)

**Storage Location:**
- Stored in: `~/Library/Preferences/`
- Format: Standard macOS property list (plist)

**Data Characteristics:**
- Remains on your Mac only
- Never transmitted anywhere
- Can be reset at any time via the app interface
- Automatically deleted when you uninstall the app

## Permissions Required

The App requires:

**Network Access:**
- Purpose: Read network interface statistics
- Scope: System-level byte counters only
- Does NOT: Access actual traffic content or URLs

**No Other Permissions Required:**
- Does NOT require internet connection
- Does NOT access location services
- Does NOT access camera or microphone
- Does NOT access contacts, calendar, or other personal data
- Does NOT require administrator privileges

## Third-Party Services

The App does not integrate with or use any:
- Analytics services (e.g., Google Analytics, Mixpanel)
- Crash reporting services
- Advertising networks
- Social media SDKs
- Cloud storage services
- External APIs or web services

## Data Retention

- Statistics are stored indefinitely until you reset them
- Data is only stored locally on your device
- Uninstalling the app removes all stored data

## Children's Privacy

The App does not collect any data from anyone, including children under 13.

## Open Source

This App is open source. You can review the complete source code to verify our privacy practices at [GitHub Repository Link].

## Changes to This Privacy Policy

Any updates to this privacy policy will be:
- Posted in this document
- Published in the app's GitHub repository
- Noted in release notes

## Contact

Questions about privacy? 
- Open an issue on [GitHub](../../issues)
- Review the source code to verify our claims

## Your Rights

Since we don't collect any data:
- There's no data to access, modify, or delete
- No data is shared with anyone
- You have complete control over your local statistics
- You can reset all data at any time from within the app

## Compliance

This App complies with:
- Apple's App Store Review Guidelines
- General Data Protection Regulation (GDPR) principles
- California Consumer Privacy Act (CCPA) principles
- Other privacy regulations (by virtue of not collecting data)

---

**Your privacy is paramount. This app is designed to be completely local and private by default.**
