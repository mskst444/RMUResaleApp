//
//  CoreDataFunctions.swift
//  RMUResaleApp
//
//  Created by Mitchell Keller on 4/17/19.
//  Copyright © 2019 Mitchell Keller. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class CoreDataFunctions
{
    
    
    //Function to save the new account data into our core data entity: Accounts
    func save(_ firstName: String, _ lastName: String, _ email: String, _ username: String, _ password: String)
    {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else
        {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Accounts", in: managedContext)!
        
        let item = NSManagedObject(entity: entity, insertInto: managedContext)
        
        item.setValue(firstName, forKeyPath: "firstName")
        item.setValue(lastName, forKeyPath: "lastName")
        item.setValue(email, forKeyPath: "email")
        item.setValue(username, forKeyPath: "username")
        item.setValue(password, forKeyPath: "password")
        
    }
}
