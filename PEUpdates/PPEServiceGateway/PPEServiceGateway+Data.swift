//
//  PPEServiceGateway+Data.swift
//  PEUpdates
//
//  Created by Alexander Snigurskyi on 2017-02-03.
//  Copyright © 2017 Alexander Snegursky. All rights reserved.
//


import Foundation


extension PPEServiceGateway {
    
    class func loadData(email: String,
                        password: String,
                        server: String,
                        success: PPEServiceManager.SuccessBlock?,
                        failure: PPEServiceManager.FailureBlock?,
                        progress: PPEServiceManager.ProgressBlock?) {
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
        
        let invokeProgress: PPEServiceManager.ProgressBlock = { (p) in
            if let block = progress {
                DispatchQueue.main.async {
                    block(p)
                }
            }
        }
        
        let url = URL(string: server)
        
        self.login(email: email, password: password, serverURL: url, success: { (_, _) in
            PPEServiceManager.sharedInstance.loadJobsSpreads(serverURL: url, success: { (response, data) in
                
                
                //TODO: Load jobs/spreads to DB
                
                
                //TODO: Load welds
                
                
                invokeSuccess(response, data)
                
                
            }, failure: invokeFailure, progress: invokeProgress)
        }, failure: invokeFailure)
    }
}
