//
//  Settings.swift
//  Quick Symlink
//

import Foundation

/// Preferences shared by the app and the Finder extensions through the app group.
enum Settings {

    static let store = UserDefaults(suiteName: "92DWFLY372.io.github.zayrick.quick-symlink") ?? .standard

    static let useRelativePathsKey = "relative-path-strategy"

    /// Whether symbolic links point to their target with a relative path instead of an absolute one.
    static var useRelativePaths: Bool {
        get { store.object(forKey: useRelativePathsKey) as? Bool ?? true }
        set { store.set(newValue, forKey: useRelativePathsKey) }
    }
}
