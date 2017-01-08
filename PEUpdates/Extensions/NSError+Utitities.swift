//
//  NSError+Utitities.swift
//  PEUpdates
//
//  Created by Alexander Snegursky on 1/8/17.
//  Copyright © 2017 Alexander Snegursky. All rights reserved.
//


import Foundation


extension NSError {
    
    func isCanceledRequestOperationError() -> Bool {
        return self.domain == NSURLErrorDomain && self.code == Errors.Constants.NotCompletedOperationErrorCode
    }
}
