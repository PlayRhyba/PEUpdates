//
//  PPEDataStorage+Data.swift
//  PEUpdates
//
//  Created by Alexander Snigurskyi on 2017-02-16.
//  Copyright © 2017 Alexander Snegursky. All rights reserved.
//


import Foundation
import MagicalRecord


extension (PPEDataStorage) {
    
    func saveJobsSpreadsData(withDictionary dictionary: [String: Any]?,
                             completion: ((Bool, Error?) -> Void)?) {
        MagicalRecord.save({ (localContext) in
            self.saveSpreads(withDictionary: dictionary, localContext: localContext)
            self.saveLabourSpreads(withDictionary: dictionary, localContext: localContext)
        }, completion: completion)
    }
    
    
    //MARK: Internal Logic
    
    
    private func saveSpreads(withDictionary dictionary: [String: Any]?,
                             localContext: NSManagedObjectContext) {
        if let spreadsData = dictionary?[Constants.Tables.Spread] {
            if spreadsData is Array<Dictionary<String, Any>> {
                PPESpread.mr_truncateAll(in: localContext)
                
                for data in (spreadsData as! Array<Dictionary<String, Any>>) {
                    let spread = PPESpread.mr_createEntity(in: localContext)
                    spread?.fill(withDictionary: data)
                }
            }
        }
    }
    
    
    private func saveLabourSpreads(withDictionary dictionary: [String: Any]?,
                                   localContext: NSManagedObjectContext) {
        if let labourSpreadsData = dictionary?[Constants.Tables.LabourSpread] {
            if labourSpreadsData is Array<Dictionary<String, Any>> {
                PPELabourSpread.mr_truncateAll(in: localContext)
                
                for data in (labourSpreadsData as! Array<Dictionary<String, Any>>) {
                    let labourSpread = PPELabourSpread.mr_createEntity(in: localContext)
                    labourSpread?.fill(withDictionary: data)
                }
            }
        }
    }
}
