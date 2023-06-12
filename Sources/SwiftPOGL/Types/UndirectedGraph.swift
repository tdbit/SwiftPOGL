//
//  UndirectedGraph.swift
//  SwiftPOGL
//
//  Created by Tom Drummond on 6/3/23.
//

import Foundation


open class UndirectedGraph<T:Node>: Graph {
    public typealias NodeType = T

    public typealias EdgeType = UndirectedEdge<T>

    public var nodes: Set<NodeType> = []

    public var edges: Set<EdgeType> = []

    public required init(nodes: Set<T>, edges: Set<UndirectedEdge<T>>) {
        self.nodes = nodes
        self.edges = edges
    }

    public required init(nodes: [NodeType], edges: [(NodeType, NodeType)]) {
        self.nodes = Set(nodes)
        self.edges = Set(edges.compactMap { EdgeType($0.0, $0.1) })
    }
}


extension UndirectedGraph: CustomStringConvertible {}
