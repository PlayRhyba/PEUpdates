//
//  PiecesViewController.swift
//  PEUpdates
//
//  Created by Alexander Snegursky on 2/25/17.
//  Copyright © 2017 Alexander Snegursky. All rights reserved.
//


import UIKit


class PiecesViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var pieces: [Piece]?
    
    
    //MARK: UIViewController
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save",
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(saveButtonClicked))
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        HUD.show()
        
        DataStorage.sharedInstance.pieces(completion: { (pieces, error) in
            self.pieces = pieces as? [Piece]
            
            if error != nil {
                HUD.showError(withStatus: error?.localizedDescription)
            }
            else {
                HUD.dismiss()
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
        HUD.show()
        
        DataStorage.sharedInstance.save { (_, error) in
            if error == nil {
                HUD.dismiss()
            }
            else {
                HUD.showError(withStatus: error!.localizedDescription)
            }
        }
    }
}
