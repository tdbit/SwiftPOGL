//
//  Arc.swift
//  SwiftPOGL
//
//  Created by Tom Drummond on 6/3/23.
//

import Foundation

/// An `Arc` is an ordered pair of ``Node`` types.
public protocol Arc: Hashable {

    /// The type of the nodes that are connected by the `Arc`
    associatedtype NodeType:Node

    /// The first Node in the Arc i.e. the source or "from" node
    var u: NodeType { get }

    /// The second Node in the Arc i.e. the destination or "to" node
    var v: NodeType { get }
}


extension Arc {

    // Two arcs are equal if and only if the nodes are the same and in the same order
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.u == rhs.u && lhs.v == rhs.v
    }

    // The order of combination matters when hashing an Arc
    public func hash(into hasher: inout Hasher) {
        hasher.combine(u)
        hasher.combine(v)
    }

    /// Returns whether an edge is incident with one or two nodes i.e. if the node is either of its endpoints.
    public func isIncident(with u:NodeType, and v:NodeType? = nil) -> Bool {
        if let v = v {
            return (self.u == u && self.v == v) || (self.v == u && self.u == v)
        }

        return self.u == u || self.v == u
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
