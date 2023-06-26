//
//  BreadthFirstSearch.swift
//  SwiftPOGL
//
//  Created by Tom Drummond on 6/16/23.
//

import Foundation

/// A `BreadthFirstSearch` iterator iterates over connected nodes in a graph
/// from a starting node using a breadth-first approach.
///
/// If the nodes are `Comparable` then each "layer" of neighbours will be searched
/// in ascending order.  This iterator uses a simple linked list queue to store
/// the collection of nodes to iterate over and therefore will be slow if the graph
/// has a high degree of connectivity.
public struct BreadthFirstSearch<T: Graph>: IteratorProtocol where T.NodeType: Equatable {

    private var graph: T

    private var visitedNodes: Set<T.NodeType>

    private var queuedNodes: Queue<T.NodeType>

    public init(graph: T, from node: T.NodeType? = nil) {
        self.graph = graph
        self.visitedNodes = []
        self.queuedNodes = Queue(node ?? graph.nodes.randomElement()!)
    }

    public mutating func next() -> T.NodeType? {
        guard let next = queuedNodes.dequeue() else {
            return nil
        }

        visitedNodes.insert(next)

        for node in graph.neighbors(of: next) {
            if !visitedNodes.contains(node) && !queuedNodes.contains(node) {
                queuedNodes.enqueue(node)
            }
        }

        return next
    }
}


extension BreadthFirstSearch where T.NodeType: Comparable {

    public mutating func next() -> T.NodeType? {
        guard let next = queuedNodes.dequeue() else {
            return nil
        }

        visitedNodes.insert(next)

        for node in graph.neighbors(of: next).sorted() {
            if !visitedNodes.contains(node) && !queuedNodes.contains(node) {
                queuedNodes.enqueue(node)
            }
        }

        return next

    }
}


internal struct Queue<Element> {

    class Place<Element> {
        var previous: Place<Element>?
        var value: Element
        var next: Place<Element>?

        init(previous: Place<Element>? = nil, value: Element, next: Place<Element>? = nil) {
            self.previous = previous
            self.value = value
            self.next = next
        }
    }

    private var head: Place<Element>?

    private var tail: Place<Element>?

    private var length: Int = 0

    /// Creates a new queue with the `value` at its head or an empty queue if `value` is nil.
    init(_ value: Element? = nil) {
        self.head = value == nil ? nil : Place(value: value!)
        self.tail = self.head
    }

    mutating func enqueue(_ value: Element) {
        let next = Place(previous: tail, value: value)

        if length == 0 {
            head = next
        } else {
            tail?.next = next
        }

        tail = next
        length += 1
    }

    mutating func dequeue() -> Element? {
        let next = head?.next
        let value = head?.value

        head?.next = nil
        next?.previous = nil

        head = next
        length = max(0, length - 1)
        return value
    }

    var isEmpty: Bool {
        length == 0
    }

}

extension Queue where Element: Equatable {

    func contains(_ element: Element) -> Bool {
        var place = head
        while place != nil {
            if place!.value == element { return true }
            place = place!.next
        }
        return false
    }
}

extension Queue: CustomStringConvertible {
    var description: String {
        var next = head
        var array: [String] = []
        while next != nil {
            array.append("\(next!.value)")
            next = next!.next
        }

        return array.description
    }
}
