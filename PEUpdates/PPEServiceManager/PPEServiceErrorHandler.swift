//
//  PPEServiceErrorHandler.swift
//  PEUpdates
//
//  Created by Alexander Snegursky on 1/8/17.
//  Copyright © 2017 Alexander Snegursky. All rights reserved.
//


import Foundation


class PPEServiceErrorHandler: NSObject {
    
    class func process(error: Error) -> Error {
        if ((error as NSError).isCanceledRequestOperationError()) {
            return Errors.operationCanceledError()
        }
        
        return error;
    }
}
