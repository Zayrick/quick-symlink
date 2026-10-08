//
//  LinkMakerTests.swift
//  Quick Symlink
//

import XCTest
@testable import QuickSymlink

final class LinkMakerTests: XCTestCase {

    private var root: URL!

    override func setUpWithError() throws {
        root = FileManager.default.temporaryDirectory.appendingPathComponent(UUID().uuidString)
        try FileManager.default.createDirectory(at: root.appendingPathComponent("source"), withIntermediateDirectories: true)
        try FileManager.default.createDirectory(at: root.appendingPathComponent("target"), withIntermediateDirectories: true)
        try "hello".write(to: file("source/note.txt"), atomically: true, encoding: .utf8)
    }

    override func tearDownWithError() throws {
        try FileManager.default.removeItem(at: root)
    }

    func testRelativeSymbolicLink() throws {
        let link = try LinkMaker(kind: .symbolic).makeLink(to: file("source/note.txt"), in: file("target"))

        XCTAssertEqual(link.lastPathComponent, "note.txt")
        XCTAssertEqual(try FileManager.default.destinationOfSymbolicLink(atPath: link.path), "../source/note.txt")
        XCTAssertEqual(try String(contentsOf: link, encoding: .utf8), "hello")
    }

    func testAbsoluteSymbolicLink() throws {
        let link = try LinkMaker(kind: .symbolic, useRelativePaths: false).makeLink(to: file("source/note.txt"), in: file("target"))

        XCTAssertEqual(try FileManager.default.destinationOfSymbolicLink(atPath: link.path), file("source/note.txt").path)
    }

    func testLinkNextToSourceGetsNumberedName() throws {
        let link = try LinkMaker(kind: .symbolic).makeLink(to: file("source/note.txt"), in: file("source"))

        XCTAssertEqual(link.lastPathComponent, "note-1.txt")
        XCTAssertEqual(try FileManager.default.destinationOfSymbolicLink(atPath: link.path), "note.txt")
    }

    func testHardLink() throws {
        let link = try LinkMaker(kind: .hard).makeLink(to: file("source/note.txt"), in: file("target"))

        let attributes = try FileManager.default.attributesOfItem(atPath: link.path)
        XCTAssertEqual(attributes[.referenceCount] as? Int, 2)
    }

    func testMoveAndLeaveLink() throws {
        try LinkMaker(kind: .symbolic).moveAndLeaveLink(file("source/note.txt"), to: file("target"))

        XCTAssertEqual(try FileManager.default.destinationOfSymbolicLink(atPath: file("source/note.txt").path), "../target/note.txt")
        XCTAssertEqual(try String(contentsOf: file("target/note.txt"), encoding: .utf8), "hello")
    }

    private func file(_ path: String) -> URL {
        root.appendingPathComponent(path)
    }
}
