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

    /// If the edge contains the node this method returns the edge's other node.
    /// Returns nil if the edge doesn't contain the node provided.
    public func neighbor(of node: NodeType) -> NodeType? {
        switch(node){
        case u: return v
        case v: return u
        default: return nil
        }
    }
}



// MARK: Convenience methods on Foundation collections

extension Collection where Element: Arc {

    /// Returns the subset of edges that include the node provided.
    public subscript(of node: Element.NodeType) -> Set<Element> {
        Set(filter { $0.u == node || $0.v == node })
    }

    /// Returns the set of nodes a collection of edges is connected to.
    var nodes:Set<Element.NodeType> {
        var nodes:Set<Element.NodeType> = []
        forEach { edge in
            nodes.insert(edge.u)
            nodes.insert(edge.v)
        }
        return nodes
    }

   /// Returns the set of neighboring nodes to the given node from a collection of edges.
   func neighbors(of node: Element.NodeType) -> Set<Element.NodeType> {
        Set(compactMap { $0.neighbor(of:node) })
    }
}
