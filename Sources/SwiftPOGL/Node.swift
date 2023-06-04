//
//  Node.swift
//  SwiftPOGL
//
//  Created by Tom Drummond on 6/3/23.
//

import Foundation

/// `Vertex` is a typealias to ``Node``
typealias Vertex = Node

/// A `Node` or ``Vertex`` is a basic building block for any graph.
///
/// Any `Hashable` type can be a `Node`.
public protocol Node: Hashable {}

// MARK: Simple type protocol conformance

extension Int: Node {}

extension String: Node {}
