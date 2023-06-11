//
//  Digraph+Reversible.swift
//  SwiftPOGL
//
//  Created by Tom Drummond on 6/11/23.
//

import Foundation


extension Reversible where Self: Digraph {

    /// Returns the reverse or transpose of the digraph which is a directed graph on the
    /// same set of nodes with the direction or orientation of each directed edge reversed.
    public func reversed() -> Self {
        let reversedNodes = nodes
        let reversedEdges = Set(edges.map { $0.reversed() })
        return Self(nodes: reversedNodes, edges: reversedEdges)
    }
}
