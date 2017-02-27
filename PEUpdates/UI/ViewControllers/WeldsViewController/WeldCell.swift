//
//  WeldCellTableViewCell.swift
//  PEUpdates
//
//  Created by Alexander Snigurskyi on 2017-02-27.
//  Copyright © 2017 Alexander Snegursky. All rights reserved.
//


import UIKit


class WeldCell: UITableViewCell {
    
    weak var weld: Weld? {
        didSet {
            self.textLabel?.text = weld?.weldNumber
            self.detailTextLabel?.text = weld?.weldStatus
        }
    }
}
