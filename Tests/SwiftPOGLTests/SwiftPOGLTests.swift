//
//  SwiftPOGLTests.swift
//  SwiftPOGL
//
//  Created by Tom Drummond on 6/3/23.
//

import XCTest
@testable import SwiftPOGL

final class SwiftPOGLTests: XCTestCase {

    func testDirectedGraph() throws {
        let toEdge = DirectedEdge(1,2)
        let fromEdge = DirectedEdge(2,1)
        XCTAssertNotEqual(toEdge, fromEdge, "Node order should matter in an directed graph")
    }

    func testReversedEdge() throws {
        let toEdge = DirectedEdge(1,2)
        let fromEdge = DirectedEdge(2,1)


        XCTAssertEqual(toEdge, fromEdge?.reversed(), "A directed edge's reverse is the edge with the nodes swapped")
        XCTAssertEqual(fromEdge, toEdge?.reversed(), "A directed edge's reverse is the edge with the nodes swapped")
        XCTAssertEqual(toEdge, toEdge?.reversed().reversed(), "A reversed directed edge reverse is the same as the edge")
    }

    func testStringDirectedGraph() throws {
        let nodes = [1, 2, 3, 4, 4, 4]
        let edges = [(1,2), (2,1), (3,1), (1,3), (4,1), (1,4), (1,4)]
        let graph = DirectedGraph(nodes: nodes, edges: edges)
        XCTAssertEqual(graph.nodes.count, 4, "All nodes in a directed graph should be unique")
        XCTAssertEqual(graph.edges.count, 6, "")
    }

    func testReversedGraph() throws {
        let nodes = [1, 2, 3, 4]
        let clockwiseEdges = [(1,2), (2,3), (3,4), (4,1)]
        let anticlockwiseEdges = [(1,4), (4,3), (3,2), (2,1)]

        let clockwiseGraph = DirectedGraph(nodes: nodes, edges: clockwiseEdges)
        let anticlockwiseGraph = DirectedGraph(nodes: nodes, edges: anticlockwiseEdges)

        XCTAssertEqual(clockwiseGraph, anticlockwiseGraph.reversed(), "A reversed directed graph's edges")
        XCTAssertEqual(anticlockwiseGraph, clockwiseGraph.reversed(), "A reversed directed graph's edges")
    }

    func testUndirectedGraph() throws {
        let toEdge = UndirectedEdge(1,2)
        let fromEdge = UndirectedEdge(2,1)
        XCTAssertEqual(toEdge, fromEdge, "Node order should not matter in an undirected graph")

        let graph = UndirectedGraph(nodes: [1, 2, 3, 3], edges: [(1,2), (2,3), (3,1), (3,1), (1,3)])
        XCTAssertEqual(graph.nodes.count, 3, "Undirected graphs cannot contain two nodes with the same value")
        XCTAssertEqual(graph.edges.count, 3, "Undirected graphs cannot contain two edges with the same nodes")

        print(graph)
    }

    func testStringUndirectedGraph() throws {
        let nodes = ["A", "B", "C", "D", "*"]
        let edges = stride(from: 1, through: 10, by: 1).map { _ in (nodes.randomElement()!, nodes.randomElement()!) }
        let graph = UndirectedGraph(nodes: nodes, edges: edges)

        print(graph)
    }

    func testIncidence() throws {
        let nodes = [1,2,3,4,5]
        let edges = [(1,2), (1,3), (4,1), (4,5)]
        let graph = UndirectedGraph(nodes: nodes, edges: edges)
        let digraph = DirectedGraph(nodes: nodes, edges: edges)

        XCTAssertEqual(graph.degree(of: 1), 3, "A node's degree should equal the number of its edges")
        XCTAssertEqual(graph.neighbors(of: 1), [2, 3, 4], "A node's neighbours should be the set of nodes it is connected to")

        XCTAssertEqual(digraph.degree(of: 1), 3, "A node's degree should equal the number of its edges")
        XCTAssertEqual(digraph.neighbors(of: 1), [2, 3, 4], "A node's neighbours should be the set of nodes it is connected to")
    }

    func testScale() throws {
        let nodes = [1,2,3,4,5]
        let edges = [(1,2), (1,3), (4,1), (4,5)]
        let graph = UndirectedGraph(nodes: nodes, edges: edges)
        let digraph = DirectedGraph(nodes: nodes, edges: edges)

        XCTAssertEqual(graph.order, 5, "The order of a graph should be the number of its nodes")
        XCTAssertEqual(digraph.order, 5, "The order of a digraph should be the number of its nodes")

        XCTAssertEqual(graph.size, 4, "The order of a graph should be the number of its nodes")
        XCTAssertEqual(digraph.size, 4, "The order of a digraph should be the number of its nodes")
    }
}
