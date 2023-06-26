//
//  Graph+Incidence.swift
//  SwiftPOGL
//
//  Created by Tom Drummond on 6/3/23.
//

import Foundation


extension Graph {

    /// The neighbors of a node are the set of nodes that it is adjacent to (i.e. that are
    /// connected by an edge).  This always _excludes_ the node provided.
    ///
    /// - SeeAlso: ``neighborhood(of:closed:)``
    public func neighbors(of node: NodeType) -> Set<NodeType> {
        edges.neighbors(of: node)
    }

    /// The neighborgood of a node is a graph of all the nodes that are adjacent to it
    /// and the edges that connect them (also known as an induced subgraph). The closed
    /// neighborhood of a node _includes_ the node & its immediate edges.  The open
    /// neighborhood of a node _excludes_ the node & its edges.
    public func neighborhood(of node: NodeType, closed: Bool = false) -> Self {
        if closed {
            let edges = edges[of: node]
            let nodes = edges.nodes
            return Self(nodes: nodes, edges: edges)
        } else {
            fatalError()
        }
    }
}
