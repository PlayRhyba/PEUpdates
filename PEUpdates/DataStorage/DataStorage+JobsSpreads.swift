//
//  DataStorage+Data.swift
//  PEUpdates
//
//  Created by Alexander Snigurskyi on 2017-02-16.
//  Copyright © 2017 Alexander Snegursky. All rights reserved.
//


import CoreData
import CocoaLumberjack


extension DataStorage {
    
    func spreads() -> [Spread]? {
        return Spread.performFetch(withRequestConfiguration: nil,
                                   inContext: persistentContainer.viewContext) as? [Spread]
    }
    
    
    func populateJobsSpreadsData(withDictionary dictionary: [String: Any]?,
                                 completion: OperationCompletionBlock?) {
        persistentContainer.performBackgroundTask { (context) in
            self.populateSpreads(withDictionary: dictionary, inContext: context)
            self.populateLabourSpreads(withDictionary: dictionary, inContext: context)
            
            do {
                try context.save()
                completion?(true, nil)
            }
            catch {
                completion?(false, error)
            }
        }
    }
    
    
    //MARK: Internal Logic
    
    
    private func populateSpreads(withDictionary dictionary: [String: Any]?,
                                 inContext context: NSManagedObjectContext) {
        if let spreadsData = dictionary?[Constants.Tables.Spread] {
            if spreadsData is [[String: Any]] {
                Spread.deleteAll(inContext: context)
                
                for data in spreadsData as! [[String: Any]] {
                    let spread = Spread(context: context)
                    spread.fill(withDictionary: data)
                }
            }
        }
    }
    
    
    private func populateLabourSpreads(withDictionary dictionary: [String: Any]?,
                                       inContext context: NSManagedObjectContext) {
        if let labourSpreadsData = dictionary?[Constants.Tables.LabourSpread] {
            if labourSpreadsData is [[String: Any]] {
                LabourSpread.deleteAll(inContext: context)
                
                for data in labourSpreadsData as! [[String: Any]] {
                    let labourSpread = LabourSpread(context: context)
                    labourSpread.fill(withDictionary: data)
                }
            }
        }
    }
}
