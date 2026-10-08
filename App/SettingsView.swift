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

            Text("Enable the Quick Symlink extensions to use them from the Finder context menu.")
                .foregroundColor(.secondary)
                .fixedSize(horizontal: false, vertical: true)

            Button("Open Finder Extension Settings…") {
                FIFinderSyncController.showExtensionManagementInterface()
            }
        }
        .padding(20)
        .frame(width: 360, alignment: .leading)
    }
}
