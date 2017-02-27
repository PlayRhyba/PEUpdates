//
//  DataStorage+WeldData.swift
//  PEUpdates
//
//  Created by Alexander Snigurskyi on 2017-02-20.
//  Copyright © 2017 Alexander Snegursky. All rights reserved.
//


import Foundation
import MagicalRecord


extension DataStorage {
    
    func welds(spreadID: NSNumber) -> [Weld]? {
        return Weld.mr_findAll(with: NSPredicate.predicate(spreadID: spreadID)) as? [Weld]
    }
    
    
    func welds(completion: FetchCompletionBlock?) {
        Weld.performAsynchroniuosFetch(withRequestConfiguration: { (fetchRequest) in
            fetchRequest.sortDescriptors = [NSSortDescriptor(key: #keyPath(Weld.weldNumber), ascending: true)]
        }, completion: completion)
    }
    
    
    func pieces(completion: FetchCompletionBlock?) {
        Piece.performAsynchroniuosFetch(withRequestConfiguration: { (fetchRequest) in
            fetchRequest.sortDescriptors = [NSSortDescriptor(key: #keyPath(Piece.pieceNumber), ascending: true)]
        }, completion: completion)
    }
    
    
    func saveWeldData(dictionaries: [[String: Any]]?, completion: SaveCompletionBlock?) {
        MagicalRecord.save({ (localContext) in
            if let objects = dictionaries {
                self.clearWeldData(localContext: localContext)
                
                for dictionary in objects {
                    self.saveWelds(withDictionary: dictionary, localContext: localContext)
                    self.savePieces(withDictionary: dictionary, localContext: localContext)
                    
                    
                    //TODO: Handle other models
                    
                    
                }
            }
        }, completion: completion)
    }
    
    
    //MARK: Internal Logic
    
    
    private func saveWelds(withDictionary dictionary: [String: Any]?,
                           localContext: NSManagedObjectContext) {
        if let weldsData = dictionary?[Constants.Tables.Weld] {
            if weldsData is [[String: Any]] {
                for data in (weldsData as! [[String: Any]]) {
                    let weld = Weld.mr_createEntity(in: localContext)
                    weld?.fill(withDictionary: data)
                }
            }
        }
    }
    
    
    private func savePieces(withDictionary dictionary: [String: Any]?,
                            localContext: NSManagedObjectContext) {
        if let piecesData = dictionary?[Constants.Tables.Piece] {
            if piecesData is [[String: Any]] {
                for data in piecesData as! [[String: Any]] {
                    let piece = Piece.mr_createEntity(in: localContext)
                    piece?.fill(withDictionary: data)
                }
            }
        }
    }
    
    
    private func clearWeldData(localContext: NSManagedObjectContext) {
        Weld.mr_truncateAll(in: localContext)
        Piece.mr_truncateAll(in: localContext)
        
        
        //TODO: Clear other models
        
        
    }
}
