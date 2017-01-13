//
//  PPEServiceManager.swift
//  PEUpdates
//
//  Created by Alexander Snegursky on 1/7/17.
//  Copyright © 2017 Alexander Snegursky. All rights reserved.
//


import Foundation
import AFNetworking


class PPEServiceManager: NSObject {
    
    typealias SuccessBlock = (HTTPURLResponse, Any?) -> Void
    typealias FailureBlock = (HTTPURLResponse?, Error) -> Void
    typealias SessionManagerConfigurationBlock = (AFHTTPSessionManager) -> Void
    typealias ProgressBlock = (Progress) -> Void
    
    
    static let sharedInstance = PPEServiceManager()
    
    
    private(set) lazy var tasks: NSHashTable<URLSessionDataTask> = {
        return NSHashTable.weakObjects()
    }()
    
    
    //MARK: NSObject
    
    
    private override init() {}
    
    
    //MARK: Public Methods
    
    
    func cancellAllOperations() {
        for task in self.tasks.allObjects {
            task.cancel()
        }
        
        self.tasks.removeAllObjects()
    }
    
    
    func countOperations(path: String?) -> UInt {
        var count: UInt = 0
        
        if let p = path {
            for task in self.tasks.allObjects {
                if task.originalRequest?.url?.path == p {
                    count += 1
                }
            }
        }
        
        return count
    }
    
    
    func sendPOST(path: String,
                  baseURL: URL?,
                  parameters: Any?,
                  sessionManagerConfigurationBlock: SessionManagerConfigurationBlock?,
                  success: SuccessBlock?,
                  progress: ProgressBlock?,
                  failure: FailureBlock?) -> URLSessionDataTask? {
        let manager = createSessionManager(baseURL: baseURL,
                                           sessionManagerConfigurationBlock: sessionManagerConfigurationBlock)
        let task = manager.post(path,
                                parameters: parameters,
                                progress: progress,
                                success: {[unowned self] (task, data) in
                                    self.handleSuccess(task: task,
                                                       data: data,
                                                       successHandler: success,
                                                       failureHandler: failure)
        }) {[unowned self] (task, error) in
            self.handleFailure(task: task,
                               error: error,
                               handler: failure)
        }
        
        self.tasks.add(task)
        
        return task
    }
    
    
    func sendGET(path: String,
                 baseURL: URL?,
                 parameters: Any?,
                 sessionManagerConfigurationBlock: SessionManagerConfigurationBlock?,
                 success: SuccessBlock?,
                 progress: ProgressBlock?,
                 failure: FailureBlock?) -> URLSessionDataTask? {
        let manager = createSessionManager(baseURL: baseURL,
                                           sessionManagerConfigurationBlock: sessionManagerConfigurationBlock)
        let task = manager.get(path,
                               parameters: parameters,
                               progress: progress,
                               success: { [unowned self] (task, data) in
                                self.handleSuccess(task: task,
                                                   data: data,
                                                   successHandler: success,
                                                   failureHandler: failure)
        }) { [unowned self] (task, error) in
            self.handleFailure(task: task,
                               error: error,
                               handler: failure)
        }
        
        self.tasks.add(task)
        
        return task
    }
    
    
    //MARK: Internal Logic
    
    
    private func createSessionManager(baseURL: URL?,
                                      sessionManagerConfigurationBlock:SessionManagerConfigurationBlock?) -> AFHTTPSessionManager {
        let manager = AFHTTPSessionManager(baseURL: baseURL)
        manager.requestSerializer = AFHTTPRequestSerializer()
        manager.responseSerializer = AFHTTPResponseSerializer()
        
        manager.securityPolicy.allowInvalidCertificates = true
        manager.securityPolicy.validatesDomainName = false
        
        if let block = sessionManagerConfigurationBlock {
            block(manager)
        }
        
        return manager
    }
    
    
    private func handleSuccess(task: URLSessionDataTask,
                               data: Any?,
                               successHandler: SuccessBlock?,
                               failureHandler: FailureBlock?) {
        self.tasks.remove(task)
        
        if let handler = successHandler {
            handler(task.response as! HTTPURLResponse, data)
        }
    }
    
    
    private func handleFailure(task: URLSessionDataTask?,
                               error: Error,
                               handler: FailureBlock?) {
        self.tasks.remove(task)
        
        if let block = handler {
            let processedError = PPEServiceResultsHandler.process(error: error)
            block(task?.response as? HTTPURLResponse, processedError)
        }
    }
}
