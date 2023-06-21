//
//  Weighted.swift
//  SwiftPOGL
//
//  Created by Tom Drummond on 6/3/23.
//

import Foundation

/// `Weighable` types are `Numeric`, `Comparable`, and `Hashable`.
///
/// Swift's `Numeric`types are all `Hashable` but their conformance is defined at the
/// struct level.  We define a `Weighable` typealias that is `Numeric`, `Comparable`,
/// and `Hashable` to help with autogeneration of `Hashable` methods for types that
/// conform to the `Weighted` protocol.
public typealias Weighable = Numeric & Comparable & Hashable

/// All `Weighted` types provide a typed numeric weight.
public protocol Weighted {

    associatedtype Weight: Weighable

    /// The type's read-only numeric weight
    var weight: Weight { get }
}


// MARK: Default Implementations

extension Numeric where Self: Weighted {
    public typealias Weight = Self
    public var weight: Self { self }
}


extension Equatable where Self: Edge, Self: Weighted {

    static func == (lhs: Self, rhs: Self) -> Bool {
        (lhs.u == rhs.u) &&
        (lhs.v == rhs.v) &&
        (lhs.weight == rhs.weight)
    }

}


extension Comparable where Self: Weighted {

    static func < (lhs: Self, rhs: Self) -> Bool {
        lhs.weight < rhs.weight
    }
}


extension Collection where Element: Weighted {

    public var weight: Element.Weight {
        reduce(into: .zero) { $0 += $1.weight }
    }
}

extension Set: Weighted where Element: Weighted {}

extension Array: Weighted where Element: Weighted {}
