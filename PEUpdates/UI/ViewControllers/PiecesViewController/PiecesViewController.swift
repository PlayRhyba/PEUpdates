//
//  PiecesViewController.swift
//  PEUpdates
//
//  Created by Alexander Snegursky on 2/25/17.
//  Copyright © 2017 Alexander Snegursky. All rights reserved.
//


import UIKit
import SVProgressHUD


class PiecesViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var pieces: [PPEPiece]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Pieces"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save",
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(save))
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        SVProgressHUD.show()
        
        DispatchQueue.global().async {
            self.pieces = PPEDataStorage.sharedInstance.pieces()
            
            DispatchQueue.main.async {
                SVProgressHUD.dismiss()
                self.tableView.reloadData()
            }
        }
    }
    
    
    //MARK: UITableViewDataSource
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pieces?.count ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PieceCell") as! PieceCell
        cell.piece = pieces?[indexPath.row]
        return cell
    }
    
    
    //MARK: Internal Logic
    
    
    func save() {

        
        //TODO: Save model
        
        
    }
}
