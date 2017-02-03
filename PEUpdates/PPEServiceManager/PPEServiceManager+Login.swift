//
//  PPEServiceManager+Login.swift
//  PEUpdates
//
//  Created by Alexander Snegursky on 1/8/17.
//  Copyright © 2017 Alexander Snegursky. All rights reserved.
//


import Foundation
import AFNetworking


extension PPEServiceManager {
    
    @discardableResult func login(email: String,
                                  password: String,
                                  serverURL: URL?,
                                  success: SuccessBlock?,
                                  failure: FailureBlock?) -> URLSessionDataTask? {
        let parameters = [Constants.Keys.Email: email,
                          Constants.Keys.Password: password,
                          Constants.Keys.From: Constants.Strings.iPad]
        
        return self.sendPOST(path: Constants.ServerPaths.Login,
                             baseURL: serverURL,
                             parameters: parameters,
                             sessionManagerConfigurationBlock: nil,
                             success: { (response, data) in
                                PPEServiceResultsHandler.process(response: response,
                                                                 data: data,
                                                                 expectedResultType: .String,
                                                                 success: success,
                                                                 failure: failure)
        }, progress: nil, failure: failure)
    }
    
    
    @discardableResult func authorize(version: String,
                                      build: String,
                                      serverURL: URL?,
                                      success: SuccessBlock?,
                                      failure: FailureBlock?) -> URLSessionDataTask? {
        let parameters = [Constants.Keys.From: Constants.Strings.iPad,
                          Constants.Keys.Version: version,
                          Constants.Keys.Build: build]
        
        return self.sendPOST(path: Constants.ServerPaths.Authorize,
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
