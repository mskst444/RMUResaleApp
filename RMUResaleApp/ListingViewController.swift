//
//  ListingViewController.swift
//  RMUResaleApp
//
//  Created by Jacob Wright on 4/18/19.
//  Copyright © 2019 Mitchell Keller. All rights reserved.
//

import UIKit
import CoreData

class ListingViewController: UIViewController {
    
    @IBOutlet weak var listingTitle: UILabel!
    @IBOutlet weak var listingPrice: UILabel!
    @IBOutlet weak var listingSeller: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.listingTitle.text = specificListing.titleLabel
        self.listingPrice.text = "Price: $" + specificListing.priceLabel
        self.listingSeller.text = specificListing.sellerLabel
    }
    
    
    @IBAction func deleteListing(_ sender: Any) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else
        {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let myDeleteRequest = NSFetchRequest<NSManagedObject>(entityName: "Books")
        
        let titlePredicate = NSPredicate(format: "title = %@", specificListing.titleLabel)
        let pricePredicate = NSPredicate(format: "price = %@", specificListing.priceLabel)
        let sellerPredicate = NSPredicate(format: "sellerUsername = %@", specificListing.sellerLabel)
        let andPredicate = NSCompoundPredicate(type: NSCompoundPredicate.LogicalType.and, subpredicates: [titlePredicate,pricePredicate, sellerPredicate])
        myDeleteRequest.predicate = andPredicate
        //myDeleteRequest.predicate = NSPredicate(format: "title = %@", specificListing.titleLabel)
        //myDeleteRequest.predicate = NSPredicate(format: "price = %@", specificListing.priceLabel)
        //myDeleteRequest.predicate = NSPredicate(format: "sellerUsername = %@", specificListing.sellerLabel)
        //myDeleteRequest.predicate = NSPredicate(
        
        // BEGIN USERNAME CONFIRMATION
        do{
            let deleteResults = try managedContext.fetch(myDeleteRequest)
            
            for deleteResult in deleteResults
            {
                print(deleteResult)
                managedContext.delete(deleteResult)
                /* NOTE:
                 If there are results, this for loop will be entered and thus there is already a record with the attempted username
                 If there is no identical username already created, this loop will not even run once
                 */
                
                do{
                    try managedContext.save()
                } catch let error{
                    print(error)
                    return
                }
                
                performSegue(withIdentifier: "deleteSegue", sender: sender)
                return
            }
            
        } catch let error{
            print(error)
            return
        }
    }
    
}
