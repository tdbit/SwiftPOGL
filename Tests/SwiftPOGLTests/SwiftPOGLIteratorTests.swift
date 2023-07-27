//
//  SwiftPOGLIteratorTests.swift
//  SwiftPOGL
//
//  Created by Tom Drummond on 6/3/23.
//

import XCTest
@testable import SwiftPOGL

final class SwiftPOGLIteratorTests: XCTestCase {

    func testNodeIterator() {
        let nodes = Array(1...100)
        let graph = UndirectedGraph.random(from: nodes, p: 0.5) // graph should be connected
        var iterator = NodeIterator(graph: graph, from: 1)

        var steps:[Int] = []
        while let p = iterator.next() {
            steps.append(p)
        }

        XCTAssertEqual(steps.sorted(), Array(graph.nodes).sorted(), "Every node in a connected graph should be visited only once")
    }

    func testNodeSetIteratorTriangle() {
        //         1
        //        / \
        //       2–––3
        //      / \ / \
        //     4–––5–––6
        //    / \ / \ / \
        //   7–––8–––9–––10
        let nodes = Array(1...10).map { $0 }
        let edges = [(1,2), (2,3), (1,3),
                     (2,4), (4,5), (2,5), (3,5), (5,6), (3,6),
                     (4,7), (7,8), (4,8), (5,8), (8,9), (5,9), (6,9), (9,10), (6,10)]
        let graph = UndirectedGraph(nodes: nodes, edges: edges)

        let tests = [(1, [[1], [2,3], [4,5,6], [7,8,9,10]]),
                     (7, [[7], [4,8], [2,5,9], [1,3,6,10]]),
                     (5, [[5], [2,3,4,6,8,9], [1,7,10]])]

        for test in tests {
            var iterator = BreadthwiseIterator(graph: graph, from: test.0)
            var steps:[[Int]] = []
            while let p = iterator.next() {
                steps.append(p.sorted())
            }
            XCTAssertEqual(steps, test.1, "BreadthwiseIterator should match expected sets")
        }

        XCTAssertEqual(graph.distance(between: 1, and: 1), 0, "A node's distance to itself is 0")
        XCTAssertEqual(graph.distance(between: 1, and: 2), 1, "Adjacent nodes are 1 edge apart")
        XCTAssertEqual(graph.distance(between: 1, and: 10), 3, "The distance between two nodes is the shortest number of edges between them")
        XCTAssertEqual(graph.distance(between: 1, and: 0), nil, "The distance between two disconnected nodes is nil")
    }

    func testNodeSetIteratorBarbell() {
        //        3       7
        //       / \     / \
        //  1–––2   5–––6   9–––10
        //       \ /     \ /
        //        4       8
        let nodes = Array(1...10).map { $0 }
        let edges = [(1,2),
                     (2,3), (2,4), (3,5), (4,5),
                     (5,6),
                     (6,7), (6,8), (7,9), (8,9),
                     (9,10)
                     ]
        let graph = UndirectedGraph(nodes: nodes, edges: edges)

        let tests = [(1, [[1], [2], [3,4], [5], [6], [7,8], [9], [10]]),
                     (5, [[5], [3,4,6], [2,7,8], [1,9], [10]]),
                     (9, [[9], [7,8,10], [6], [5], [3,4], [2], [1]])
        ]
        for test in tests {
            var iterator = BreadthwiseIterator(graph: graph, from: test.0)
            var steps:[[Int]] = []
            while let p = iterator.next() {
                steps.append(p.sorted())
            }
            XCTAssertEqual(steps, test.1, "BreadthwiseIterator should match expected sets")
        }

        XCTAssertEqual(graph.distance(between: 1, and: 5), 3, "The distance between two nodes is the shortest number of edges between them")
        XCTAssertEqual(graph.distance(between: 1, and: 10), 7, "The distance between two nodes is the shortest number of edges between them")
    }

    func testQueue() throws {
        let count = 10
        let input = Array(1...count).map { $0 }
        var q = Queue<Int>()

        input.forEach { q.enqueue($0) }
        var output = (1...count).map { _ in q.dequeue()! }

        input.forEach { q.enqueue($0) }
        output = (1...count).map { _ in q.dequeue()! }

        XCTAssertEqual(input, output, "Queued output should be dequeued in the order receieved")
    }

    func testBreadthFirstSearch() {
        //         1
        //        / \
        //       2–––3
        //      / \ / \
        //     4–––5–––6
        //    / \ / \ / \
        //   7–––8–––9–––10
        let nodes = Array(1...10).map { $0 }
        let edges = [(1,2), (2,3), (1,3),
                     (2,4), (4,5), (2,5), (3,5), (5,6), (3,6),
                     (4,7), (7,8), (4,8), (5,8), (8,9), (5,9), (6,9), (9,10), (6,10)]
        let graph = UndirectedGraph(nodes: nodes, edges: edges)

        let tests = [(1, [1,2,3,4,5,6,7,8,9,10]),
                     (7, [7,4,8,2,5,9,1,3,6,10]),
                     (5, [5,2,3,4,6,8,9,1,7,10])]

        for test in tests {
            var iterator = BreadthFirstSearch(graph: graph, from: test.0)
            var steps:[Int] = []
            while let p = iterator.next() {
                steps.append(p)
        }
            XCTAssertEqual(steps, test.1, "BreadthwiseIterator should match expected sets")
        }
    }

    func testDepthFirstSearch() {
        //         1
        //        / \
        //       2   3
        //      / \ / \
        //     4   5   6
        //    / \ / \ / \
        //   7–––8–––9–––10
        let nodes = Array(1...10).map { $0 }
        let edges = [(1,2), (1,3),
                     (2,4), (2,5), (3,5), (3,6),
                     (4,7), (7,8), (4,8), (5,8), (8,9), (5,9), (6,9), (9,10), (6,10)]
        let graph = UndirectedGraph(nodes: nodes, edges: edges)

        let tests = [(1, [1,2,4,7,8,5,3,6,9,10]),
                     (4, [4,2,1,3,5,8,7,9,6,10]),
                     (5, [5,2,1,3,6,9,8,4,7,10])]

        for test in tests {
            var iterator = DepthFirstSearch(graph: graph, from: test.0)
            var steps:[Int] = []
            while let p = iterator.next() {
                steps.append(p)
            }
            XCTAssertEqual(steps, test.1, "DepthFirstSearch should match expected sets")
        }
    }

}
