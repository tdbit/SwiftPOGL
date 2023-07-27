//
//  Graph.swift
//  SwiftPOGL
//
//  Created by Tom Drummond on 6/3/23.
//

import Foundation

/// A collection of nodes and undirected edges.
public protocol Graph: Equatable where NodeType == EdgeType.NodeType {

    /// A type conforming to `Node` that represents the endpoints of the edges
    /// (i.e. the nodes or vertices) in the graph.
    associatedtype NodeType

    /// A type that conforms to `Edge` representing the edges in the graph.
    associatedtype EdgeType: Edge

    /// The graph's `Set` of nodes
    var nodes: Set<NodeType> { get }

    /// The graph's `Set` of edges.
    var edges: Set<EdgeType> { get }

    /// Initialize a graph with a set of nodes and edges.
    init(nodes: Set<NodeType>, edges: Set<EdgeType>)

    /// Initialize a graph with a list of nodes and list of node tuples or pairs.
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


public extension Graph {

    /// The degree of a node in a graph or digraph is the number of edges that
    /// are incident on it i.e. that are connected to the node
    ///
    /// - SeeAlso: ``inDegree(of:)``
    /// - SeeAlso: ``outDegree(of:)``
    func degree(of node: NodeType) -> Int {
        edges.count(where: { $0.isIncident(on: node) })
    }

    /// The neighbors of a node are the set of nodes that it is adjacent to (i.e. that are
    /// connected by an edge).  This always _excludes_ the node provided.
    ///
    /// - SeeAlso: ``neighborhood(of:closed:)``
    func neighbors(of node: NodeType) -> Set<NodeType> {
        edges.neighbors(of: node)
    }

    /// The neighborgood of a node is a graph of all the nodes that are adjacent to it
    /// and the edges that connect them (also known as an induced subgraph). The closed
    /// neighborhood of a node _includes_ the node & its immediate edges.  The open
    /// neighborhood of a node _excludes_ the node & its edges.
    func neighborhood(of node: NodeType, closed: Bool = false) -> Self {
        if closed {
            let edges = edges[of: node]
            let nodes = edges.nodes
            return Self(nodes: nodes, edges: edges)
        } else {
            fatalError()
        }
    }
}
