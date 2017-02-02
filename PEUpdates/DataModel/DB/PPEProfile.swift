//
//  Profile.swift
//  PEUpdates
//
//  Created by Alexander Snigurskyi on 2017-01-31.
//  Copyright © 2017 Alexander Snegursky. All rights reserved.
//


import Foundation


@objc class PPEProfile: PPEBaseDataModel {
    
    @NSManaged public var companyID: String?
    @NSManaged public var lastJobUUID: String?
    @NSManaged public var lastSpreadUUID: String?
    @NSManaged public var lastWeldUUID: String?
    @NSManaged public var measurementSystem: String?
    @NSManaged public var name: String?
    @NSManaged public var readOnly: Bool
    @NSManaged public var role: String?
    @NSManaged public var roles: String?
    @NSManaged public var signatureData: String?
    
    
    override func fill(withDictionary dictionary: Dictionary<String, Any>?) {
        super.fill(withDictionary: dictionary)
        
        if let d = dictionary {
            companyID = d["companyID"] as? String
            lastJobUUID = d["lastJobUUID"] as? String
            lastSpreadUUID = d["lastSpreadUUID"] as? String
            lastWeldUUID = d["lastWeldUUID"] as? String
            measurementSystem = d["MeasurementSystem"] as? String
            name = d["name"] as? String
            readOnly = (d["ReadOnly"] as? NSNumber)?.boolValue ?? false
            role = d["role"] as? String
            roles = d["roles"] as? String
            signatureData = d["SignatureData"] as? String
        }
    }
}
