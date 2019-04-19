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
    var titleLabel: String = ""
    var priceLabel: String = ""
    var sellerLabel: String = ""
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Account Overview"
    
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
        cell.priceLabel?.text = "$\(data.value(forKeyPath: "price")!)"
        cell.authorLabel?.text = data.value(forKeyPath: "author") as? String

        return cell
    }

    override func tableView( _ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
        let listData = cellData[indexPath.row]
        
        let listingViewController = storyboard?.instantiateViewController(withIdentifier: "ListingViewController") as! ListingViewController

        specificListing.titleLabel = "\(listData.value(forKeyPath: "title")!)"
        print("\(listData.value(forKeyPath: "title")!)")
        specificListing.priceLabel = "\(listData.value(forKeyPath: "price")!)"
        specificListing.sellerLabel = "\(listData.value(forKeyPath: "sellerUsername")!)"
        
        
        navigationController?.pushViewController(listingViewController, animated: true)
        
    }

}


struct specificListing
{
    static var titleLabel = ""
    static var priceLabel = ""
    static var sellerLabel = ""
}
