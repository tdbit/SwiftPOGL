//
//  Digraph+CustomStringConvertible.swift
//  SwiftPOGL
//
//  Created by Tom Drummond on 6/5/23.
//

import Foundation


extension CustomStringConvertible where Self: Digraph {

    public var description: String {
        """
Nodes: \(nodes.description)
Edges: \(edges.description)
"""
    }
}
