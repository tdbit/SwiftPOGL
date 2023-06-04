//
//  GraphLayout.swift
//  SwiftPOGL
//
//  Created by Tom Drummond on 6/3/23.
//

import Foundation

/// A `GraphLayout` lays out and stores the positions of a graph's nodes in a given frame.
public protocol GraphLayout<GraphType> where GraphType: Graph {

    associatedtype GraphType

    /// Compute the positions of the nodes in the graph within the provided frame
    func layout(graph: GraphType, in frame: CGRect)

    /// Move a node to a specific point
    func move(node: GraphType.NodeType, to point: CGPoint)

    /// Returns the co-ordinates of the node in the layout's frame
    func position(for node: GraphType.NodeType) -> CGPoint

    init()
}
