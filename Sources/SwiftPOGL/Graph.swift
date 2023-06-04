//
//  Graph.swift
//  SwiftPOGL
//
//  Created by Tom Drummond on 6/3/23.
//

import Foundation

/// A `Graph` is a set of Edges and Nodes.
public protocol Graph<NodeType, EdgeType> where NodeType: Node, EdgeType:Edge, NodeType == EdgeType.NodeType {
    associatedtype NodeType: Node
    associatedtype EdgeType: Edge<NodeType>

    /// The graph's set of nodes
    var nodes: Set<NodeType> { get }

    /// The graph's set of edges
    var edges: Set<EdgeType> { get }

    init(nodes:Set<NodeType>, edges:Set<EdgeType>)

    init(nodes: [NodeType], edges:[(NodeType, NodeType)])
}

