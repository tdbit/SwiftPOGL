//
//  Graph+Incidence.swift
//  SwiftPOGL
//
//  Created by Tom Drummond on 6/3/23.
//

import Foundation

extension Graph {

    /// The set of edges that are attached to the given node
    func edgesIncident(with node: NodeType) -> Set<EdgeType> {
        edges.filter { $0.isIncident(with: node) }
    }

    /// The degree of a node is the number of edges that are incident with it.
    func degree(of node: NodeType) -> Int {
        edges.reduce(0) { $1.isIncident(with: node) ? $0 + 1 : $0 }
    }

    /// The neighborgood of a node is a graph of all the nodes that are adjacent to it
    /// and the edges that connect them (also known as an induced subgraph). The closed
    /// neighborhood of a node _includes_ the node & its immediate edges.  The open
    /// neighborhood of a node _excludes_ the node & its edges.
    func neighborhood(of node: NodeType, closed: Bool = false) -> Self {
        if(closed) {
            let edges = edgesIncident(with: node)
            let nodes = edges.nodes
            return Self(nodes: nodes, edges: edges)
        }
        else {
            fatalError()
        }
    }

}
