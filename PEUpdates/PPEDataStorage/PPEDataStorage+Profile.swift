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
    
    
    func updateProfile(withDictionary dictionary: [String: Any]?,
                       completion: CompletionBlock?) {
        MagicalRecord.save({ (localContext) in
            if let p = self.profile() {
                p.fill(withDictionary: dictionary)
            }
            else {
                let profile = PPEProfile.mr_createEntity(in: localContext)
                profile?.fill(withDictionary: dictionary)
            }
        }, completion: completion)
    }
}
