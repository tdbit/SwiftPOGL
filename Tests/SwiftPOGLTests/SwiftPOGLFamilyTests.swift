//
//  SwiftPOGLFamilyTests.swift
//  SwiftPOGL
//
//  Created by Tom Drummond on 7/26/23.
//

import Foundation

import XCTest
@testable import SwiftPOGL

final class SwiftPOGLFamilyTests: XCTestCase {

    func testNull() {
        let nodes = Array(1...15)
        let graph = UndirectedGraph.generate(.null, nodes: nodes)

        XCTAssertEqual(graph.edges.count, 0, "Null graphs should have no edges.")
        XCTAssertEqual(graph.nodes.count, 15, "Null graphs should have all given nodes.")

        for node in nodes {
            XCTAssertEqual(graph.neighbors(of: node), [], "Every node in a null graphs should have no neighbors.")
        }
    }

    func testPath() {
        let nodes = Array(1...15)
        let graph = UndirectedGraph.generate(.path, nodes: nodes)
        let digraph = DirectedGraph.generate(.path, nodes: nodes)

        XCTAssertEqual(graph.edges.count, nodes.count - 1, "Path graphs should have 1 fewer edges than nodes.")
        XCTAssertEqual(digraph.edges.count, nodes.count - 1, "Path digraphs should have 1 fewer edges than nodes.")

        for node in nodes[1..<nodes.count - 1] {
            XCTAssertEqual(graph.degree(of: node), 2, "All nodes in a path graph that are not endpoints should have 2 neighbors.")
            XCTAssertEqual(digraph.inDegree(of: node), 1, "All nodes in a path digraph exluding endpoints should have 1 upstream node.")
            XCTAssertEqual(digraph.outDegree(of: node), 1, "All nodes in a path digraph excluding endpoints should have 1 downstream node.")
        }

        XCTAssertEqual(graph.neighbors(of: 1), [2], "Endpoints in a path graph should have 1 neighbor.")
        XCTAssertEqual(digraph.neighbors(of: 1), [2], "Start point in a path digraph should 1 neighbor.")

        XCTAssertEqual(graph.neighbors(of: 15), [14], "Endpoints in a path graph should have 1 neighbor.")
        XCTAssertEqual(digraph.neighbors(of: 15), [14], "End point in a path digraph should 1 neighbor.")
    }

    func testCycle() {
        let nodes = Array(1...9)
        let graph = UndirectedGraph.generate(.cycle, nodes: nodes)
        let digraph = DirectedGraph.generate(.cycle, nodes: nodes)

        XCTAssertEqual(graph.edges.count, nodes.count, "Cycle graphs should have the same number of edges as nodes.")
        XCTAssertEqual(digraph.edges.count, nodes.count, "Cycle digraphs should have the same number of edges as nodes.")

        for i in nodes.indices {
            let index = i + nodes.count // Allow for -1
            let neighbors = Set([nodes[(index - 1) % nodes.count], nodes[(index + 1) % nodes.count]])
            XCTAssertEqual(graph.neighbors(of: nodes[i]), neighbors, "Neighbors in a cycle graph should be adjacent nodes.")
            XCTAssertEqual(digraph.neighbors(of: nodes[i]), neighbors, "Neighbors in a cycle digraph should be adjacent nodes.")
        }
    }

    func testStar() {
        let nodes = Array(1...9)
        let graph = UndirectedGraph.generate(.star, nodes: nodes)
        let digraph = DirectedGraph.generate(.star, nodes: nodes)

        XCTAssertEqual(graph.edges.count, nodes.count - 1, "Star graphs should have 1 fewer edges than nodes.")
        XCTAssertEqual(digraph.edges.count, nodes.count - 1, "Star digraphs should have 1 fewer edges than nodes.")

        XCTAssertEqual(graph.neighbors(of: 1), Set(nodes[1..<nodes.count]), "The center node in a star graph should have all other nodes as neighbors.")
        XCTAssertEqual(digraph.neighbors(of: 1), Set(nodes[1..<nodes.count]), "The center node in a star digraph should have all other nodes as neighbors.")
        
        for i in nodes.indices.dropFirst() {
            XCTAssertEqual(graph.neighbors(of: nodes[i]), [1], "All nodes in a star graph excluding the center node should have 1 neighbor.")
            XCTAssertEqual(digraph.neighbors(of: nodes[i]), [1], "All nodes in a star digraph excluding the center node should have 1 neighbor.")
        }
    }

    func testWheel() {
        let nodes = Array(1...15)
        let graph = UndirectedGraph.generate(.wheel, nodes: nodes)
        let digraph = DirectedGraph.generate(.wheel, nodes: nodes)

        XCTAssertEqual(graph.edges.count, 2 * (nodes.count - 1), "Wheel graphs should have 2 less than 2 times as many edges as nodes.")
        XCTAssertEqual(digraph.edges.count, 2 * (nodes.count - 1), "Wheel digraphs should have 2 less than 2 times as many edges as nodes.")

        XCTAssertEqual(graph.neighbors(of: 1), Set(nodes[1..<nodes.count]), "The center node in a wheel graph should have all other nodes as neighbors.")
        XCTAssertEqual(digraph.neighbors(of: 1), Set(nodes[1..<nodes.count]), "The center node in a wheel digraph should have all other nodes as neighbors.")

        XCTAssertEqual(graph.neighbors(of: nodes[1]), [1,3,15], "Neighbors in a wheel graph should be adjacent nodes and the center node.")
        XCTAssertEqual(digraph.neighbors(of: nodes[1]), [1,3,15], "Neighbors in a wheel digraph should be adjacent nodes and the center node.")
    }

