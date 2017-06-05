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
        
        RequestManager
            .sharedInstance
            .login(email: email,
                   password: password,
                   serverURL: url,
                   completionHandler: { (response) in
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
        
        login(email: email,
              password: password,
              server: server) { result in
                if result.isFailure {
                    invokeCompletion(Result.failure(result.error!))
                }
                else {
                    let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String
                    let build = Bundle.main.infoDictionary?[kCFBundleVersionKey as String] as! String
                    
                    let requestManager = RequestManager.sharedInstance
                    let dataStorage = DataStorage.sharedInstance
                    let url = URL(string: server)
                    
                    requestManager
                        .authorize(version: version,
                                   build: build,
                                   serverURL: url,
                                   completionHandler: { response in
                                    if response.result.isFailure {
                                        invokeCompletion(Result.failure(response.error!))
                                    }
                                    else {
                                        let authInfo = AuthorizationInfo(withDictionary: response.value as? [String: Any])
                                        
                                        if authInfo.isAuthorized() {
                                            requestManager
                                                .loadProfile(serverURL: url,
                                                             completionHandler: { response in
                                                                if response.result.isFailure {
                                                                    invokeCompletion(Result.failure(response.error!))
                                                                }
                                                                else {
                                                                    dataStorage
                                                                        .updateProfile(withDictionary: response.value as? Dictionary,
                                                                                       completion: { (success, error) in
                                                                                        if success {
                                                                                            if let profile = dataStorage.profile() {
                                                                                                invokeCompletion(Result.success(profile))
                                                                                            }
                                                                                            else {
                                                                                                invokeCompletion(Result.failure(Errors.internalError()))
                                                                                            }
                                                                                        }
                                                                                        else {
                                                                                            invokeCompletion(Result.failure(error!))
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
    
    
    
    
    
    
    
    
    
    @discardableResult class func login(email: String,
                                        password: String,
                                        serverURL: URL?,
                                        success: ServiceManager.SuccessBlock?,
                                        failure: ServiceManager.FailureBlock?) -> URLSessionDataTask? {
        return ServiceManager.sharedInstance.login(email: email,
                                                   password: password,
                                                   serverURL: serverURL,
                                                   success: { (response, data) in
                                                    let dataString = data as! String
                                                    
                                                    if dataString == Constants.Strings.LoggedIn {
                                                        success?(response, dataString)
                                                    }
                                                    else {
                                                        failure?(response, Errors.loginError(string: dataString))
                                                    }
        }, failure: failure)
    }
    
    
    class func authenticate(email: String,
                            password: String,
                            server: String,
                            success: ((Profile) -> Void)?,
                            failure: ServiceManager.FailureBlock?) {
        let invokeSuccess: (Profile) -> Void = { (profile) in
            if let block = success {
                DispatchQueue.main.async {
                    block(profile)
                }
            }
        }
        
        let invokeFailure: ServiceManager.FailureBlock = { (response, error) in
            if let block = failure {
                DispatchQueue.main.async {
                    block(response, error)
                }
            }
        }
        
        let url = URL(string: server)
        
        login(email: email, password: password, serverURL: url, success: { (_, _) in
            let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String
            let build = Bundle.main.infoDictionary?[kCFBundleVersionKey as String] as! String
            
            let serviceManager = ServiceManager.sharedInstance
            let dataStorage = DataStorage.sharedInstance
            
            serviceManager.authorize(version: version, build: build, serverURL: url, success: { (response, data) in
                let authInfo = AuthorizationInfo(withDictionary: data as? [String: Any])
                
                if authInfo.isAuthorized() {
                    serviceManager.loadProfile(serverURL: url, success: { (response, data) in
                        dataStorage.updateProfile(withDictionary: data as? Dictionary,
                                                  completion: { (success, error) in
                                                    if success {
                                                        if let profile = dataStorage.profile() {
                                                            invokeSuccess(profile)
                                                        }
                                                        else {
                                                            invokeFailure(nil, Errors.internalError())
                                                        }
                                                    }
                                                    else {
                                                        invokeFailure(nil, error!)
                                                    }
                        })
                    }, failure: invokeFailure)
                }
                else {
                    invokeFailure(response, Errors.authorizationError(authInfo: authInfo))
                }
            }, failure: invokeFailure)
        }, failure: invokeFailure)
    }
}
