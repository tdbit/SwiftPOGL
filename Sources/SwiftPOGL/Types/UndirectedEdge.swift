//
//  UndirectedEdge.swift
//  SwiftPOGL
//
//  Created by Tom Drummond on 6/12/23.
//

import Foundation

/// An `UndirectedEdge`
public struct UndirectedEdge<T:Node>:Edge {
    public typealias NodeType = T

    public var u: T

    public var v: T

    public init?(_ u: T, _ v: T) {
        guard u != v else { return nil }
        self.u = u
        self.v = v
    }
}


extension UndirectedEdge: CustomStringConvertible {
    public var description: String {
        "(\(u),\(v))"
    }
}
