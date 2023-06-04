//
//  Labelled.swift
//  SwiftPOGL
//
//  Created by Tom Drummond on 6/3/23.
//

import Foundation

/// A `Labelled` type provides a string label.
protocol Labelled {

    /// The type's read-only string label.
    var label: String { get }
}


// MARK: Simple type protocol conformance

extension String: Labelled {
    var label: String { self }
}

extension Int: Labelled {
    var label: String { description }
}


// MARK: Convenience methods on Foundation collections

extension Collection where Element: Labelled {
    var labels:[String] {
        map(\.label)
    }
}
