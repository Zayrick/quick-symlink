//
//  LinkSourcePasteboard.swift
//  quick-symlink
//

import Foundation
import AppKit

// Provides the items to link from: the files copied in Finder with Command-C.
public class LinkSourcePasteboard {

    // Only inspects pasteboard types, so it does not trigger the system paste privacy prompt
    public static func hasItems() -> Bool {
        return NSPasteboard.general.types?.contains(NSPasteboard.PasteboardType.fileURL) ?? false;
    }

    public static func take() -> [URL] {
        return NSPasteboard.general.readObjects(
            forClasses: [NSURL.self],
            options: [NSPasteboard.ReadingOptionKey.urlReadingFileURLsOnly: true]
        ) as? [URL] ?? [];
    }
}
