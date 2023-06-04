//
//  Digraph.swift
//  SwiftPOGL
//
//  Created by Tom Drummond on 6/3/23.
//

import Foundation

/// A `Digraph` is a set of Arcs (i.e. directed Edges) and Nodes.
public protocol Digraph<NodeType, EdgeType> where NodeType: Node, EdgeType:Arc, NodeType == EdgeType.NodeType {
    associatedtype NodeType: Node
    associatedtype EdgeType: Arc<NodeType>

    /// The graph's set of nodes
    var nodes: Set<NodeType> { get }

    /// The graph's set of edges
    var edges: Set<EdgeType> { get }

    init(nodes:Set<NodeType>, edges:Set<EdgeType>)

    init(nodes: [NodeType], edges:[(NodeType, NodeType)])
}


public extension Digraph {

    /// The size of a graph or digraph is its number of edges
    var size: Int {
        edges.count
    }

    /// The order of a graph or digraph is its number of nodes
    var order: Int {
        nodes.count
    }
}
