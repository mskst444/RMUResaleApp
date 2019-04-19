//
//  AccountOverviewTableViewController.swift
//  RMUResaleApp
//
//  Created by Jacob Wright on 4/18/19.
//  Copyright © 2019 Mitchell Keller. All rights reserved.
//

import UIKit
import CoreData

class AccountOverviewTableViewController: UITableViewController {
    
/*************************** Properties: *********************************************************************/
    
    var cellData: [NSManagedObject] = []
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Account Overview"
        //tableView.register(AccountOverviewTableViewCell.self, forCellReuseIdentifier: "AccountOverviewTableView")
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        //self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let getUser = UserInformation()
        getUser.userFetchRequest(username: Username.userMaster)
        let user = getUser.userName
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else
        {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Books")
        
        fetchRequest.predicate = NSPredicate(format: "sellerUsername = %@", user)
        
        do {
            cellData = try managedContext.fetch(fetchRequest)
        }
        catch let error as NSError
        {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellData.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = cellData[indexPath.row]
        let cellidentifier = "AccountOverviewTableView"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellidentifier, for: indexPath) as?
            AccountOverviewTableViewCell else
            {
                fatalError("The dequeued cell is not an instance of AccountOverviewTableViewCell")
            }
        cell.titleLabel?.text = "\(data.value(forKeyPath: "title")!)"
        cell.priceLabel?.text = "$\(String(describing: data.value(forKeyPath: "price") as? String)))"
        cell.authorLabel?.text = data.value(forKeyPath: "author") as? String

        return cell
    }

    override func tableView( _ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
        
        let listingViewController = storyboard?.instantiateViewController(withIdentifier: "ListingViewController") as! ListingViewController
        
        let listData = cellData[indexPath.row]
        listingViewController.listingTitle.text = listData.value(forKeyPath: "title") as? String
        listingViewController.listingPrice.text = "$\(String(describing: listData.value(forKeyPath: "price") as? String))"
        listingViewController.listingSeller.text = listData.value(forKeyPath: "seller") as? String
        
        navigationController?.pushViewController(listingViewController, animated: true)
    }
    
    
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
 

}
