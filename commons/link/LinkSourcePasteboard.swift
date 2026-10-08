//
//  LinkSourcePasteboard.swift
//  quick-symlink
//

import Foundation
import AppKit

// Keeps track of the items to link from: either the ones remembered with "Copy as Link Source"
// or the files copied in Finder with Command-C, whichever was copied last.
public class LinkSourcePasteboard {

    private static let privatePasteboard = NSPasteboard.init(name: NSPasteboard.Name.init(rawValue: "qs"));

    // General pasteboard change count at the moment "Copy as Link Source" was used
    private static let generalChangeCountType = NSPasteboard.PasteboardType.init(rawValue: "io.github.ololx.quick-symlink.general-change-count");

    public static func remember(_ urls: [URL]) {
        let paths = urls.map { $0.path }.joined(separator: ";");

        privatePasteboard.declareTypes([NSPasteboard.PasteboardType.string, generalChangeCountType], owner: nil);
        privatePasteboard.setString(paths, forType: NSPasteboard.PasteboardType.string);
        privatePasteboard.setString(String(NSPasteboard.general.changeCount), forType: generalChangeCountType);
    }

    // Only inspects pasteboard types, so it does not trigger the system paste privacy prompt
    public static func hasItems() -> Bool {
        return !privatePaths().isEmpty || generalHasFiles();
    }

    // Returns the items to link from. Items remembered with "Copy as Link Source" are used once,
    // files copied with Command-C stay on the general pasteboard as Finder does.
    public static func take() -> [URL] {
        let paths = privatePaths();

        if generalHasFiles() && (paths.isEmpty || generalChangedSinceRemember()) {
            let urls = NSPasteboard.general.readObjects(
                forClasses: [NSURL.self],
                options: [NSPasteboard.ReadingOptionKey.urlReadingFileURLsOnly: true]
            ) as? [URL] ?? [];
            if !urls.isEmpty {
                return urls;
            }
        }

        privatePasteboard.clearContents();

        return paths.map { URL(fileURLWithPath: $0) };
    }

    private static func privatePaths() -> [String] {
        let paths = privatePasteboard.string(forType: NSPasteboard.PasteboardType.string) ?? "";

        return paths.isEmpty ? [] : paths.components(separatedBy: ";");
    }

    private static func generalHasFiles() -> Bool {
        return NSPasteboard.general.types?.contains(NSPasteboard.PasteboardType.fileURL) ?? false;
    }

    private static func generalChangedSinceRemember() -> Bool {
        let rememberedCount = privatePasteboard.string(forType: generalChangeCountType).flatMap { Int($0) };

        return rememberedCount != NSPasteboard.general.changeCount;
    }
}
