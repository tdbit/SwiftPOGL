//
//  Graph.swift
//  SwiftPOGL
//
//  Created by Tom Drummond on 6/3/23.
//

import Foundation

/// A `Graph` is a set of Edges and Nodes.
public protocol Graph: Digraph where EdgeType: Edge {}
