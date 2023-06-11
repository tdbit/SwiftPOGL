//
//  Arc.swift
//  SwiftPOGL
//
//  Created by Tom Drummond on 6/3/23.
//

import Foundation

/// An `Arc` is an ordered pair of ``Node`` types.
public protocol Arc: Edge {}


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
}


extension Arc {

    /// Returns whether the nodes are the arc's start and end point (in that order)
    public func joins(from u: NodeType, to v:NodeType) -> Bool {
        self.u == u && self.v == v
    }
}
