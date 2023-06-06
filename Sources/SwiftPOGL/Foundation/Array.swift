//
//  Array.swift
//  SwiftPOGL
//
//  Created by Tom Drummond on 6/5/23.
//

import Foundation


extension Array where Element: Hashable {

    /// Returns a tuple containing two distinct random elements from the array.
    /// Will return nil if the array has less than two distinct elements.
    ///
    /// - SeeAlso: ``randomPair()``
    public func randomDistinctPair() -> (Element, Element)? {
        Set(self).randomDistinctPair()
    }

    /// Returns a `count`-sized array of pairs (i.e. 2-tuples) containing strictly distinct
    /// random elements from the collection. If `count` is nil the size of the array will be
    /// random.
    /// 
    /// The elements in each pair are guaranteed to be distinct even if the array contains
    /// repeated values.  Each pair is not guaranteed to be distinct from all the other
    /// pairs in the array.  Will return nil if the source array has less than two distinct
    /// elements.  Elements must conform to ``Hashable``
    ///
    /// - SeeAlso: ``randomDistinctPair()``
    public func randomDistinctPairs(count n: Int? = nil) -> [(Element, Element)] {
        guard let n = n else {
            let count = Set(self).count
            let max = count * (count - 1) / 2
            let n = Int.random(in: 1...max)
            return randomDistinctPairs(count: n)
        }
        
        let set = Set(self)
        var array:[(Element, Element)] = []
        while let pair = set.randomDistinctPair(), array.count < n {
            array.append(pair)
        }

        return array
    }
}
