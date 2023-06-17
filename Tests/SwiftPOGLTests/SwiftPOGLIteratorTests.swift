//
//  SwiftPOGLTests.swift
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
            var iterator = NodeSetIterator(graph: graph, from: test.0)
            var steps:[[Int]] = []
            while let p = iterator.next() {
                steps.append(p.sorted())
            }
            XCTAssertEqual(steps, test.1, "NodeSetIterator should match expected sets")
        }
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
            var iterator = NodeSetIterator(graph: graph, from: test.0)
            var steps:[[Int]] = []
            while let p = iterator.next() {
                steps.append(p.sorted())
            }
            XCTAssertEqual(steps, test.1, "NodeSetIterator should match expected sets")
        }
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
        let nodes = Array(1...10).map { $0 }
        let edges = [(1,2), (1,3), (2,4), (2,5), (3,5), (3, 6), (4,7), (4,8), (5,8), (5,9), (6,9), (6,10)]
        let graph = UndirectedGraph(nodes: nodes, edges: edges)
        var iterator = BreadthFirstSearch(graph: graph, from: 1)

        var output:[Int] = []
        while let next = iterator.next() {
            output.append(next)
        }

        print(output)
    }

    func testDirectedWalk() throws {
        let nodes = ["A", "B", "C", "D", "E"]
        let allEdges = [("A", "B"), ("A", "C"), ("B", "C"), ("C", "D"), ("D", "E"), ("E", "A")]
        let graph = DirectedGraph(nodes: nodes, edges: allEdges)

        let walkEdges = [("A", "B"), ("B", "C"), ("C", "D"), ("D", "E")]
        let walk = DirectedWalk(walkEdges.map { DirectedEdge($0.0,$0.1)! })
        XCTAssertTrue(Set(walk.edges).isSubset(of: graph.edges), "")
        XCTAssertEqual(walk.count, 4, "The length of a walk should be the number of edges")
        XCTAssertEqual(walk.nodes, ["A", "B", "C", "D", "E"])
        print(walk)

        let loopEdges = [("A", "B"), ("B", "C"), ("C", "D"), ("D", "E"), ("E", "A")]
        let loop = DirectedWalk(loopEdges.map { DirectedEdge($0.0,$0.1)! })
        XCTAssertEqual(loop.nodes, ["A", "B", "C", "D", "E", "A"])
        XCTAssertEqual(loop.start, loop.end, "Start and end of a loop should be the same")
        print(loop)
    }

}
