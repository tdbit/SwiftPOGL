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
/// This iterator uses a simple array-backed stack as a queue to store the
/// collection of nodes to visit and provides two different policies for
/// deciding which nodes to add to the queue.  The default policy is to add all
/// unvisited nodes to the queue, including nodes that have already been queued.
/// This can lead to a large number of nodes being queued multiple times and a
/// very large queue.  The alternative policy is to only add unvisited nodes to
/// the queue that are not already in the queue.  This variant trades a smaller
/// queue for a slower speed as it has to check whether a node is already in the
/// queue before adding it.
public struct DepthFirstSearch<T: Graph>: IteratorProtocol where T.NodeType: Equatable {

    public enum QueuingPolicy {
        /// A variant that enqueues all unvisited neighbors of the current node including
        /// nodes that have already been queued.  In highly connected graphs this can lead
        /// to a large number of nodes being queued multiple times and a very large queue.
        /// This is the default variant.
        case queueAllUnvisited

        /// A variant that only enqueues nodes that are unvisited neighbors of the current 
        /// node _and_ that have not already been queued.  This variant trades a smaller 
        /// queue for a slower more expensive check to see whether a node is already in the
        /// array based queue stack.
        case queueOnlyUnqueued
    }

    private var graph: T

    private var policy: QueuingPolicy

    private var visitedNodes: Set<T.NodeType>

    private var queuedNodes: [T.NodeType]

    public init(graph: T, from node: T.NodeType? = nil, withPolicy policy: QueuingPolicy = .queueAllUnvisited) {
        self.graph = graph
        self.visitedNodes = []
        self.queuedNodes = [node ?? graph.nodes.randomElement()!]
        self.policy = policy
    }

    public mutating func next() -> T.NodeType? {
        policy == .queueAllUnvisited ? nextAllUnvisited() : nextOnlyUnqueued()
    }

    private mutating func nextAllUnvisited() -> T.NodeType? {
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

    private mutating func nextOnlyUnqueued() -> T.NodeType? {
        guard let next = queuedNodes.pop() else {
            return nil
        }

        visitedNodes.insert(next)

        for node in graph.neighbors(of: next) {
            if !visitedNodes.contains(node) && !queuedNodes.contains(node) {
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

    @inlinable
    mutating func push(_ element: Element) {
        append(element)
    }

    @inlinable
    mutating func pop() -> Element? {
        popLast()
    }
}
