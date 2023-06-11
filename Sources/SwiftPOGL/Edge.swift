//
//  Edge.swift
//  SwiftPOGL
//
//  Created by Tom Drummond on 6/3/23.
//

import Foundation

/// An `Edge` is an unordered pair of `Node` types.
public protocol Edge: Hashable {

    /// The type of the nodes that are connected by the `Arc`
    associatedtype NodeType:Node

    /// The first Node in the Arc i.e. the source or "from" node
    var u: NodeType { get }

    /// The second Node in the Arc i.e. the destination or "to" node
    var v: NodeType { get }
}


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


extension Edge {

    /// Returns whether an edge is incident on a node i.e. if the node is either of its endpoints.
    public func isIncident(on u:NodeType) -> Bool {
        self.u == u || self.v == u
    }

    /// Returns whether the nodes are the edge's endpoints (in either order)
    public func joins(_ u: NodeType, _ v:NodeType) -> Bool {
        (self.u == u && self.v == v) || (self.v == u && self.u == v)
    }

    /// If the edge contains the node this method returns the edge's other node.
    /// Returns nil if the edge doesn't contain the node provided.
    public func neighbor(of node: NodeType) -> NodeType? {
        switch(node) {
        case u: return v
        case v: return u
        default: return nil
        }
    }
}
