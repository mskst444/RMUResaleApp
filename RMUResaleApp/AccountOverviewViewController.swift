//
//  AccountOverviewViewController.swift
//  RMUResaleApp
//
//  Created by Jacob Wright on 4/16/19.
//  Copyright © 2019 Mitchell Keller. All rights reserved.
//

import UIKit
import CoreData

class AccountOverviewViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func unwindFromAccountEdit(segue: UIStoryboardSegue) {
    }
    
    
    @IBOutlet weak var tableView: UITableView!
    

    var listings : [NSManagedObject] = []
    
    //Return the number of rows in the table as the number of items found in the listings array
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listings.count
    }
    
    //Dequeue table view cell and populate them with the corresponding NSManagedObject
    func tableView(_ tablView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let book = listings[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text = book.value(forKeyPath: "title") as? String
        return cell
    }
    
    
    
    
}
