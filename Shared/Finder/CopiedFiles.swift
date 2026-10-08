//
//  CopiedFiles.swift
//  Quick Symlink
//

import AppKit

/// Files copied in Finder with Command-C, used as the source of the links to paste.
enum CopiedFiles {

    /// Only inspects pasteboard types, so it does not trigger the system paste privacy prompt.
    static var isEmpty: Bool {
        !(NSPasteboard.general.types?.contains(.fileURL) ?? false)
    }

    static func read() -> [URL] {
        NSPasteboard.general.readObjects(
            forClasses: [NSURL.self],
            options: [.urlReadingFileURLsOnly: true]
        ) as? [URL] ?? []
    }
}
