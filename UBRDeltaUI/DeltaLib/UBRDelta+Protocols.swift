//
//  UBRDelta+Protocols.swift
//  UBRDelta
//
//  Created by Karsten Bruns on 17/11/15.
//  Copyright © 2015 bruns.me. All rights reserved.
//

import Foundation

/// This protocol is the foundation for diffing types:
/// It allows UBRDelta to compare instances by determining
/// if instances are a) the same, b) the same with changed properties, c) completly different entities.
public protocol ComparableItem {
    
    /// The uniqued identifier is used to determine if to instances
    /// represent the same set of data
    var uniqueIdentifier: Int { get }
    
    /// Implement this function to determine how two instances relate to another
    /// Are they the same, same but with changed data or completly differtent
    func compareTo(other: ComparableItem) -> ComparisonLevel
    
}


extension ComparableItem {
    
    /// Determines if a property of an item changed compared to another by calling `compareTo(other:)`
    /// The default returned value is `true` if `other` is nil, the result of compareTo is `.Different`
    /// or the property is missed in the dict of `.Changed`
    public func comparedTo(other: ComparableItem?, didPropertyChange property: String) -> Bool {
        guard let other = other else { return true }
        let comparisonLevel = self.compareTo(other)
        switch comparisonLevel {
        case .Same :
            return false
        case .Changed(let changes) :
            return changes[property] ?? true
        default :
            return true
        }
    }
    
}