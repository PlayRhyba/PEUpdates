//
//  PPEServiceGateway+Login.swift
//  PEUpdates
//
//  Created by Alexander Snegursky on 1/8/17.
//  Copyright © 2017 Alexander Snegursky. All rights reserved.
//


import Foundation


extension PPEServiceGateway {
    
    @discardableResult class func login(email: String,
                                        password: String,
                                        serverURL: URL?,
                                        success: PPEServiceManager.SuccessBlock?,
                                        failure: PPEServiceManager.FailureBlock?) -> URLSessionDataTask? {
        return PPEServiceManager.sharedInstance.login(email: email,
                                                      password: password,
                                                      serverURL: serverURL,
                                                      success: { (response, data) in
                                                        let dataString = data as! String
                                                        
                                                        if (dataString == Constants.Strings.LoggedIn) {
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
                            success: PPEServiceManager.SuccessBlock?,
                            failure: PPEServiceManager.FailureBlock?) {
        let invokeSuccess: PPEServiceManager.SuccessBlock = { (response, data) in
            if let block = success {
                DispatchQueue.main.async {
                    block(response, data)
                }
            }
        }
        
        let invokeFailure: PPEServiceManager.FailureBlock = { (response, error) in
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
            
            let serviceManager = PPEServiceManager.sharedInstance
            let dataStorage = PPEDataStorage.sharedInstance
            
            serviceManager.authorize(version: version, build: build, serverURL: url, success: { (response, data) in
                let authInfo = PPEAuthorizationInfo.init(withDictionary: data as? [String: Any])
                
                if authInfo.isAuthorized() {
                    serviceManager.loadProfile(serverURL: url, success: { (response, data) in
                        dataStorage.updateProfile(withDictionary: data as? Dictionary,
                                                  completion: { (_, error) in
                                                    if (error == nil) {
                                                        let profile = dataStorage.profile()
                                                        invokeSuccess(response, profile)
                                                    }
                                                    else {
                                                        invokeFailure(response, error!)
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
