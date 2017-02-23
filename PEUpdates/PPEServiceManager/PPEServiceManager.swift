//
//  PPEServiceManager.swift
//  PEUpdates
//
//  Created by Alexander Snegursky on 1/7/17.
//  Copyright © 2017 Alexander Snegursky. All rights reserved.
//


import Foundation
import AFNetworking
import CocoaLumberjack


class PPEServiceManager: NSObject {
    
    typealias SuccessBlock = (HTTPURLResponse, Any?) -> Void
    typealias FailureBlock = (HTTPURLResponse?, Error) -> Void
    typealias SessionManagerConfigurationBlock = (AFHTTPSessionManager) -> Void
    typealias ProgressBlock = (Progress) -> Void
    
    
    private enum RequestType: String {
        case GET = "GET"
        case POST = "POST"
    }
    
    
    static let sharedInstance = PPEServiceManager()
    
    
    private(set) lazy var tasks: NSHashTable<URLSessionDataTask> = {
        return NSHashTable.weakObjects()
    }()
    
    
    //MARK: NSObject
    
    
    private override init() {
        NotificationCenter.default.addObserver(forName: NSNotification.Name.AFNetworkingTaskDidComplete,
                                               object: nil,
                                               queue: OperationQueue.main) { (notification) in
                                                if let error = notification.userInfo?[AFNetworkingTaskDidCompleteErrorKey] as? NSError {
                                                    if let data = error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] as? Data {
                                                        let response = String(data: data, encoding: .utf8)
                                                        
                                                        DDLogError(String(format: "%@: AFNETWORKING TASK HAS BEEN COMPLETED WITH ERROR: %@. RESPONSE: %@",
                                                                          "\(PPEServiceManager.self)", error, response!))
                                                    }
                                                    
                                                }
        }
    }
    
    
    //MARK: Public Methods
    
    
    func cancellAllOperations() {
        for task in tasks.allObjects {
            task.cancel()
        }
        
        tasks.removeAllObjects()
    }
    
    
    func countOperations(path: String?) -> UInt {
        var count: UInt = 0
        
        if let p = path {
            for task in tasks.allObjects {
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
                                    self.logResponseSuccess(url: baseURL!, path: path, type: .POST, data: data)
                                    
                                    self.handleSuccess(task: task,
                                                       data: data,
                                                       successHandler: success,
                                                       failureHandler: failure)
        }) {[unowned self] (task, error) in
            self.logResponseFailure(url: baseURL, path: path, type: .POST, error: error as NSError)
            
            self.handleFailure(task: task,
                               error: error,
                               handler: failure)
        }
        
        logSentResponse(body: task?.originalRequest?.httpBody, type: .POST)
        
        tasks.add(task)
        
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
                                self.logResponseSuccess(url: baseURL!, path: path, type: .GET, data: data)
                                
                                self.handleSuccess(task: task,
                                                   data: data,
                                                   successHandler: success,
                                                   failureHandler: failure)
        }) { [unowned self] (task, error) in
            self.logResponseFailure(url: baseURL, path: path, type: .GET, error: error as NSError)
            
            self.handleFailure(task: task,
                               error: error,
                               handler: failure)
        }
        
        logSentResponse(body: task?.originalRequest?.httpBody, type: .GET)
        
        tasks.add(task)
        
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
        
        sessionManagerConfigurationBlock?(manager)
        
        return manager
    }
    
    
    private func handleSuccess(task: URLSessionDataTask,
                               data: Any?,
                               successHandler: SuccessBlock?,
                               failureHandler: FailureBlock?) {
        tasks.remove(task)
        successHandler?(task.response as! HTTPURLResponse, data)
    }
    
    
    private func handleFailure(task: URLSessionDataTask?,
                               error: Error,
                               handler: FailureBlock?) {
        tasks.remove(task)
        
        let processedError = PPEServiceResultsHandler.process(error: error)
        handler?(task?.response as? HTTPURLResponse, processedError)
    }
    
    
    private func logResponseSuccess(url: URL,
                                    path: String,
                                    type: RequestType,
                                    data: Any?) {
        if let d = data as? Data {
            let stringRepresentation = String(data: d, encoding: .utf8)
            
            DDLogDebug(String(format: "%@: %@ PATH: %@. SUCCESS. RESPONSE: %@",
                              "\(classForCoder)", type.rawValue, "\(url.appendingPathComponent(path))", stringRepresentation ?? ""))
        }
    }
    
    
    private func logResponseFailure(url: URL?,
                                    path: String,
                                    type: RequestType,
                                    error: NSError) {
        let fullURL = url?.appendingPathComponent(path)
        let data = error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] as? Data
        let response = String(data: data ?? Data(), encoding: .utf8)
        
        DDLogError(String(format: "%@: %@ PATH: %@. FAILURE. RESPONSE: %@. ERROR: %@",
                          "\(classForCoder)", type.rawValue, "\(fullURL)", response ?? "", error.localizedDescription))
    }
    
    
    private func logSentResponse(body: Data?, type: RequestType) {
        let str = String(data: body ?? Data(), encoding: .utf8)
        DDLogInfo(String(format: "%@: %@ BODY: %@", "\(classForCoder)", type.rawValue, str ?? "<empty>"))
    }
}
