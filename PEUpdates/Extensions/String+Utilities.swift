//
//  NSString+Utilities.swift
//  PEUpdates
//
//  Created by Alexander Snigurskyi on 2017-02-01.
//  Copyright © 2017 Alexander Snegursky. All rights reserved.
//


import Foundation


extension (String) {
    
    func capitalizingFirstLetter() -> String {
        let first = String(characters.prefix(1)).capitalized
        let other = String(characters.dropFirst())
        return first + other
    }
    
    
    mutating func capitalizeFirstLetter() {
        self = capitalizingFirstLetter()
    }
}
