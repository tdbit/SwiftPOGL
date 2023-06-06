//
//  Collection.swift
//  SwiftPOGL
//
//  Created by Tom Drummond on 6/5/23.
//

import Foundation


extension Set {

    /// Returns a tuple containing two distinct random elements from the set.
    /// Will return nil if the set has less than two elements.
    ///
    /// - SeeAlso: ``randomPair()``
    public func randomDistinctPair() -> (Element, Element)? {
        guard count > 1 else {
            return nil
        }

        let u = randomElement()
        var v = randomElement()
        while u == v { v = randomElement() }

        return (u!,v!)
    }
    
    /// Returns a random subset of elements in the set.
    ///
    /// If `count` is greater than the size of the set will return the whole set.
    /// If `count` is nil the size of the subset will be random.  If count is negative
    /// will return an empty set.
    public func randomSubset(count n: Int?) -> Self {
        guard let n = n else {
            let n = Int.random(in: 0...count)
            return randomSubset(count: n)
        }

        if (n < count) {
            var subset: Self = []
            while subset.count < n {
                subset.insert(randomElement()!)
            }
            return subset
        }

        return Self(self)
    }
}
