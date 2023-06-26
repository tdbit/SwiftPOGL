//
//  SwiftPOGLFoundationTests.swift
//  SwiftPOGL
//
//  Created by Tom Drummond on 6/3/23.
//

import XCTest
@testable import SwiftPOGL

final class SwiftPOGLFoundationTests: XCTestCase {

    func testRandomSubset() {
        let count = 100
        let set = Set(Array(1...count))
        for i in -10...10 {
            let subset = set.randomSubset(count: i)
            XCTAssertEqual(subset.count, max(0, min(i, set.count)), "Sized random subset of should contain correct number of values.")
            XCTAssertTrue(subset.isSubset(of: set), "All elements in random subset should be in the original set.")
        }
    }

}
