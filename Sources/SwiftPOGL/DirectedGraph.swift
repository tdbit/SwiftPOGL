//
//  SimpleGraph.swift
//  SwiftPOGL
//
//  Created by Tom Drummond on 6/3/23.
//

import Foundation

/// An `DirectedEdge`
struct DirectedEdge<T:Node>:Arc {
    typealias NodeType = T

    var u: T

    var v: T

    init?(_ u: T, _ v: T) {
        guard u != v else { return nil }
        self.u = u
        self.v = v
    }
}


extension DirectedEdge: CustomStringConvertible {
    var description: String {
        "(\(u),\(v))"
    }
}


class DirectedGraph<T:Node>: Digraph {
    typealias NodeType = T

    typealias EdgeType = DirectedEdge<T>

    var nodes: Set<NodeType> = []

    var edges: Set<EdgeType> = []

    required init(nodes: Set<T>, edges: Set<DirectedEdge<T>>) {
        self.nodes = nodes
        self.edges = edges
    }

    required init(nodes: [NodeType], edges: [(NodeType, NodeType)]) {
        self.nodes = Set(nodes)
        self.edges = Set(edges.compactMap { EdgeType($0.0, $0.1) })
    }
}


extension DirectedGraph: CustomStringConvertible {
    var description: String {
        """
Nodes: \(nodes.description)
Edges: \(edges.description)
"""
    }
}
