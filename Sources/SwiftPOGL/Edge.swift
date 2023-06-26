//
//  Edge.swift
//  SwiftPOGL
//
//  Created by Tom Drummond on 6/3/23.
//

import Foundation

/// An `Edge` is an unordered pair of `Node` types.
public protocol Edge: Hashable {

    /// The type of the nodes that are connected by the `Edge`
    associatedtype NodeType: Node

    /// The first `Node` in the `Edge` or `Arc`. In an `Arc` this is the source or "from" node.
    var u: NodeType { get }

    /// The second `Node` in the `Edge` or `Arc`. In an `Arc` this is the destination or "to" node.
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
    @inlinable public func isIncident(on node: NodeType) -> Bool {
        u == node || v == node
    }

    /// Returns whether the edge is incident with another edge i.e. if either of the edge's
    /// endpoints are the same as the other edge's endpoints.
    @inlinable public func isIncident(with edge: Self) -> Bool {
        u == edge.u || u == edge.v || v == edge.u || v == edge.v
    }

    /// Returns whether the nodes are the edge's endpoints (in either order)
    @inlinable public func joins(_ u: NodeType, _ v: NodeType) -> Bool {
        (self.u == u && self.v == v) || (self.v == u && self.u == v)
    }

    /// If the edge contains the node this method returns the edge's other node.
    /// Returns nil if the edge doesn't contain the node provided.
    @inlinable public func neighbor(of node: NodeType) -> NodeType? {
        switch node {
        case u: return v
        case v: return u
        default: return nil
        }
    }
}
