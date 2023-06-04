//
//  Edge.swift
//  SwiftPOGL
//
//  Created by Tom Drummond on 6/3/23.
//

import Foundation

/// An `Edge` is an unordered pair of `Node` types.
public protocol Edge<NodeType>: Arc {}

extension Edge {

    // Two Edges are equal if their nodes are the same in any order
    public static func == (lhs: Self, rhs: Self) -> Bool {
        (lhs.u == rhs.u && lhs.v == rhs.v) ||
        (lhs.u == rhs.v && lhs.v == rhs.u)
    }

    // The order of the nodes does not matter when generating a hash value
    public func hash(into hasher: inout Hasher) {
        hasher.combine(u.hashValue ^ v.hashValue)
    }
}


// MARK: Convenience methods on Foundation collections

extension Set where Element: Edge {

    public subscript(of node: Element.NodeType) -> Set<Element> {
        filter { $0.u == node || $0.v == node }
    }
}

