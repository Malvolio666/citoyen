//
//  CategoryViewController.swift
//  Citoyen-beta-2
//
//  Created by Mickaël Jordan on 11/14/17.
//  Copyright © 2017 Mickaël Jordan. All rights reserved.
//

import UIKit
import Firebase

class CategoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var categoryTableView: UITableView!
    
    var valueToPass : String!
    
    var ministryArray : [Ministry] = [Ministry]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib
        
        categoryTableView.delegate = self
        categoryTableView.dataSource = self
        
        categoryTableView.register(UINib(nibName:"CategoryCell", bundle: nil), forCellReuseIdentifier: "categoryCell")
        
        retrieveMinistries()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        categoryTableView.separatorStyle = UITableViewCellSeparatorStyle.none
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ministryArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath) as! CategoryCell
        
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        
        cell.categoryText.text = ministryArray[indexPath.row].category
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let indexPath = tableView.indexPathForSelectedRow
        let currentCell = tableView.cellForRow(at: indexPath!) as! CategoryCell?
        
        valueToPass = currentCell?.categoryText.text
        performSegue(withIdentifier: "gotoEtatFrance", sender: self)
    }
    
    func retrieveMinistries() {
        
        let postDB = Database.database().reference().child("Ministries").queryOrdered(byChild: "rank")
        
        postDB.observe(.childAdded, with: { (snapshot) in
            let snapshotValue = snapshot.value as! NSDictionary
            let ministry = Ministry(data: snapshotValue)
            
            self.ministryArray.append(ministry)
            self.categoryTableView.reloadData()
            
        })
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if (segue.identifier == "gotoEtatFrance") {
                let viewController = segue.destination as! DashboardViewController
                viewController.passedValue = valueToPass
        }
    }
    
    @IBAction func closeButtonPressed(_ sender: Any) {
        
        navigationController?.popViewController(animated: true)
        
    }
    
    
}
