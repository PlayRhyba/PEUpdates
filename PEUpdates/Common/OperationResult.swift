//
//  OperationResult.swift
//  PEUpdates
//
//  Created by Alexander Snigurskyi on 2017-06-06.
//  Copyright © 2017 Alexander Snegursky. All rights reserved.
//


import Foundation


enum OperationResult<Value> {
    
    case success(Value)
    case failure(Error)
    
    
    var isSuccess: Bool {
        switch self {
        case .success: return true
        case .failure: return false
        }
    }
    
    
    var isFailure: Bool {
        return !isSuccess
    }
    
    
    var value: Value? {
        switch self {
        case .success(let value): return value
        case .failure: return nil
        }
    }
    
    
    var error: Error? {
        switch self {
        case .success: return nil
        case .failure(let error): return error
        }
    }
}


//MARK:  CustomStringConvertible, CustomDebugStringConvertible


extension OperationResult: CustomStringConvertible, CustomDebugStringConvertible {
    
    var description: String {
        switch self {
        case .success:
            return "SUCCESS"
        case .failure:
            return "FAILURE"
        }
    }
    
    
    var debugDescription: String {
        switch self {
        case .success(let value):
            return "SUCCESS: \(value)"
        case .failure(let error):
            return "FAILURE: \(error)"
        }
    }
}
