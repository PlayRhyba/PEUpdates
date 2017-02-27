//
//  DataStorage+Data.swift
//  PEUpdates
//
//  Created by Alexander Snigurskyi on 2017-02-16.
//  Copyright © 2017 Alexander Snegursky. All rights reserved.
//


import Foundation
import MagicalRecord


extension DataStorage {
    
    func spreads() -> [Spread]? {
        return Spread.mr_findAll() as? [Spread]
    }
    
    
    func saveJobsSpreadsData(withDictionary dictionary: [String: Any]?,
                             completion: SaveCompletionBlock?) {
        MagicalRecord.save({ (localContext) in
            self.saveSpreads(withDictionary: dictionary, localContext: localContext)
            self.saveLabourSpreads(withDictionary: dictionary, localContext: localContext)
            
            
            //TODO: Handle other data models
            
            
        }, completion: completion)
    }
    
    
    //MARK: Internal Logic
    
    
    private func saveSpreads(withDictionary dictionary: [String: Any]?,
                             localContext: NSManagedObjectContext) {
        if let spreadsData = dictionary?[Constants.Tables.Spread] {
            if spreadsData is [[String: Any]] {
                Spread.mr_truncateAll(in: localContext)
                
                for data in spreadsData as! [[String: Any]] {
                    let spread = Spread.mr_createEntity(in: localContext)
                    spread?.fill(withDictionary: data)
                }
            }
        }
    }
    
    
    private func saveLabourSpreads(withDictionary dictionary: [String: Any]?,
                                   localContext: NSManagedObjectContext) {
        if let labourSpreadsData = dictionary?[Constants.Tables.LabourSpread] {
            if labourSpreadsData is [[String: Any]] {
                LabourSpread.mr_truncateAll(in: localContext)
                
                for data in labourSpreadsData as! [[String: Any]] {
                    let labourSpread = LabourSpread.mr_createEntity(in: localContext)
                    labourSpread?.fill(withDictionary: data)
                }
            }
        }
    }
}
