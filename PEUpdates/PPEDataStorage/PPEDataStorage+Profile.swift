//
//  PPEDataStorage+Profile.swift
//  PEUpdates
//
//  Created by Alexander Snigurskyi on 2017-02-01.
//  Copyright © 2017 Alexander Snegursky. All rights reserved.
//


import Foundation
import MagicalRecord


extension (PPEDataStorage) {
    
    func profile () -> PPEProfile? {
        return PPEProfile.mr_findAll()?.first as? PPEProfile
    }
    
    
    func updateProfile(withDictionary dictionary: Dictionary<String, Any>?,
                       completion: ((PPEProfile?) -> Void)?) {
        if let p = self.profile() {
            p.fill(withDictionary: dictionary)
            completion?(p)
        }
        else {
            MagicalRecord.save({ (localContext) in
                let profile = PPEProfile.mr_createEntity(in: localContext)
                profile?.fill(withDictionary: dictionary)
                
                completion?(profile)
            })
        }
    }
}
