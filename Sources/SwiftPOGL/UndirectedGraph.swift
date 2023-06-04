//
//  SimpleGraph.swift
//  SwiftPOGL
//
//  Created by Tom Drummond on 6/3/23.
//

import Foundation

/// An `UndirectedEdge` 
struct UndirectedEdge<T:Node>:Edge {
    typealias NodeType = T

    var u: T

    var v: T

    init?(_ u: T, _ v: T) {
        guard u != v else { return nil }
        self.u = u
        self.v = v
    }
}


extension UndirectedEdge: CustomStringConvertible {
    var description: String {
        "(\(u),\(v))"
    }
}


class UndirectedGraph<T:Node>: Graph {
    typealias NodeType = T

    typealias EdgeType = UndirectedEdge<T>

    var nodes: Set<NodeType> = []

    var edges: Set<EdgeType> = []

    required init(nodes: Set<T>, edges: Set<UndirectedEdge<T>>) {
        self.nodes = nodes
        self.edges = edges
    }

    required init(nodes: [NodeType], edges: [(NodeType, NodeType)]) {
        self.nodes = Set(nodes)
        self.edges = Set(edges.compactMap { EdgeType($0.0, $0.1) })
    }
}


extension UndirectedGraph: CustomStringConvertible {
    var description: String {
        """
Nodes: \(nodes.description)
Edges: \(edges.description)
"""
    }
}
