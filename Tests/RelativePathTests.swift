//
//  RelativePathTests.swift
//  Quick Symlink
//

import XCTest
@testable import QuickSymlink

final class RelativePathTests: XCTestCase {

    func testTargetInsideDirectory() {
        XCTAssertEqual(RelativePath.from(url("/a/b"), to: url("/a/b/c/d")), "c/d")
    }

    func testTargetAboveDirectory() {
        XCTAssertEqual(RelativePath.from(url("/a/b/c/d"), to: url("/a/b")), "../..")
    }

    func testTargetInSiblingBranch() {
        XCTAssertEqual(RelativePath.from(url("/a/b/c2/d2"), to: url("/a/b/c1/d1")), "../../c1/d1")
    }

    func testSimilarNamesAreNotTreatedAsCommonPrefix() {
        XCTAssertEqual(RelativePath.from(url("/a/x/b"), to: url("/a/b/c")), "../../b/c")
    }

    func testSameDirectory() {
        XCTAssertEqual(RelativePath.from(url("/a/b"), to: url("/a/b")), ".")
    }

    private func url(_ path: String) -> URL {
        URL(fileURLWithPath: path)
    }
}
