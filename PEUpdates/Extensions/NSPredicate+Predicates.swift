//
//  NSPredicate+Predicates.swift
//  PEUpdates
//
//  Created by Alexander Snigurskyi on 2017-02-20.
//  Copyright © 2017 Alexander Snegursky. All rights reserved.
//


import Foundation


extension NSPredicate {
    
    class func predicate(spreadID: NSNumber) -> NSPredicate {
        return NSPredicate.init(format: "%K == %@", #keyPath(Weld.spreadID), spreadID)
    }
}
