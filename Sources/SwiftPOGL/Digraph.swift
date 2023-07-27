//
//  Digraph.swift
//  SwiftPOGL
//
//  Created by Tom Drummond on 6/3/23.
//

import Foundation

/// A collection of nodes and arcs (i.e. directed edges).
public protocol Digraph: Graph & Reversible where EdgeType: Arc {}


public extension Digraph {

    /// The indegree of a node in a digraph is the number of edges that
    /// come into it i.e. that are directed towards the node
    func inDegree(of node: NodeType) -> Int {
        edges.count(where: { $0.v == node })
    }

    /// The outDegree of a node in a digraph is the number of edges that
    /// go out from it i.e. that are directed away from the node
    func outDegree(of node: NodeType) -> Int {
        edges.count(where: { $0.u == node })
    }
}
