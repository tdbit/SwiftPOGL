//
//  Reversible.swift
//  SwiftPOGL
//
//  Created by Tom Drummond on 6/11/23.
//

import Foundation


/// A `Reversible` type can provide a reversed version of itself.  What it means to reverse a
/// type and the definition of what a reversed version is will vary by context.  In a graph
/// theory context a directed edge is `Reversible` and the reverse of the edge is a copy of
/// it with the order of its nodes swapped. Similarly a digraph is `Reversible` with the reverse
/// being a copy of the digraph with all its edges reversed.
public protocol Reversible {

    /// Returns the reverse of the type.  What it means to reverse a type will vary by context.
    func reversed() -> Self
}

