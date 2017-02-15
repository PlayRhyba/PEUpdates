//
//  PPESpread+CoreDataClass.swift
//  
//
//  Created by Alexander Snigurskyi on 2017-02-15.
//
//


import CoreData


@objc class PPESpread: PPEBaseDBDataModel {

    @NSManaged public var spreadID: NSNumber?
    @NSManaged public var jobID: NSNumber?
    @NSManaged public var spreadName: String?
    @NSManaged public var spreadPrefix: String?
    @NSManaged public var spreadDesc: String?
    @NSManaged public var estimatedWeldCount: NSNumber?
    @NSManaged public var estimatedStartDate: NSDate?
    @NSManaged public var estimatedEndDate: NSDate?
    @NSManaged public var estimatedWorkDays: NSNumber?
    @NSManaged public var start_km: NSNumber?
    @NSManaged public var end_km: NSNumber?
    @NSManaged public var length_km: NSNumber?
    @NSManaged public var linealLength_meters: NSNumber?
    @NSManaged public var targetedWeldRejectRate: NSNumber?
    @NSManaged public var targetedWeldProductionRate: NSNumber?
    @NSManaged public var estimatedWeld: String?
    @NSManaged public var country: String?
    @NSManaged public var workOrderNo: String?
    @NSManaged public var workOrderTaskCodeNo: String?
    @NSManaged public var billingEmailList: String?
    @NSManaged public var spreadStartDate: NSDate?
    @NSManaged public var weldCount: NSNumber?
    @NSManaged public var weldPassCount: NSNumber?
    @NSManaged public var rejectCount: NSNumber?
    @NSManaged public var visualNDTCount: NSNumber?
    @NSManaged public var nDTCount: NSNumber?
    @NSManaged public var defectCount: NSNumber?
    @NSManaged public var repairCount: NSNumber?
    @NSManaged public var cutOutCount: NSNumber?
    @NSManaged public var rejectPercent: NSNumber?
    @NSManaged public var visualPercent: NSNumber?
    @NSManaged public var nDTPercent: NSNumber?
    @NSManaged public var repairPercent: NSNumber?
    @NSManaged public var cutOutPercent: NSNumber?
    @NSManaged public var defectPercent: NSNumber?
    @NSManaged public var lastStatisticsUpdateDate: NSDate?
    @NSManaged public var centreOfRightOfWayWKT: String?
    @NSManaged public var ditchLineWKT: String?

    
    
    //MARK: PPEDataModel
    
    
    override var tableName: String {
        return Constants.Tables.Spread
    }
}
