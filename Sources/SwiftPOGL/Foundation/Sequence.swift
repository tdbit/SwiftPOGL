//
//  Sequence.swift
//  SwiftPOGL
//
//  Created by Tom Drummond on 6/12/23.
//

import Foundation


extension Sequence {

    /// Returns the count of elements in the sequence that satisfy the given predicate.
    @inlinable public func count(where predicate: (Element) throws -> Bool) rethrows -> Int {
        try reduce(0) { try predicate($1) ?  $0 + 1 : $0 }
    }
}
