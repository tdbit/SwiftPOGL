//
//  GraphFamily.swift
//  SwiftPOGL
//
//  Created by Tom Drummond on 7/6/23.
//

import Foundation

/// `GraphFamily` is an enumeration of simple graph types used for testing.
public enum GraphFamily {

    /// A graph with one or more nodes and no edges.
    case null

    /// A graph where each node is connected to the next node
    /// for a total of `n - 1` edges.
    /// 
    /// ```
    /// e.g. n=5 =>
    /// x-x-x-x-x
    /// ```
    case path

    /// A graph where each node is connected to the next node and the last node
    /// is connected to the first node for a total of `n` edges.
    /// ```
    /// // e.g. n=6 =>
    /// //   x---x
    /// //  /     \
    /// // x       x
    /// //  \     /
    /// //   x---x
    /// ```
    case cycle

    /// A graph where each node is connected to the center node for a total
    /// of `n - 1` edges.
    ///
    /// ```
    /// // e.g. n=7 =>
    /// //  x   x
    /// //   \ /
    /// // x--x--x
    /// //   / \
    /// //  x   x
    /// ```
    case star

    /// A graph where each node is connected to the center node  and to the
    /// nodes to its left and right for a total of `2 * (n - 1)` edges.
    ///
    /// ```
    /// // e.g. n=7 =>
    /// //   x---x
    /// //  / \ / \
    /// // x---x---x
    /// //  \ / \ /
    /// //   x---x
    /// ```
    case wheel

    /// A graph of an even number of nodes arranged in two cycles of equal size
    /// with each node in one cycle connected to its corresponding node in the
    /// other cycle and each node connected to the next node in its cycle for a
    /// total of `3 * n / 2` edges.
    ///
    /// ```
    /// // e.g. n=12 =>
    /// //     x-----x
    /// //    / \   / \ 
    /// //   /   x-x   \
    /// //  /   /   \   \
    /// // x---x     x---x
    /// //  \   \   /   /
    /// //   \   x-x   /
    /// //    \ /   \ /
    /// //     x-----x
    /// ```
    case prism

    /// A graph nodes arranged in a tree structure with each node connected to
    /// one parent node and `k` child nodes for a total of `n - 1` edges.
    ///
    /// ```
    /// // e.g. k=3 =>
    /// //         x
    /// //        /|\
    /// //       x x x
    /// //      /|\ ...
    /// //     x x x ...
    /// ```
    case tree(k: Int)

    /// A rectangular graph with `m * n` nodes where each node is connected to
    /// between 2 and 4 neighbors for a total of `2 * m * n - m - n` edges.
    ///
    /// ```
    /// // e.g. m=3, n=5 =>
    /// // x--x--x--x--x
    /// // |  |  |  |  |
    /// // x--x--x--x--x
    /// // |  |  |  |  |
    /// // x--x--x--x--x
    /// ```
    case mesh(m: Int, n: Int)

    /// A 2-dimensional cycle graph with `m x n` nodes where every node is
    /// connected to 4 neighbours, with edges wrapping around to create a closed
    /// loop in both directions for a total of `2 * m * n` edges.
    /// 
    /// ```
    /// // e.g. m=3, n=5 =>
    /// //   |  |  |  |  |
    /// // --x--x--x--x--x--
    /// //   |  |  |  |  |
    /// // --x--x--x--x--x--
    /// //   |  |  |  |  |
    /// // --x--x--x--x--x--
    /// //   |  |  |  |  |
    /// ```
   case torus(m: Int, n: Int)

    /// A graph where each node is connected to every other node for a total of
    /// `n * (n - 1) / 2` edges in an undirected graph or `n * (n - 1)` edges in
    /// a directed graph.
    case complete
}


extension GraphFamily: CaseIterable {
    /// All graph families.
    public static var allCases: [GraphFamily] {
        [.null, .path, .cycle, .star, .wheel, .prism, .mesh(m: 0, n: 0), .torus(m: 0, n: 0), .complete]
    }

