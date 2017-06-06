//
//  ServiceGateway+Data.swift
//  PEUpdates
//
//  Created by Alexander Snigurskyi on 2017-02-03.
//  Copyright © 2017 Alexander Snegursky. All rights reserved.
//


import Foundation


extension ServiceGateway {
    
    class func loadData(email: String,
                        password: String,
                        server: String,
                        completionHandler: @escaping ((OperationResult<Void>) -> Void)) {
        let invokeCompletion = { (result: OperationResult<Void>) in
            DispatchQueue.main.async {
                completionHandler(result)
            }
        }
        
        let requestManager = RequestManager.sharedInstance
        let dataStorage = DataStorage.sharedInstance
        
        login(email: email, password: password, server: server) { result in
            if result.isFailure {
                invokeCompletion(OperationResult.failure(result.error!))
            }
            else {
                let url = URL(string: server)
                
                requestManager.loadJobsSpreads(serverURL: url, completionHandler: { response in
                    if response.result.isFailure {
                        invokeCompletion(OperationResult.failure(response.error!))
                    }
                    else {
                        dataStorage.populateJobsSpreadsData(withDictionary: response.value as? Dictionary, completionHandler: { result in
                            if result.isFailure {
                                invokeCompletion(OperationResult.failure(result.error!))
                            }
                            else {
                                guard let spreads = dataStorage.spreads() else {
                                    invokeCompletion(OperationResult.failure(Errors.spreadsDataUnavailableError()))
                                    return
                                }
                                
                                var dictionaries = [[String: Any]]()
                                var lastError: Error?
                                
                                for spread in spreads {
                                    let spreadID = spread.spreadID!
                                    let semaphore = DispatchSemaphore(value: 0)
                                    
                                    lastError = nil
                                    
                                    requestManager.loadWeldData(spreadID: spreadID, serverURL: url, completionHandler: { response in
                                        if response.result.isFailure {
                                            lastError = response.error
                                        }
                                        else {
                                            if let dictionary = response.value as? [String: Any] {
                                                dictionaries.append(dictionary)
                                            }
                                            else {
                                                lastError = Errors.unexpectedResponseDataStructureError()
                                            }
                                        }
                                        
                                        semaphore.signal()
                                    })
                                    
                                    _ = semaphore.wait(timeout: .distantFuture)
                                    
                                    if lastError != nil {
                                        break
                                    }
                                }
                                
                                if let e = lastError {
                                    invokeCompletion(OperationResult.failure(e))
                                }
                                else {
                                    dataStorage.populateWeldData(withDictionaries: dictionaries,
                                                                 completionHandler: invokeCompletion)
                                }
                            }
                        })
                    }
                })
            }
        }
    }
}
