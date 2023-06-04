//
//  GraphLayout.swift
//  SwiftPOGL
//
//  Created by Tom Drummond on 6/3/23.
//

import Foundation

/// A `GraphLayout` lays out a graph of nodes and edges in a frame.  The frame is
public protocol GraphLayout<GraphType> where GraphType: Graph {

    associatedtype GraphType

    /// The area in which the graph should be laid out.
    var frame: CGRect { get set }

    /// Recompute the positions of the nodes in the graph with the layout's frame
    func layout(graph: GraphType)

    /// Move a node to a specific point
    func move(node: GraphType.NodeType, to point: CGPoint)

    /// Returns the co-ordinates of the node in the layout's frame
    func position(for node: GraphType.NodeType) -> CGPoint

}