    /// Simple graphs defined by a single parameter which is the number of nodes.
    public static var simpleCases: [GraphFamily] {
        [.null, .path, .cycle, .star, .wheel, .prism, .complete]
    }

    /// Graphs defined by two parameters which represent the number of nodes in different dimensions.
    public static var parametricCases: [GraphFamily] {
        [.mesh(m: 0, n: 0), .torus(m: 0, n: 0)]
    }
}


extension Graph {

    public static func generate(_ family: GraphFamily, nodes: [NodeType]) -> Self {
        switch family {
        case .null:
            return Self(nodes: nodes, edges: [])

        case .path:
            let edges = nodes[1...].indices.map { (nodes[$0 - 1], nodes[$0]) }
            return Self(nodes: nodes, edges: edges)

        case .cycle:
            let edges = nodes.indices.map { (nodes[$0], nodes[($0 + 1) % nodes.count]) }
            return Self(nodes: nodes, edges: edges)

        case .star:
            let edges = nodes.indices.map { (nodes[0], nodes[$0]) }
            return Self(nodes: nodes, edges: Array(edges[1...]))

        case .wheel:
            let starEdges = nodes.indices.map { (nodes[0], nodes[$0]) }
            let cycleNodes = Array(nodes[1...])
            let cycleEdges = cycleNodes.indices.map { (cycleNodes[$0], cycleNodes[($0 + 1) % cycleNodes.count]) }
            return Self(nodes: nodes, edges: starEdges + cycleEdges)

        case .prism:
            guard nodes.count > 5 else {
                fatalError("Prism graphs must have at least 6 nodes.")
            }

            guard nodes.count % 2 == 0 else {
                fatalError("Prism graphs must have an even number of nodes.")
            }

            let m = nodes.count / 2
            var edges: [(NodeType, NodeType)] = []
            edges.reserveCapacity(3 * m / 2)

            for i in 0..<m {
                let j = i + m
                edges.append((nodes[i], nodes[j]))                  // from node in cycle 1 to node in cycle 2
                edges.append((nodes[i], nodes[(i + 1) % m]))        // from node in cycle 1 to next node in cycle 1
                edges.append((nodes[j], nodes[(i + 1) % m + m]))    // from node in cycle 2 to next node in cycle 2
            }
            return Self(nodes: nodes, edges: edges)

        case .tree(let k):
            guard k > 0 else {
                fatalError("Tree graphs must have at least one child per node.")
            }

            var edges: [(NodeType, NodeType)] = []
            edges.reserveCapacity(k * (nodes.count - 1))

            for i in 1..<nodes.count {
                let parent = nodes[(i - 1) / k]
                edges.append((parent, nodes[i]))
            }
            return Self(nodes: nodes, edges: edges)

       case .mesh(let m, let n):
            guard m * n == nodes.count else {
               fatalError("There must be exactly m * n nodes.")
            }

            var edges: [(NodeType, NodeType)] = []
            for i in 0..<m {
                for j in 0..<n {
                    if (j < n - 1) {
                        edges.append((nodes[i * n + j], nodes[i * n + j + 1]))
                    }
                    if (i < m - 1) {
                        edges.append((nodes[i * n + j], nodes[(i + 1) * n + j]))
                    }
                }
            }

           return Self(nodes: nodes, edges: edges)

        case .torus(let m, let n):
            guard m * n == nodes.count else {
               fatalError("There must be exactly m * n nodes.")
            }

            var edges: [(NodeType, NodeType)] = []
            for i in 0..<m {
                for j in 0..<n {
                    edges.append((nodes[i * n + j], nodes[(i * n + j + 1) % n + i * n]))
                    edges.append((nodes[i * n + j], nodes[((i + 1) % m * n)  + j]))
                }
            }

            return Self(nodes: nodes, edges: edges)

        case .complete:
            var edges: [(NodeType, NodeType)] = []
            edges.reserveCapacity(nodes.count * nodes.count)

            for u in nodes {
                for v in nodes {
                    edges.append((u,v))
                }
            }
            return Self(nodes: nodes, edges: edges)
        }
    }
}
