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
                          Constants.Keys.Password: password]
        
        return self.sendPOST(path: Constants.ServerPaths.Login,
                             baseURL: serverURL,
                             parameters: parameters,
                             sessionManagerConfigurationBlock: { (manager) in
                                manager.requestSerializer = AFHTTPRequestSerializer()
                                manager.responseSerializer = AFHTTPResponseSerializer()
        },
                             success: { (response, data) in
                                let invokeFailure = { (error: Error) in
                                    if let block = failure {
                                        block(response, error)
                                    }
                                }
                                
                                if (data != nil && data is Data && (data as! Data).count > 0) {
                                    let dataString = String(data: data as! Data, encoding: String.Encoding.utf8)
                                    
                                    if (dataString == Constants.Strings.LoggedIn) {
                                        if let block = success {
                                            block(response, dataString)
                                        }
                                    }
                                    else {
                                        invokeFailure(Errors.loginError(string: dataString))
                                    }
                                }
                                else {
                                    invokeFailure(Errors.unexpectedResponseDataStructureError())
                                }
        },
                             progress: nil,
                             failure: failure);
    }
}
