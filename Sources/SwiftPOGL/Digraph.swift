//
//  Digraph.swift
//  SwiftPOGL
//
//  Created by Tom Drummond on 6/3/23.
//

import Foundation

/// A `Digraph` is a set Arcs (i.e. directed Edges) and Nodes.
protocol Digraph<NodeType, EdgeType> where NodeType: Node, EdgeType:Arc, NodeType == EdgeType.NodeType {
    associatedtype NodeType: Node
    associatedtype EdgeType: Arc<NodeType>

    /// The graph's set of nodes
    var nodes: Set<NodeType> { get }

    /// The graph's set of edges
    var edges: Set<EdgeType> { get }

    init(nodes:Set<NodeType>, edges:Set<EdgeType>)

    init(nodes: [NodeType], edges:[(NodeType, NodeType)])
}
