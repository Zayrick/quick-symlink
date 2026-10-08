//
//  LinkMaker.swift
//  Quick Symlink
//

import Foundation

enum LinkKind {
    case symbolic
    case hard
}

/// Creates symbolic or hard links on disk.
struct LinkMaker {

    let kind: LinkKind

    /// Only applies to symbolic links.
    var useRelativePaths = true

    private var fileManager: FileManager { .default }

    /// Creates a link to `source` inside `folder` and returns its location.
    @discardableResult
    func makeLink(to source: URL, in folder: URL) throws -> URL {
        let link = Self.availableURL(for: source.lastPathComponent, in: folder)
        try createLink(at: link, to: source)
        return link
    }

    /// Moves `source` into `folder` and leaves a link to its new location in its place.
    func moveAndLeaveLink(_ source: URL, to folder: URL) throws {
        let destination = Self.availableURL(for: source.lastPathComponent, in: folder)
        try fileManager.moveItem(at: source, to: destination)

        do {
            try createLink(at: source, to: destination)
        } catch {
            // Never leave the item moved away without a link at its original location
            try? fileManager.moveItem(at: destination, to: source)
            throw error
        }
    }

    private func createLink(at link: URL, to target: URL) throws {
        switch kind {
        case .symbolic:
            let destination = useRelativePaths
                ? RelativePath.from(link.deletingLastPathComponent(), to: target)
                : target.path
            try fileManager.createSymbolicLink(atPath: link.path, withDestinationPath: destination)
        case .hard:
            try fileManager.linkItem(at: target, to: link)
        }
    }

    /// `folder/name`, or `folder/name-1`, `folder/name-2`… if that name is already taken.
    static func availableURL(for name: String, in folder: URL) -> URL {
        let baseName = (name as NSString).deletingPathExtension
        let pathExtension = (name as NSString).pathExtension

        var candidate = folder.appendingPathComponent(name)
        var counter = 1
        while exists(candidate) {
            let numbered = "\(baseName)-\(counter)"
            candidate = folder.appendingPathComponent(pathExtension.isEmpty ? numbered : "\(numbered).\(pathExtension)")
            counter += 1
        }
        return candidate
    }

    /// Unlike `FileManager.fileExists`, also detects broken symbolic links.
    private static func exists(_ url: URL) -> Bool {
        (try? FileManager.default.attributesOfItem(atPath: url.path)) != nil
    }
}