    func testPrism() { 
        let nodes = Array(1...8)
        let graph = UndirectedGraph.generate(.prism, nodes: nodes)
        let digraph = DirectedGraph.generate(.prism, nodes: nodes)

        XCTAssertEqual(graph.edges.count, 3 * nodes.count / 2, "Prism graphs should have 1.5x as many edges as nodes.")
        XCTAssertEqual(digraph.edges.count, 3 * nodes.count / 2, "Prism digraphs should have 1.5x times as many edges as nodes.")

        for node in nodes {
            XCTAssertEqual(graph.degree(of: node), 3, "All nodes in a prism graph should have 3 neighbors.")
            XCTAssertEqual(digraph.degree(of: node), 3, "All nodes in a prism digraph should have 3 neighbors.")
        }
    }

    func testTree() {
        let pow = { (lhs: Int, _ rhs: Int) -> Int in
            Int(Foundation.pow(Double(lhs), Double(rhs)))
        }
        let k = 3
        let layers = 6
        let count = (pow(k, layers) - 1)/(k - 1)
        let nodes = Array(1...count)

        let graph = UndirectedGraph.generate(.tree(k: k), nodes: nodes)
        let digraph = DirectedGraph.generate(.tree(k: k), nodes: nodes)

        XCTAssertEqual(graph.edges.count, (nodes.count - 1), "Tree graphs should have n - 1 edges.")
        XCTAssertEqual(digraph.edges.count, (nodes.count - 1), "Tree digraphs should have n - 1 edges.")

        for node in nodes[1..<(count - pow(k, layers - 1))] {
            XCTAssertEqual(graph.neighbors(of: node).count, k + 1, "Non-leaf nodes in a complete tree graph should have k + 1 neighbors.")
            XCTAssertEqual(digraph.neighbors(of: node).count, k + 1, "Non-leaf nodes in a complete tree digraph should have k + 1 neighbors.")
        }

        for node in nodes[(count - pow(k, layers - 1))...] {
            XCTAssertEqual(graph.neighbors(of: node).count, 1, "Leaf nodes in a complete tree graph should have 1 neighbor.")
            XCTAssertEqual(digraph.neighbors(of: node).count, 1, "Leaf nodes in a complete tree digraph should have 1 neighbor.")
        }
    }

    func testMesh() {
        let m = 5
        let n = 3
        let nodes = Array(1...m*n)
        let graph = UndirectedGraph.generate(.mesh(m: m, n: n), nodes: nodes)
        let digraph = DirectedGraph.generate(.mesh(m: m, n: n), nodes: nodes)

        XCTAssertEqual(graph.edges.count, 2 * m * n - m - n, "Mesh graphs should have twice as many edges as nodes less the number of rows and columns.")
        XCTAssertEqual(digraph.edges.count, 2 * m * n - m - n, "Mesh digraphs should have twice as many edges as nodes less the number of rows and columns.")

        XCTAssertEqual(graph.neighbors(of: 1), [2, n + 1], "Corner nodes in a mesh graph should have 2 neighbors.")
        XCTAssertEqual(digraph.neighbors(of: 1), [2, n + 1], "Corner nodes in a mesh digraph should have 2 neighbors.")

        XCTAssertEqual(graph.neighbors(of: m * n), [m * n - 1, m * n - n], "Corner nodes in a mesh graph should have 2 neighbors.")
        XCTAssertEqual(digraph.neighbors(of: m * n), [m * n - 1, m * n - n], "Corner nodes in a mesh digraph should have 2 neighbors.")
    }

    func testTorus() {
        let m = 3
        let n = 5
        let nodes = Array(1...m*n)
        let graph = UndirectedGraph.generate(.torus(m: m, n: n), nodes: nodes)
        let digraph = DirectedGraph.generate(.torus(m: m, n: n), nodes: nodes)

        XCTAssertEqual(graph.edges.count, 2 * m * n, "Torus graphs should have 2 * m * n edges.")
        XCTAssertEqual(digraph.edges.count, 2 * m * n, "Torus digraphs should have 2 * m * n edges.")

        for node in nodes {
            XCTAssertEqual(graph.degree(of: node), 4, "All nodes in a torus graph should have 4 neighbors.")
            XCTAssertEqual(digraph.degree(of: node), 4, "All nodes in a torus digraph should have 4 neighbors.")
        }

        //   |  |  |  |  |
        // --1--2--3--4--5-
        //   |  |  |  |  |
        // --6--7--8--9-10-
        //   |  |  |  |  |
        // -11-12-13-14-15-
        //   |  |  |  |  |

        let results:[(Int, Set<Int>)] =  [
            (1, [2, 6, 5, 11]),
            (2, [3, 7, 1, 12]),
            (8, [3, 9, 13, 7]),
            (10, [5, 6, 15, 9]),
            (15, [10, 11, 5, 14]),
        ]

        for result in results {
            XCTAssertEqual(graph.neighbors(of: result.0), result.1, "Neighbors should wrap around in a torus graph")
            XCTAssertEqual(digraph.neighbors(of: result.0), result.1, "Neighbors should wrap around in a torus digraph")
        }
    }

    func testComplete() {
        let nodes = Array(1...20)
        let graph = UndirectedGraph.generate(.complete, nodes: nodes)
        let digraph = DirectedGraph.generate(.complete, nodes: nodes)

        XCTAssertEqual(graph.edges.count, nodes.count * (nodes.count - 1) /  2)
        XCTAssertEqual(digraph.edges.count, nodes.count * (nodes.count - 1))

        for node in nodes {
            let neighbors = graph.nodes.filter({ $0 != node })
            XCTAssertEqual(graph.neighbors(of: node), neighbors, "All nodes in a complete graph should be connected to all other nodes.")
            XCTAssertEqual(digraph.neighbors(of: node), neighbors, "All nodes in a complete digraph should be connected to all other nodes.")
        }
    }
}
