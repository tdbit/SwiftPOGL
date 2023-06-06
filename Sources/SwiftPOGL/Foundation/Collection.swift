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
