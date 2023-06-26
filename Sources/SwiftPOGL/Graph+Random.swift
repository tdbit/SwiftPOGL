//
//  Graph+Random.swift
//  SwiftPOGL
//
//  Created by Tom Drummond on 6/3/23.
//

import Foundation

public extension Graph {

    /// A random subgraph (or a random induced subgraph) is a graph formed by a random
    /// subset of the graph's nodes and _all of the edges_ connecting pairs of those nodes.
    func randomSubgraph(order n: Int?) -> Self? {
        let nodes = edges.nodes.randomSubset(count: n)
        let edges = edges.filter { nodes.contains($0.u) && nodes.contains($0.v) }

        return Self(nodes: nodes, edges: edges)
    }

    /// Create an Erdos-Rényi random graph of the given nodes with a probability `p` of
    /// an edge existing between two nodes.
    static func random(from nodes: [NodeType], p: Double) -> Self {
        var edges: [(NodeType, NodeType)] = []
        for i in 0..<nodes.count {
            for j in i+1..<nodes.count {
                if Double.random(in: 0...1) < p {
                    edges.append((nodes[i], nodes[j]))
                }
            }
        }

        return Self(nodes: nodes, edges: edges)
    }
}


public extension Graph where NodeType == Int {

    /// Create an Erdos-Rényi random graph of `n` integer nodes with a probability `p` of
    /// an edge existing between two nodes.
    static func random(n: Int, p: Double) -> Self {
        random(from: Array(1...n), p: p)
    }
}


public extension Graph where NodeType == String {

    /// Create an Erdos-Rényi random graph of `n` string nodes with a probability `p` of
    /// an edge existing between two nodes.  The nodes will be named "A", "B", "C" ...
    /// up to "Z", followed by "AA", "AB" ... up to "ZZ", followed by "AAA", "AAB", and so on. 
    static func random(n: Int, p: Double) -> Self {
        let alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        let length = Array(1...12).first { Int(pow(Double(alphabet.count), Double($0))) >= n } ?? 12
        let bases = Array(0..<length).map { Int(pow(26.0, Double($0))) }.reversed()

        var nodes: [String] = []
        for i in 0..<n {
            let start = alphabet.startIndex
            let offsets = bases.map { (i / $0) % alphabet.count }
            let indexes = offsets.map { alphabet.index(start, offsetBy: $0) }
            let string = indexes.map { "\(alphabet[$0])" }.joined()
            nodes.append(string)
        }

        return random(from: nodes, p: p)
    }
}
