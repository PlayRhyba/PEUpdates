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
        case JSON_H //!!! SHOULD BE REMOVED. NEED TO USE STANDARD JSON PARSER ON SERVER
    }
    
    
    class func process(error: Error) -> Error {
        if (error as NSError).isCanceledRequestOperationError() {
            return Errors.operationCanceledError()
        }
        
        return error
    }
    
    
    class func process(response: HTTPURLResponse,
                       data: Any?,
                       expectedResultType: ExpectedResultType,
                       success: PPEServiceManager.SuccessBlock?,
                       failure: PPEServiceManager.FailureBlock?) {
        if data != nil && data is Data {
            switch expectedResultType {
            case .String:
                let dataString = String(data: data as! Data, encoding: .utf8)
                
                if let value = dataString {
                    success?(response, value)
                }
                else {
                    failure?(response, Errors.unexpectedResponseDataStructureError())
                }
                
            case .JSON:
                do {
                    let dictionary = try JSONSerialization.jsonObject(with: data as! Data,
                                                                      options: []) as? [String: Any]
                    if let value = dictionary {
                        success?(response, value)
                    }
                    else {
                        failure?(response, Errors.unexpectedResponseDataStructureError())
                    }
                }
                catch {
                    failure?(response, error)
                }
                
            case .JSON_H:
                let jString = String(data: data as! Data, encoding: .utf8)
                let cString = jString?.replacingOccurrences(of: "\r\n", with: "")
                let jData = cString?.data(using: .utf8)
                
                process(response: response,
                        data: jData,
                        expectedResultType: .JSON,
                        success: success,
                        failure: failure)
            }
        }
        else {
            failure?(response, Errors.unexpectedResponseDataStructureError())
        }
    }
}
