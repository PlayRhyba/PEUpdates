//
//  WeldsViewController.swift
//  PEUpdates
//
//  Created by Alexander Snigurskyi on 2017-02-27.
//  Copyright © 2017 Alexander Snegursky. All rights reserved.
//


import UIKit
import SVProgressHUD


class WeldsViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var welds: [PPEWeld]?
    
    
    //MARK: UIViewController
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        SVProgressHUD.show()
        
        PPEDataStorage.sharedInstance.welds { (welds, error) in
            self.welds = welds as? [PPEWeld]
            
            if error != nil {
                SVProgressHUD.showError(withStatus: error!.localizedDescription)
            }
            else {
                SVProgressHUD.dismiss()
            }
            
            self.title = String(format: "Welds (%d)", self.welds?.count ?? 0)
            self.tableView.reloadData()
        }
    }
    
    
    //MARK: UITableViewDataSource
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return welds?.count ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeldCell") as! WeldCell
        cell.weld = welds?[indexPath.row]
        return cell
    }
}
