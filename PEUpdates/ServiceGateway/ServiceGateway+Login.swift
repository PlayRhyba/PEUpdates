//
//  ServiceGateway+Login.swift
//  PEUpdates
//
//  Created by Alexander Snegursky on 1/8/17.
//  Copyright © 2017 Alexander Snegursky. All rights reserved.
//


import Foundation


extension ServiceGateway {
    
    class func login(email: String,
                     password: String,
                     server: String,
                     completionHandler: @escaping ((OperationResult<String>) -> Void)) {
        let url = URL(string: server)
        
        RequestManager.sharedInstance.login(email: email, password: password, serverURL: url, completionHandler: { (response) in
            if response.result.isFailure {
                completionHandler(OperationResult.failure(response.error!))
            }
            else {
                if response.value == Constants.Strings.LoggedIn {
                    completionHandler(OperationResult.success(response.value!))
                }
                else {
                    completionHandler(OperationResult.failure(Errors.loginError(string: response.value)))
                }
            }
        })
    }
    
    
    class func authenticate(email: String,
                            password: String,
                            server: String,
                            completionHandler: @escaping ((OperationResult<Profile>) -> Void)) {
        let invokeCompletion = { (result: OperationResult<Profile>) in
            DispatchQueue.main.async {
                completionHandler(result)
            }
        }
        
        login(email: email, password: password, server: server) { result in
            if result.isFailure {
                invokeCompletion(OperationResult.failure(result.error!))
            }
            else {
                let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String
                let build = Bundle.main.infoDictionary?[kCFBundleVersionKey as String] as! String
                
                let requestManager = RequestManager.sharedInstance
                let dataStorage = DataStorage.sharedInstance
                let url = URL(string: server)
                
                requestManager.authorize(version: version, build: build, serverURL: url, completionHandler: { response in
                    if response.result.isFailure {
                        invokeCompletion(OperationResult.failure(response.error!))
                    }
                    else {
                        let authInfo = AuthorizationInfo(withDictionary: response.value as? [String: Any])
                        
                        if authInfo.isAuthorized() {
                            requestManager.loadProfile(serverURL: url, completionHandler: { response in
                                if response.result.isFailure {
                                    invokeCompletion(OperationResult.failure(response.error!))
                                }
                                else {
                                    dataStorage.updateProfile(withDictionary: response.value as? Dictionary, completionHandler: { result in
                                        if result.isFailure {
                                            invokeCompletion(OperationResult.failure(result.error!))
                                        }
                                        else {
                                            if let profile = dataStorage.profile() {
                                                invokeCompletion(OperationResult.success(profile))
                                            }
                                            else {
                                                invokeCompletion(OperationResult.failure(Errors.internalError()))
                                            }
                                        }
                                    })
                                }
                            })
                        }
                    }
                })
            }
        }
    }
}
