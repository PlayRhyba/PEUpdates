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
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save",
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(saveButtonClicked))
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        SVProgressHUD.show()
        
        PPEDataStorage.sharedInstance.pieces(completion: { (pieces, error) in
            self.pieces = pieces
            
            if error != nil {
                SVProgressHUD.showError(withStatus: error?.localizedDescription)
            }
            else {
                SVProgressHUD.dismiss()
            }
            
            self.title = String(format: "Pieces (%d)", self.pieces?.count ?? 0)
            self.tableView.reloadData()
        })
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
    
    
    func saveButtonClicked() {
        SVProgressHUD.show()
        
        PPEDataStorage.sharedInstance.save { (_, error) in
            if error == nil {
                SVProgressHUD.dismiss()
            }
            else {
                SVProgressHUD.showError(withStatus: error!.localizedDescription)
            }
        }
    }
}
