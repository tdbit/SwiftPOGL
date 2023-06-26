//
//  DirectedEdge.swift
//  SwiftPOGL
//
//  Created by Tom Drummond on 6/11/23.
//

import Foundation

/// A `DirectedEdge`
public struct DirectedEdge<T: Node>: Arc {
    public typealias NodeType = T

    public var u: T

    public var v: T

    public init?(_ u: T, _ v: T) {
        guard u != v else { return nil }
        self.u = u
        self.v = v
    }
}


extension DirectedEdge: Reversible {
    public func reversed() -> DirectedEdge<T> {
        Self(v, u)!
    }
}


extension DirectedEdge: CustomStringConvertible {
    public var description: String {
        "(\(u),\(v))"
    }
}

