//
//  NodeIterator.swift
//  SwiftPOGL
//
//  Created by Tom Drummond on 6/16/23.
//

import Foundation

/// A `NodeIterator` iterates over connected nodes in a graph from a starting node in
/// a random manner.
///
/// This iterator uses a `Set` to store the collection of queued nodes to iterate over
/// so the order in which connected nodes will be visited is random but its performance
/// should be the same whether the graph has a high degree or low degree of connectivity.
public struct NodeIterator<T: Graph>: IteratorProtocol {

    private var graph: T

    private var visitedNodes: Set<T.NodeType>

    private var queuedNodes: Set<T.NodeType>

    public init(graph: T, from node: T.NodeType? = nil) {
        self.graph = graph
        self.visitedNodes = []
        self.queuedNodes = [node ?? graph.nodes.randomElement()!]
    }

    public mutating func next() -> T.NodeType? {
        guard let next = queuedNodes.dequeue() else {
            return nil
        }

        visitedNodes.insert(next)

        for node in graph.neighbors(of: next) {
            // No need to check if it's already queued because queuedNodes is a set
            if !visitedNodes.contains(node) {
                queuedNodes.enqueue(node)
            }
        }

        return next
    }
}


extension Set {

    fileprivate mutating func enqueue(_ element: Element) {
        insert(element)
    }

    fileprivate mutating func dequeue() -> Element? {
        isEmpty ? nil : removeFirst()
    }
}
