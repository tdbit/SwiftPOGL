//
//  BreadthwiseIterator.swift
//  SwiftPOGL
//
//  Created by Tom Drummond on 6/19/23.
//

import Foundation

/// A `BreadthwiseIterator` iterates over the nodes in a graph returning the set of nodes
/// that are connected to prior current set of nodes.  Each iteration returns a new
/// set of unvisited nodes that are one step further away from the starting node.
public struct BreadthwiseIterator<T: Graph>: IteratorProtocol {
    public typealias Element = Set<T.NodeType>

    private var graph: T

    private var visitedNodes: Set<T.NodeType>

    private var queuedNodes: Set<T.NodeType>

    public init(graph: T, from node: T.NodeType? = nil) {
        self.graph = graph
        self.visitedNodes = []
        self.queuedNodes = [node ?? graph.nodes.randomElement()!]
    }

    public mutating func next() -> Element? {
        guard !queuedNodes.isEmpty else {
            return nil
        }

        let nextNodes = Set(queuedNodes)
        visitedNodes.formUnion(nextNodes)
        queuedNodes.removeAll()

        graph.edges.forEach { edge in
            if nextNodes.contains(edge.u) && !visitedNodes.contains(edge.v) {
                queuedNodes.insert(edge.v)
            }

            if nextNodes.contains(edge.v) && !visitedNodes.contains(edge.u) {
                queuedNodes.insert(edge.u)
            }
        }

        return nextNodes
    }
}


extension Graph {

    /// Calculates the distance between two nodes in a graph using a breadth-first
    /// search.  If the nodes are not connected then `nil` is returned.
    func distance(between u: NodeType, and v: NodeType) -> Int? {
        var iterator = BreadthwiseIterator(graph: self, from: u)
        var distance = 0
        while let layer = iterator.next() {
            if layer.contains(v) { return distance }
            distance += 1
        }
        return nil
    }
}
