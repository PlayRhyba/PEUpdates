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
        
        let serviceManager = PPEServiceManager.sharedInstance
        let dataStorage = PPEDataStorage.sharedInstance
        
        login(email: email, password: password, serverURL: url, success: { (_, _) in
            serviceManager.loadJobsSpreads(serverURL: url, success: { (response, data) in
                dataStorage.saveJobsSpreadsData(withDictionary: data as? Dictionary, completion: { (_, error) in
                    if error == nil {
                        if let spreads = dataStorage.spreads() {
                            
                            
                            
                            
                            
                            
                            
                            //For test only //!!!
                            
                            
                            let fs = spreads.first
                            let spreadID = (fs?.spreadID)!
                            
                            serviceManager.loadWeldData(spreadID: spreadID, serverURL: url, success: { (response, data) in
                                dataStorage.saveWeldData(withDictionary: data as? Dictionary, spreadID: spreadID, completion: { (_, error) in
                                    if (error == nil) {
                                        let welds = dataStorage.welds(spreadID: spreadID)
                                        
                                        NSLog("WELDS: %@", welds ?? "")
                                        
                                        invokeSuccess(response, data)
                                        
                                    }
                                    else {
                                        invokeFailure(response, error!)
                                    }
                                })
                                
                            }, failure: invokeFailure, progress: invokeProgress)
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            //TODO: Load welds
                            
                            
                        }
                        else {
                            invokeFailure(response, Errors.weldDataUnavailableError())
                        }
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                    }
                    else {
                        invokeFailure(response, error!)
                    }
                })
            }, failure: invokeFailure, progress: invokeProgress)
        }, failure: invokeFailure)
    }
}
