//
//  SimpleGraph.swift
//  SwiftPOGL
//
//  Created by Tom Drummond on 6/3/23.
//

import Foundation

/// An `DirectedEdge`
public struct DirectedEdge<T:Node>:Arc {
    public typealias NodeType = T

    public var u: T

    public var v: T

    public init?(_ u: T, _ v: T) {
        guard u != v else { return nil }
        self.u = u
        self.v = v
    }
}


extension DirectedEdge: CustomStringConvertible {
    public var description: String {
        "(\(u),\(v))"
    }
}


public class DirectedGraph<T:Node>: Digraph {
    public typealias NodeType = T

    public typealias EdgeType = DirectedEdge<T>

    public var nodes: Set<NodeType> = []

    public var edges: Set<EdgeType> = []

    public required init(nodes: Set<T>, edges: Set<DirectedEdge<T>>) {
        self.nodes = nodes
        self.edges = edges
    }

    public required init(nodes: [NodeType], edges: [(NodeType, NodeType)]) {
        self.nodes = Set(nodes)
        self.edges = Set(edges.compactMap { EdgeType($0.0, $0.1) })
    }
}


extension DirectedGraph: CustomStringConvertible {
    public var description: String {
        """
Nodes: \(nodes.description)
Edges: \(edges.description)
"""
    }
}
