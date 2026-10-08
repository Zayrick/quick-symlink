//
//  RelativePath.swift
//  Quick Symlink
//

import Foundation

enum RelativePath {

    /// The path to `target` as seen from `directory`, e.g. `../c1/d1`.
    static func from(_ directory: URL, to target: URL) -> String {
        let base = directory.standardizedFileURL.pathComponents
        let destination = target.standardizedFileURL.pathComponents

        var common = 0
        while common < base.count, common < destination.count, base[common] == destination[common] {
            common += 1
        }

        let components = Array(repeating: "..", count: base.count - common) + destination[common...]
        return components.isEmpty ? "." : components.joined(separator: "/")
    }
}
