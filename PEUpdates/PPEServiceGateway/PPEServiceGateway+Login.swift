//
//  PPEServiceGateway+Login.swift
//  PEUpdates
//
//  Created by Alexander Snegursky on 1/8/17.
//  Copyright © 2017 Alexander Snegursky. All rights reserved.
//


import Foundation


extension PPEServiceGateway {
    
    class func login(email: String,
                     password: String,
                     server: String,
                     success: PPEServiceManager.SuccessBlock?,
                     failure: PPEServiceManager.FailureBlock?) -> Void {
        PPEServiceManager.sharedInstance.login(email: email,
                                               password: password,
                                               serverURL: URL(string: server),
                                               success: { (response, data) in
                                                if let block = success {
                                                    DispatchQueue.main.async {
                                                        block(response, data)
                                                    }
                                                }
        },
                                               failure: { (response, error) in
                                                if let block = failure {
                                                    DispatchQueue.main.async {
                                                        block(response, error)
                                                    }
                                                }
        })
    }
}
