//
//  UserInformation.swift
//  RMUResaleApp
//
//  Created by Jacob Wright on 4/17/19.
//  Copyright © 2019 Mitchell Keller. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class UserInformation
{
    var userName: String
    var userPassword: String
    var userEmail: String
    var userFirstName: String
    var userLastName: String
    
    public func userFetchRequest(username: String)
    {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else
        {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSManagedObject>(entityName: "Accounts")
        
        request.predicate = NSPredicate(format: "username = %@", username)
        
        do{
            let results = try managedContext.fetch(request)
            
            for result in results
            {
                userName = "\(result.value(forKey: "username")!)"
                userPassword = "\(result.value(forKey: "password")!)"
                userEmail = "\(result.value(forKey: "email")!)"
                userFirstName = "\(result.value(forKey: "firstName")!)"
                userLastName = "\(result.value(forKey: "lastName")!)"
            }
            return
            
        }
            
        catch let error{
            print(error)
            return
        }
    }
    
    
    init()
    {
        userName = ""
        userPassword = ""
        userEmail = ""
        userFirstName = ""
        userLastName = ""
    }
    
}
