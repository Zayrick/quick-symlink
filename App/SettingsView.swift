//
//  SettingsView.swift
//  Quick Symlink
//

import SwiftUI
import FinderSync

struct SettingsView: View {

    @AppStorage(Settings.useRelativePathsKey, store: Settings.store)
    private var useRelativePaths = true

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Toggle("Use relative paths for symbolic links", isOn: $useRelativePaths)

            Text(extensionHint)
                .foregroundColor(.secondary)
                .fixedSize(horizontal: false, vertical: true)

            Button("Open Extension Settings…", action: openExtensionSettings)
        }
        .padding(20)
        .frame(width: 360, alignment: .leading)
    }

    private var extensionHint: LocalizedStringKey {
        if #available(macOS 15, *) {
            return "In Extensions, click ⓘ next to Quick Symlink and turn on its Finder extensions."
        }
        return "Enable the Quick Symlink extensions to use them from the Finder context menu."
    }

    private func openExtensionSettings() {
        // Since macOS 15 extensions are grouped by app in Login Items & Extensions,
        // while the Finder extensions list no longer shows apps with several extensions
        if #available(macOS 15, *),
           let url = URL(string: "x-apple.systempreferences:com.apple.LoginItems-Settings.extension?ExtensionItems") {
            NSWorkspace.shared.open(url)
        } else {
            FIFinderSyncController.showExtensionManagementInterface()
        }
    }
}
