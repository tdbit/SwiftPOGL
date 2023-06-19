//
//  DepthFirstSearch.swift
//  SwiftPOGL
//
//  Created by Tom Drummond on 6/16/23.
//

import Foundation

/// A `DepthFirstSearch` iterator iterates over connected nodes in a graph
/// from a starting node using a depth-first approach.
///
/// If the nodes are `Comparable` then the current node's neighbour will be visited
/// in ascending order.  This iterator uses a simple array-backed stack to store
/// the collection of nodes to visit and only checks for visited nodes when
/// popping the next node off the stack.
public struct DepthFirstSearch<T: Graph>: IteratorProtocol where T.NodeType: Equatable {

    private var graph: T

    private var visitedNodes: Set<T.NodeType>

    private var queuedNodes: Array<T.NodeType>

    public init(graph: T, from node: T.NodeType? = nil) {
        self.graph = graph
        self.visitedNodes = []
        self.queuedNodes = [node ?? graph.nodes.randomElement()!]
    }

    ///
    public mutating func next() -> T.NodeType? {
        var next = queuedNodes.pop()
        while next != nil, visitedNodes.contains(next!) {
            next = queuedNodes.pop()
        }

        guard let next = next else {
            return nil
        }

        visitedNodes.insert(next)

        for node in graph.neighbors(of: next) {
            if !visitedNodes.contains(node) {
                queuedNodes.push(node)
            }
        }

        return next
    }
}


extension DepthFirstSearch where T.NodeType: Comparable {

    public mutating func next() -> T.NodeType? {
        var next = queuedNodes.pop()
        while next != nil, visitedNodes.contains(next!) {
            next = queuedNodes.pop()
        }

        guard let next = next else {
            return nil
        }

        visitedNodes.insert(next)

        for node in graph.neighbors(of: next).sorted(by: >) {
            if !visitedNodes.contains(node) {
                queuedNodes.push(node)
            }
        }
        return next
    }
}


extension Array {

    mutating func push(_ element: Element) {
        append(element)
    }

    mutating func pop() -> Element? {
        popLast()
    }
}
