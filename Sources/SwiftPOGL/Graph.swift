//
//  Graph.swift
//  SwiftPOGL
//
//  Created by Tom Drummond on 6/3/23.
//

import Foundation

/// A `Graph` is a set of Edges and Nodes.
public protocol Graph: Equatable where NodeType == EdgeType.NodeType {

    associatedtype NodeType: Node
    associatedtype EdgeType: Edge

    /// The graph's set of nodes
    var nodes: Set<NodeType> { get }

    /// The graph's set of edges
    var edges: Set<EdgeType> { get }

    init(nodes: Set<NodeType>, edges: Set<EdgeType>)

    init(nodes: [NodeType], edges: [(NodeType, NodeType)])
}


public extension Graph {

    /// The size of a graph or digraph is its number of edges
    var size: Int {
        edges.count
    }

    /// The order of a graph or digraph is its number of nodes
    var order: Int {
        nodes.count
    }
}
