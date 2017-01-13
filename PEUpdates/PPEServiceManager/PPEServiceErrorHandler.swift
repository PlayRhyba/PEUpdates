//
//  PPEServiceErrorHandler.swift
//  PEUpdates
//
//  Created by Alexander Snegursky on 1/8/17.
//  Copyright © 2017 Alexander Snegursky. All rights reserved.
//


import Foundation


class PPEServiceResultsHandler: NSObject {
    enum ExpectedResultType {
        case String
        case JSON
    }
    
    
    class func process(error: Error) -> Error {
        if ((error as NSError).isCanceledRequestOperationError()) {
            return Errors.operationCanceledError()
        }
        
        return error
    }
    
    
    class func process(response: HTTPURLResponse,
                       data: Any?,
                       expectedResultType: ExpectedResultType,
                       success: PPEServiceManager.SuccessBlock?,
                       failure: PPEServiceManager.FailureBlock?) -> Void {
        let invokeSuccess = { (data: Any) in
            if let block = success {
                block(response, data)
            }
        }
        
        let invokeFalure = { (error: Error) in
            if let block = failure {
                block(response, error)
            }
        }
        
        if (data != nil && data is Data) {
            switch expectedResultType {
            case .String:
                let dataString = String(data: data as! Data, encoding: .utf8)
                
                if let value = dataString {
                    invokeSuccess(value)
                }
                else {
                    invokeFalure(Errors.unexpectedResponseDataStructureError())
                }
                
            case .JSON:
                do {
                    let dictionary = try JSONSerialization.jsonObject(with: data as! Data,
                                                                      options: []) as? [String: Any]
                    if let value = dictionary {
                        invokeSuccess(value)
                    }
                    else {
                        invokeFalure(Errors.unexpectedResponseDataStructureError())
                    }
                }
                catch {
                    invokeFalure(error)
                }
            }
        }
        else {
            invokeFalure(Errors.unexpectedResponseDataStructureError())
        }
    }
}
