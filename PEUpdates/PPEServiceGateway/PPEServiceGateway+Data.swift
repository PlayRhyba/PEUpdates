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
                        success: (() -> Void)?,
                        failure: PPEServiceManager.FailureBlock?,
                        progress: PPEServiceManager.ProgressBlock?) {
        let invokeSuccess = {
            if let block = success {
                DispatchQueue.main.async {
                    block()
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
                            DispatchQueue.global().async {
                                var dictionaries = Array<[String: Any]>()
                                var lastResponse: HTTPURLResponse?
                                var lastError: Error?
                                
                                for spread in spreads {
                                    let spreadID = spread.spreadID!
                                    let semaphore = DispatchSemaphore(value: 0)
                                    
                                    lastError = nil
                                    lastResponse = nil
                                    
                                    serviceManager.loadWeldData(spreadID: spreadID, serverURL: url, success: { (response, data) in
                                        lastResponse = response
                                        
                                        if let dictionary = data as? [String: Any] {
                                            dictionaries.append(dictionary)
                                        }
                                        else {
                                            lastError = Errors.unexpectedResponseDataStructureError()
                                        }
                                        
                                        semaphore.signal()
                                    }, failure: { (response, error) in
                                        lastResponse = response
                                        lastError = error
                                        
                                        semaphore.signal()
                                    }, progress: invokeProgress)
                                    
                                    _ = semaphore.wait(timeout: .distantFuture)
                                    
                                    if lastError != nil {
                                        break
                                    }
                                }
                                
                                if let e = lastError {
                                    invokeFailure(lastResponse, e)
                                }
                                else {
                                    dataStorage.saveWeldData(dictionaries: dictionaries, completion: { (_, error) in
                                        if error == nil {
                                            invokeSuccess()
                                        }
                                        else {
                                            invokeFailure(nil, error!)
                                        }
                                    })
                                }
                            }
                        }
                        else {
                            invokeFailure(response, Errors.spreadsDataUnavailableError())
                        }
                    }
                    else {
                        invokeFailure(nil, error!)
                    }
                })
            }, failure: invokeFailure, progress: invokeProgress)
        }, failure: invokeFailure)
    }
}
