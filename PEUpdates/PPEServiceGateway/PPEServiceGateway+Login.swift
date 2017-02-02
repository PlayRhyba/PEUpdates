//
//  PPEServiceGateway+Login.swift
//  PEUpdates
//
//  Created by Alexander Snegursky on 1/8/17.
//  Copyright © 2017 Alexander Snegursky. All rights reserved.
//


import Foundation


extension PPEServiceGateway {
    
    class func authenticate(email: String,
                            password: String,
                            server: String,
                            success: PPEServiceManager.SuccessBlock?,
                            failure: PPEServiceManager.FailureBlock?) -> Void {
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
        
        PPEServiceManager.sharedInstance.login(email: email, password: password, serverURL: url, success: { (response, data) in
            let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String
            let build = Bundle.main.infoDictionary?[kCFBundleVersionKey as String] as! String
            
            PPEServiceManager.sharedInstance.authorize(version: version, build: build, serverURL: url, success: { (response, data) in
                let authInfo = PPEAuthorizationInfo.init(withDictionary: data as? Dictionary<String, Any>)
                
                if authInfo.isAuthorized() {
                    PPEServiceManager.sharedInstance.loadProfile(serverURL: url, success: { (response, data) in
                        PPEDataStorage.sharedInstance.updateProfile(withDictionary: data as? Dictionary,
                                                                    completion: { (profile) in
                                                                        if let p = profile {
                                                                            invokeSuccess(response, p)
                                                                        }
                                                                        else {
                                                                            invokeFailure(response, Errors.internalError())
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