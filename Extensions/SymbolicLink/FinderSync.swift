//
//  FinderSync.swift
//  Quick Symlink
//

final class FinderSync: LinkFinderSync {

    override var kind: LinkKind {
        .symbolic
    }
}
