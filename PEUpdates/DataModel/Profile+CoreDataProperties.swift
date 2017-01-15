//
//  Profile+CoreDataProperties.swift
//  PEUpdates
//
//  Created by Alexander Snegursky on 1/15/17.
//  Copyright © 2017 Alexander Snegursky. All rights reserved.
//

import Foundation
import CoreData


extension Profile {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Profile> {
        return NSFetchRequest<Profile>(entityName: "Profile");
    }

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

}
