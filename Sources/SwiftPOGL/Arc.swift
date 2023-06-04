//
//  Arc.swift
//  SwiftPOGL
//
//  Created by Tom Drummond on 6/3/23.
//

import Foundation

/// An `Arc` is an ordered pair of ``Node`` types.
public protocol Arc<NodeType>: Hashable {
    associatedtype NodeType:Node
    /// The first Node in the Arc i.e. the source or "from" node
    var u: NodeType { get }

    /// The second Node in the Arc i.e. the destination or "to" node
    var v: NodeType { get }

    /// Arc have a failable initializers as some edges may not be valid.
    /// e.g. Arc that are loops are not allowed in a regular graph (i.e. non-multigraph)
    init?(_ u:NodeType, _ v:NodeType)
}


extension Arc {

    // Two Arcs are equal only if the nodes are the same and in the same order
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.u == rhs.u && lhs.v == rhs.v
    }

    // The order of combination matters when hashing an Arc
    public func hash(into hasher: inout Hasher) {
        hasher.combine(u)
        hasher.combine(v)
    }

    /// An Edge is incident with a Node if the node is either of its endpoints.
    public func isIncident(with node:NodeType) -> Bool {
        u == node || v == node
    }
}



// MARK: Convenience methods on Foundation collections

extension Collection where Element: Arc {

    var nodes:Set<Element.NodeType> {
        var nodes:Set<Element.NodeType> = []
        forEach { edge in
            nodes.insert(edge.u)
            nodes.insert(edge.v)
        }
        return nodes
    }
}
