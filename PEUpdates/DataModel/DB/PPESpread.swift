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
    
    
    //MARK: PPEBaseDBDataModel
    
    
    override func fill(withDictionary dictionary: [String: Any]?) {
        super.fill(withDictionary: dictionary)
        
        if let d = dictionary {
            spreadID = value(fromDictionary: d, propertyName: #keyPath(spreadID)) as? NSNumber
            jobID = value(fromDictionary: d, propertyName: #keyPath(jobID)) as? NSNumber
            spreadName = value(fromDictionary: d, propertyName: #keyPath(spreadName)) as? String
            spreadPrefix = value(fromDictionary: d, propertyName: #keyPath(spreadPrefix)) as? String
            spreadDesc = value(fromDictionary: d, propertyName: #keyPath(spreadDesc)) as? String
            estimatedWeldCount = value(fromDictionary: d, propertyName: #keyPath(estimatedWeldCount)) as? NSNumber
            estimatedStartDate = value(fromDictionary: d, propertyName: #keyPath(estimatedStartDate), processingMode: .Date) as? NSDate
            estimatedEndDate = value(fromDictionary: d, propertyName: #keyPath(estimatedEndDate), processingMode: .Date) as? NSDate
            estimatedWorkDays = value(fromDictionary: d, propertyName: #keyPath(estimatedWorkDays)) as? NSNumber
            start_km = value(fromDictionary: d, propertyName: #keyPath(start_km)) as? NSNumber
            end_km = value(fromDictionary: d, propertyName: #keyPath(end_km)) as? NSNumber
            length_km = value(fromDictionary: d, propertyName: #keyPath(length_km)) as? NSNumber
            linealLength_meters = value(fromDictionary: d, propertyName: #keyPath(linealLength_meters)) as? NSNumber
            targetedWeldRejectRate = value(fromDictionary: d, propertyName: #keyPath(targetedWeldRejectRate)) as? NSNumber
            targetedWeldProductionRate = value(fromDictionary: d, propertyName: #keyPath(targetedWeldProductionRate)) as? NSNumber
            estimatedWeld = value(fromDictionary: d, propertyName: #keyPath(estimatedWeld)) as? String
            country = value(fromDictionary: d, propertyName: #keyPath(country)) as? String
            workOrderNo = value(fromDictionary: d, propertyName: #keyPath(workOrderNo)) as? String
            workOrderTaskCodeNo = value(fromDictionary: d, propertyName: #keyPath(workOrderTaskCodeNo)) as? String
            billingEmailList = value(fromDictionary: d, propertyName: #keyPath(billingEmailList)) as? String
            spreadStartDate = value(fromDictionary: d, propertyName: #keyPath(spreadStartDate), processingMode: .Date) as? NSDate
            weldCount = value(fromDictionary: d, propertyName: #keyPath(weldCount)) as? NSNumber
            weldPassCount = value(fromDictionary: d, propertyName: #keyPath(weldPassCount)) as? NSNumber
            rejectCount = value(fromDictionary: d, propertyName: #keyPath(rejectCount)) as? NSNumber
            visualNDTCount = value(fromDictionary: d, propertyName: #keyPath(visualNDTCount)) as? NSNumber
            nDTCount = value(fromDictionary: d, propertyName: #keyPath(nDTCount)) as? NSNumber
            defectCount = value(fromDictionary: d, propertyName: #keyPath(defectCount)) as? NSNumber
            repairCount = value(fromDictionary: d, propertyName: #keyPath(repairCount)) as? NSNumber
            cutOutCount = value(fromDictionary: d, propertyName: #keyPath(cutOutCount)) as? NSNumber
            rejectPercent = value(fromDictionary: d, propertyName: #keyPath(rejectPercent)) as? NSNumber
            visualPercent = value(fromDictionary: d, propertyName: #keyPath(visualPercent)) as? NSNumber
            nDTPercent = value(fromDictionary: d, propertyName: #keyPath(nDTPercent)) as? NSNumber
            repairPercent = value(fromDictionary: d, propertyName: #keyPath(repairPercent)) as? NSNumber
            cutOutPercent = value(fromDictionary: d, propertyName: #keyPath(cutOutPercent)) as? NSNumber
            defectPercent = value(fromDictionary: d, propertyName: #keyPath(defectPercent)) as? NSNumber
            lastStatisticsUpdateDate = value(fromDictionary: d, propertyName: #keyPath(lastStatisticsUpdateDate), processingMode: .Date) as? NSDate
            centreOfRightOfWayWKT = value(fromDictionary: d, propertyName: #keyPath(centreOfRightOfWayWKT)) as? String
            ditchLineWKT = value(fromDictionary: d, propertyName: #keyPath(ditchLineWKT)) as? String
        }
    }
    
    
    //MARK: PPEDataModel
    
    
    override var tableName: String {
        return Constants.Tables.Spread
    }
}
