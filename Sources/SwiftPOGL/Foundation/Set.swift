//
//  Set.swift
//  SwiftPOGL
//
//  Created by Tom Drummond on 6/5/23.
//

import Foundation


extension Set {

    /// Returns a random subset of elements in the set.
    ///
    /// If `count` is nil the size of the subset will be random from 0 to the size of
    /// the original set. If `count` is greater than the size of the original set it
    /// will return the whole set.  If count is negative will return an empty set.
    public func randomSubset(count n: Int?) -> Self {
        let size = n ?? Int.random(in: 0...count)
        let bound = Swift.min(Swift.max(0, size), count)
        return Set(shuffled()[0..<bound])
    }
}
