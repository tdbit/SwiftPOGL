//
//  Weighted.swift
//  SwiftPOGL
//
//  Created by Tom Drummond on 6/3/23.
//

import Foundation

/// `Weighable` types are both `Hashable` and `Numeric`.
///
/// Swift's ``Numeric``types are all ``Hashable`` but their conformance is defined at the
/// struct level.  We define a `Weighable` typealias that is both `Hashable` and `Numeric`
/// to help with autogeneration of `Hashable` methods for types that conform to the
/// ``Weighted`` protocol.
public typealias Weighable = Hashable & Numeric

/// All `Weighted` types provide a typed numeric weight.
public protocol Weighted<Weight> {

    associatedtype Weight: Hashable & Numeric

    /// The type's read-only numeric weight
    var weight: Weight { get }
}


// MARK: Simple type conformance

extension Double: Weighted {
    public typealias Weight = Self

    public var weight: Self { self }
}
