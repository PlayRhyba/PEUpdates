//
//  PPEDataModel.swift
//  PEUpdates
//
//  Created by Alexander Snigurskyi on 2017-02-13.
//  Copyright © 2017 Alexander Snegursky. All rights reserved.
//


import Foundation


@objc protocol PPEDataModel {
    
    var tableName: String { get }
    
    
    @objc optional func postDictionary() -> Dictionary<String, Any>
}
