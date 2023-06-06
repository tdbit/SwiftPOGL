//
//  Equatable.swift
//  SwiftPOGL
//
//  Created by Tom Drummond on 6/4/23.
//

import Foundation


extension Equatable where Self: Digraph {

    public static func == (lhs: Self, rhs: Self) -> Bool {
        (lhs.nodes == rhs.nodes) && (lhs.edges == rhs.edges)
    }
}
