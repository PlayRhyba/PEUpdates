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
        return Date.formatter().string(fromDate: self, format: format)
    }
}


extension (DateFormatter) {
    
    func date(fromString string: String, format: String) -> Date? {
        self.dateFormat = format
        return self.date(from: string)
    }
    
    
    func string(fromDate date: Date, format: String) -> String? {
        self.dateFormat = format
        return self.string(from: date)
    }
}


extension (String) {
    
    func date(withFormat format: String) -> Date? {
        return Date.formatter().date(fromString: self, format: format)
    }
    
    
    func date(withFormats formats: [String]) -> Date? {
        for format in formats {
            let date = self.date(withFormat: format)
            
            if date != nil {
                return date
            }
        }
        
        return nil
    }
}
