//
//  ServiceErrorHandler.swift
//  PEUpdates
//
//  Created by Alexander Snegursky on 1/8/17.
//  Copyright © 2017 Alexander Snegursky. All rights reserved.
//


import Foundation


class ServiceResultsHandler: NSObject {
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
                       success: ServiceManager.SuccessBlock?,
                       failure: ServiceManager.FailureBlock?) {
        if data != nil && data is Data {
            switch expectedResultType {
            case .String:
                if let dataString = String(data: data as! Data, encoding: .utf8) {
                    success?(response, dataString)
                }
                else {
                    failure?(response, Errors.unexpectedResponseDataStructureError())
                }
                
            case .JSON:
                do {
                    if let dictionary = try JSONSerialization.jsonObject(with: data as! Data,
                                                                         options: []) as? [String: Any] {
                        success?(response, dictionary)
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
