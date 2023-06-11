//
//  Digraph.swift
//  SwiftPOGL
//
//  Created by Tom Drummond on 6/3/23.
//

import Foundation

/// A `Digraph` is a set of Arcs (i.e. directed Edges) and Nodes.
public protocol Digraph: Graph & Reversible where EdgeType: Arc {}
