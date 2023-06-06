//
//  SwiftPOGLFoundationTests.swift
//  SwiftPOGL
//
//  Created by Tom Drummond on 6/3/23.
//

import XCTest
@testable import SwiftPOGL

final class SwiftPOGLFoundationTests: XCTestCase {

    func testRandomPairs() throws {
        let count = 15
        let array = [1,2,3,4,5]
        let set = Set([1,2,3,4,5])

        for _ in 1...count {
            let pair = array.randomPair()

            XCTAssertNotNil(pair, "A random pair from an array should not be nil")
            XCTAssertTrue(array.contains(pair!.0) && array.contains(pair!.1), "Both elements from a random pair should be in the array")
        }

        for _ in 1...count {
            let pair = set.randomPair()

            XCTAssertNotNil(pair, "A random pair from a set should not be nil")
            XCTAssertTrue(array.contains(pair!.0) && array.contains(pair!.1), "Both elements from a random pair should be in the set")
        }
    }

    func testRandomDistinctPair() throws {
        let array1 = [1]
        let pair1 = array1.randomDistinctPair()
        XCTAssertNil(pair1, "Arrays with less than two distinct elements should return nil distinct pairs")

        let array2 = [1,1]
        let pair2 = array2.randomDistinctPair()
        XCTAssertNil(pair2, "Arrays with less than two distinct elements should return nil distinct pairs")

        let count = 15
        let array3 = [1,1,2,2,3,3]
        for _ in 1...count {
            let pair = array3.randomDistinctPair()
            XCTAssertNotEqual(pair!.0, pair!.1, "Elements in a random distinct pair from an array must be different")
        }

        let set = Set([1,1,2,3,4,5])
        for _ in 1...count {
            let pair = set.randomDistinctPair()
            XCTAssertNotEqual(pair!.0, pair!.1, "Elements in a random distinct pair from a set must be different")
        }
    }

    func testRandomDistinctPairs() throws {
        let count = 15
        let array = [1,1,2,2,3,3,4,5,6,7,8,9,10]

        for _ in 1...count {
            let pairs = array.randomDistinctPairs()
            let distinct = pairs.allSatisfy { $0.0 != $0.1 }
            XCTAssertTrue(distinct, "Every pair in an array of distinct pairs should be distinct.")
        }

        for i in 1...count {
            let pairs = array.randomDistinctPairs(count: i)
            let distinct = pairs.allSatisfy { $0.0 != $0.1 }
            XCTAssertEqual(pairs.count, i, "Number of distinct pairs returned should be \(i).")
            XCTAssertTrue(distinct, "Every pair in an array of distinct pairs should be distinct.")
        }
    }

}
