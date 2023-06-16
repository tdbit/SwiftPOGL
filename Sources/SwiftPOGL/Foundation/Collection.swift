//
//  Collection.swift
//  SwiftPOGL
//
//  Created by Tom Drummond on 6/5/23.
//

import Foundation


extension Collection {

    /// Returns a tuple containing two random elements from the collection that may
    /// be identical.
    ///
    /// Will return nil if the collection is empty.
    /// 
    /// - SeeAlso: ``randomDistinctPair()``
    public func randomPair() -> (Element, Element)? {
        switch count {
        case 0: return nil
        case 1: return (self.first!, self.first!)
        default: return (randomElement()!, randomElement()!)
        }
    }
}


extension Collection where Element: Equatable {

    /// Returns a tuple containing two distinct random elements from the collection.
    /// Will return nil if the collection has less than two distinct elements.
    ///
    /// Elements must conform to `Equatable`
    ///
    /// - SeeAlso: ``randomPair()``
    public func randomDistinctPair() -> (Element, Element)? {
        switch count {
        case 0, 1:
            return nil

        default:
            let array = shuffled()
            let u = array[0]
            for v in array[1...] {
                if (v != u) { return (u,v) }
            }
            return nil
        }
    }


    /// Returns a `count`-sized array of pairs (i.e. 2-tuples) containing strictly distinct
    /// random elements from the collection.  If `count` is nil will return a random number
    /// of distinct pairs between 0 and twice the size of the collection.
    ///
    /// The elements in each pair are guaranteed to be distinct even if the array contains
    /// repeated values.  Each pair is not guaranteed to be distinct from all the other
    /// pairs in the array.  Will return nil if the source array has less than two distinct
    /// elements.  Elements must conform to `Equatable`
    ///
    /// - SeeAlso: ``randomDistinctPair()``
    public func randomDistinctPairs(count n: Int? = nil) -> [(Element, Element)] {
        let pairs = n ?? Int.random(in: 0...(2 * self.count))
        var array:[(Element, Element)] = []
        while let uv = randomDistinctPair(), array.count < pairs {
            array.append(uv)
        }
        return array
    }
}
