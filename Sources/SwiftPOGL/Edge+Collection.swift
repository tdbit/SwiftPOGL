//
//  Edge+Collection.swift
//  SwiftPOGL
//
//  Created by Tom Drummond on 6/3/23.
//

import Foundation


extension Collection where Element: Edge {

    /// Returns the subset of edges that include the node provided.
    public subscript(of node: Element.NodeType) -> Set<Element> {
        Set(filter { $0.u == node || $0.v == node })
    }

    /// Returns the set of nodes a collection of edges is connected to.
    var nodes: Set<Element.NodeType> {
        var nodes: Set<Element.NodeType> = []
        forEach { edge in
            nodes.insert(edge.u)
            nodes.insert(edge.v)
        }
        return nodes
    }

   /// Returns the set of neighboring nodes to the given node from a collection of edges.
   func neighbors(of node: Element.NodeType) -> Set<Element.NodeType> {
        Set(compactMap { $0.neighbor(of: node) })
    }
}
