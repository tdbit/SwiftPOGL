//
//  DefaultLayout.swift
//  SwiftPOGL
//
//  Created by Tom Drummond on 6/3/23.
//

import Foundation

/// The `DefaultLayout` lays out a graph as an ordered circle of nodes.
public class DefaultLayout<T: Graph>: GraphLayout {
    public typealias GraphType = T

    internal var positions:[GraphType.NodeType: CGPoint] = [:]

    public var frame: CGRect = CGRect()

    public func layout(graph: T) {
        guard frame.size.width * frame.size.height > 0 else {
            fatalError("Unable to layout graph in zero-sized frame")
        }

        let borderWidth = 0.05 * max(frame.size.width, frame.size.height)
        let radius = min(frame.size.height, frame.size.width) / 2 - borderWidth
        let delta = CGFloat( 2.0 * Double.pi) / CGFloat(graph.nodes.count)
        var theta:CGFloat = .zero

        for node in graph.nodes {
            let xOrigin = frame.origin.x + frame.size.width / 2
            let yOrigin = frame.origin.y + frame.size.height / 2
            let x = xOrigin + radius * sin(theta)
            let y = yOrigin + radius * cos(theta)
            positions[node] = CGPoint(x: x, y: y)
            theta += delta
        }
    }

    public func position(for node: T.NodeType) -> CGPoint {
        positions[node]!
    }

}

