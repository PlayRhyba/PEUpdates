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
                     completionHandler: @escaping ((Result<String>) -> Void)) {
        let url = URL(string: server)
        
        RequestManager.sharedInstance.login(email: email, password: password, serverURL: url, completionHandler: { (response) in
            if response.result.isFailure {
                completionHandler(Result.failure(response.error!))
            }
            else {
                if response.value == Constants.Strings.LoggedIn {
                    completionHandler(Result.success(response.value!))
                }
                else {
                    completionHandler(Result.failure(Errors.loginError(string: response.value)))
                }
            }
        })
    }
    
    
    class func authenticate(email: String,
                            password: String,
                            server: String,
                            completionHandler: @escaping ((Result<Profile>) -> Void)) {
        let invokeCompletion = { (result: Result<Profile>) in
            DispatchQueue.main.async {
                completionHandler(result)
            }
        }
        
        login(email: email, password: password, server: server) { result in
            if result.isFailure {
                invokeCompletion(Result.failure(result.error!))
            }
            else {
                let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String
                let build = Bundle.main.infoDictionary?[kCFBundleVersionKey as String] as! String
                
                let requestManager = RequestManager.sharedInstance
                let dataStorage = DataStorage.sharedInstance
                let url = URL(string: server)
                
                requestManager.authorize(version: version, build: build, serverURL: url, completionHandler: { response in
                    if response.result.isFailure {
                        invokeCompletion(Result.failure(response.error!))
                    }
                    else {
                        let authInfo = AuthorizationInfo(withDictionary: response.value as? [String: Any])
                        
                        if authInfo.isAuthorized() {
                            requestManager.loadProfile(serverURL: url, completionHandler: { response in
                                if response.result.isFailure {
                                    invokeCompletion(Result.failure(response.error!))
                                }
                                else {
                                    dataStorage.updateProfile(withDictionary: response.value as? Dictionary, completion: { (success, error) in
                                        if !success {
                                            invokeCompletion(Result.failure(error!))
                                        }
                                        else {
                                            if let profile = dataStorage.profile() {
                                                invokeCompletion(Result.success(profile))
                                            }
                                            else {
                                                invokeCompletion(Result.failure(Errors.internalError()))
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
