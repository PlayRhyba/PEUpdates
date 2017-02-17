//
//  NSDate+Utilities.swift
//  PEUpdates
//
//  Created by Alexander Snigurskyi on 2017-02-17.
//  Copyright © 2017 Alexander Snegursky. All rights reserved.
//


import Foundation


extension (Date) {
    
    static func formatter() -> DateFormatter {
        let formatter = DateFormatter.init()
        formatter.calendar = Calendar.init(identifier: .gregorian)
        formatter.locale = Locale.init(identifier: "en_US_POSIX")
        return formatter
    }
    
    
    func string(withFormat format: String) -> String? {
        return nil
    }
}


extension (DateFormatter) {
    
    func date(fromString string: String, format: String) -> Date? {
        return nil
    }
    
    
    func string(fromDate date: NSDate, format: String) -> String? {
        return nil
    }
}


extension (String) {
    
    func date(withFormat format: String) -> Date? {
        return nil
    }
    
    
    func date(withFormats formats: [String]) -> Date? {
        return nil
    }
}
