//
//  PieceCell.swift
//  PEUpdates
//
//  Created by Alexander Snegursky on 2/25/17.
//  Copyright © 2017 Alexander Snegursky. All rights reserved.
//


import UIKit


class PieceCell: UITableViewCell {
    
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var manufacturerLabel: UILabel!
    
    weak var piece: PPEPiece? {
        didSet {
            update()
        }
    }
    
    
    //MARK: IBAction
    
    
    @IBAction func mofifyButtonClicked(sender: UIButton) {
        let modifier = "<MODIFIED!>"
        
        piece?.pieceNumber = (piece?.pieceNumber ?? "") + modifier
        piece?.manufacturer = (piece?.manufacturer ?? "") + modifier
        
        update()
    }
    
    
    //MARK: Internal Logic
    
    
    func update() {
        numberLabel.text = piece?.pieceNumber
        manufacturerLabel.text = piece?.manufacturer
    }
}
