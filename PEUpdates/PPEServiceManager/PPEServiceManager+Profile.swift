//
//  PPEServiceManager+Profile.swift
//  PEUpdates
//
//  Created by Alexander Snegursky on 1/13/17.
//  Copyright © 2017 Alexander Snegursky. All rights reserved.
//


import Foundation
import AFNetworking


extension PPEServiceManager {
    
    @discardableResult func loadProfile(serverURL: URL?,
                                        success: SuccessBlock?,
                                        failure: FailureBlock?) -> URLSessionDataTask? {
        return sendGET(path: Constants.ServerPaths.Profile,
                       baseURL: serverURL,
                       parameters: nil,
                       sessionManagerConfigurationBlock: nil,
                       success: { (response, data) in
                        PPEServiceResultsHandler.process(response: response,
                                                         data: data,
                                                         expectedResultType: .JSON,
                                                         success: success,
                                                         failure: failure)
        }, progress: nil, failure: failure)
    }
    
    
    @discardableResult func sendProfile(signature: String?,
                                        initials: String?,
                                        serverURL: URL?,
                                        success: SuccessBlock?,
                                        failure: FailureBlock?) -> URLSessionDataTask? {
        let json = String(format: "{ \"SignatureData\" : \"%@\", \"InitialsData\" : \"%@\" }",
                          signature ?? "",
                          initials ?? "")
        
        let parameters = [Constants.Keys.Json: json]
        
        return sendPOST(path: Constants.ServerPaths.Profile,
                        baseURL: serverURL,
                        parameters: parameters,
                        sessionManagerConfigurationBlock: nil,
                        success: { (response, data) in
                            PPEServiceResultsHandler.process(response: response,
                                                             data: data,
                                                             expectedResultType: .JSON,
                                                             success: success,
                                                             failure: failure)
        }, progress: nil, failure: failure)
    }
}
