//
//  DataStorage+WeldData.swift
//  PEUpdates
//
//  Created by Alexander Snigurskyi on 2017-02-20.
//  Copyright © 2017 Alexander Snegursky. All rights reserved.
//


import CoreData


extension DataStorage {
    
    
    func welds(completion: @escaping FetchCompletionBlock) {
        Weld.performAsynchroniuosFetch(withRequestConfiguration: { (fetchRequest) in
            fetchRequest.sortDescriptors = [NSSortDescriptor(key: #keyPath(Weld.weldNumber), ascending: true)]
        }, inContext: persistentContainer.viewContext, completion: completion)
    }
    
    
    func pieces(completion: @escaping FetchCompletionBlock) {
        Piece.performAsynchroniuosFetch(withRequestConfiguration: { (fetchRequest) in
            fetchRequest.sortDescriptors = [NSSortDescriptor(key: #keyPath(Piece.pieceNumber), ascending: true)]
        }, inContext: persistentContainer.viewContext, completion: completion)
    }
    
    
    func populateWeldData(dictionaries: [[String: Any]]?, completion: OperationCompletionBlock?) {
        persistentContainer.performBackgroundTask { (context) in
            if let objects = dictionaries {
                self.clearWeldData(inContext: context)
                
                for dictionary in objects {
                    self.populateWelds(withDictionary: dictionary, inContext: context)
                    self.populatePieces(withDictionary: dictionary, inContext: context)
                    
                    
                    //TODO: Handle other models
                    
                    
                }
                
                do {
                    try context.save()
                    completion?(true, nil)
                }
                catch {
                    completion?(false, error)
                }
            }
        }
    }
    
    
    //MARK: Internal Logic
    
    
    private func populateWelds(withDictionary dictionary: [String: Any]?,
                               inContext context: NSManagedObjectContext) {
        if let weldsData = dictionary?[Constants.Tables.Weld] {
            if weldsData is [[String: Any]] {
                for data in (weldsData as! [[String: Any]]) {
                    let weld = Weld(context: context)
                    weld.fill(withDictionary: data)
                }
            }
        }
    }
    
    
    private func populatePieces(withDictionary dictionary: [String: Any]?,
                                inContext context: NSManagedObjectContext) {
        if let piecesData = dictionary?[Constants.Tables.Piece] {
            if piecesData is [[String: Any]] {
                for data in piecesData as! [[String: Any]] {
                    let piece = Piece(context: context)
                    piece.fill(withDictionary: data)
                }
            }
        }
    }
    
    
    private func clearWeldData(inContext context: NSManagedObjectContext) {
        Weld.deleteAll(inContext: context)
        Piece.deleteAll(inContext: context)
        
        
        //TODO: Clear other models
        
        
    }
}
