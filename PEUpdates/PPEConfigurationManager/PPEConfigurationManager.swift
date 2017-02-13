//
//  PPEConfigurationManager.swift
//  PEUpdates
//
//  Created by Alexander Snigurskyi on 2017-02-13.
//  Copyright © 2017 Alexander Snegursky. All rights reserved.
//


import Foundation


class PPEConfigurationManager: NSObject {

    static let sharedInstance = PPEConfigurationManager()
    
    
    //MARK: NSObject
    
    
    private override init() {}
    
    
    //MARK: Public Methods
    
    
    func load(withCompletion completion: (Error) -> Void) {
        
        
        //TODO: Parse json files, load to cache dictionary
        
        
    }
    
    
    func clear() {
        
        
        //TODO: Clear db and memory cache
        
        
    }
}
