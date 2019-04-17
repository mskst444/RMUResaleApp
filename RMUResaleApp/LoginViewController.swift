//
//  LoginViewController.swift
//  RMUResaleApp
//
//  Created by Mitchell Keller on 4/3/19.
//  Copyright © 2019 Mitchell Keller. All rights reserved.
//

import UIKit
import CoreData

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    let wrongUsername: String = "Invalid Username"
    let wrongPassword: String = "Invalid Password"
    let blankFields: String = "Enter Username and Password"
    //textField outlets
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var warningLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.passwordField.delegate = self
        self.usernameField.delegate = self
        self.warningLabel.text = " "
        
        let tapRecognizer = UITapGestureRecognizer()
        tapRecognizer.addTarget(self, action: #selector(self.dismissKeyboard))
        self.view.addGestureRecognizer(tapRecognizer)
    }
    
    //Method for dismissing keyboard with return key
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    //This method will work for ALL text fields
    //dismiss keyboard when tapping elsewhere
    @objc func dismissKeyboard()
    {
        self.view.endEditing(true)
    }
    

    @IBAction func loginButton(_ sender: Any) {

        if(self.passwordField.text == "" || self.usernameField.text == "") {
            self.warningLabel.text = blankFields
        }
        else {
            let username = self.usernameField.text!
            if(myFetchRequest(username: username)){
                performSegue(withIdentifier: "loginSegue", sender: sender)
            }
            else{
                self.warningLabel.text = wrongUsername
            }
        }
    }
    @IBAction func unwindToVC(segue: UIStoryboardSegue){
        
    }
    
    //Function to search Core Data for matching usernames
    func myFetchRequest(username: String) -> Bool
    {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else
        {
            return false
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let myRequest = NSFetchRequest<NSManagedObject>(entityName: "Accounts")
        
        myRequest.predicate = NSPredicate(format: "username = %@", username)
        
        do{
            let results = try managedContext.fetch(myRequest)
            
            for result in results
            {
                let usernameCheck = result.value(forKey: "username")!
                let stringUsernameCheck = "\(usernameCheck)"
                if (username == stringUsernameCheck){
                    return true
                    print("YAY")
                }
                else{
                    return false
                }
            }
            
        } catch let error{
            print(error)
            return false
        }
        return false
    }
    /*
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
     
 */
    
}

