//
//  Arc+Collection.swift
//  SwiftPOGL
//
//  Created by Tom Drummond on 6/18/23.
//

import Foundation


extension Collection where Element: Arc {

    /// Returns the subset of arcs directed out from the node provided.
    public subscript(from node: Element.NodeType) -> Set<Element> {
        Set(filter { $0.u == node })
    }

    /// Returns the subset of arcs directed into the node provided.
    public subscript(into node: Element.NodeType) -> Set<Element> {
        Set(filter { $0.v == node })
    }

    /// Returns the set of nodes downstream of the given node i.e. the set of
    /// nodes that are pointed to by arcs directed out from the given node.  Also
    /// called the down-set, downstream or child nodes.
    public func neighbors(from node: Element.NodeType) -> Set<Element.NodeType> {
        Set(lazy.filter { $0.v == node }.map { $0.u })
    }

    /// Returns the set of nodes upstream of the given node i.e. the set of
    /// nodes with arcs that point in to the given node.  Also called the
    /// up-set, upstream or parent nodes
    public func neighbors(into node: Element.NodeType) -> Set<Element.NodeType> {
        Set(lazy.filter { $0.u == node }.map { $0.v })
    }
}
