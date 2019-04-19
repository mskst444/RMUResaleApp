//
//  NewBookViewController.swift
//  RMUResaleApp
//
//  Created by Jacob Wright on 4/17/19.
//  Copyright © 2019 Mitchell Keller. All rights reserved.
//

import UIKit
import CoreData

class NewBookViewController: UIViewController, UITextFieldDelegate{
    
    @IBOutlet weak var newTitle: UITextField!
    @IBOutlet weak var newPrice: UITextField!
    @IBOutlet weak var newISBN: UITextField!
    @IBOutlet weak var newAuthor: UITextField!
    
    @IBOutlet weak var displayName: UILabel!
    @IBOutlet weak var displayEmail: UILabel!
    
    let alert = UIAlertController(title: "Invalid Entry", message: "Invalid Entry. Required Fields Missing", preferredStyle: .alert)
    let closeAction = UIAlertAction(title: "Close", style: .default)
    
    var newPosts: [NSManagedObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.newTitle.delegate = self
        self.newPrice.delegate = self
        self.newISBN.delegate  = self
        self.newAuthor.delegate = self
        
    }
    
    
    @IBAction func newListing(_ sender: Any) {
        let getUser = UserInformation()
        getUser.userFetchRequest(username: Username.userMaster)
        let seller = getUser.userName
        
        if(self.newTitle.text == "" ||
            self.newPrice.text == "" ||
            self.newISBN.text == "" ||
            self.newAuthor.text == "")
        {
            alert.addAction(closeAction)
            present(alert, animated:true)
        }
        else
        {
            let newTitle = self.newTitle.text!
            let priceNum = Double(newPrice.text!)!
            let newISBN = self.newISBN.text!
            let newAuthor = self.newAuthor.text!
            
            save(newTitle, priceNum, newISBN, newAuthor, seller)
            checkBooksEntity()
            
        }
    }
    
    func save(_ newTitle: String, _ priceNum: Double, _ newISBN: String, _ newAuthor: String, _ seller: String)
    {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else
        {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Books", in: managedContext)!
        let book = NSManagedObject(entity: entity, insertInto: managedContext)
        
        book.setValue(newTitle, forKeyPath: "title")
        book.setValue(priceNum, forKeyPath: "price")
        book.setValue(newISBN, forKeyPath: "isbn")
        book.setValue(newAuthor, forKeyPath: "author")
        book.setValue(seller, forKeyPath: "sellerUsername")
    }
    
    func checkBooksEntity(){
        
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else
        {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let myRequest = NSFetchRequest<NSManagedObject>(entityName: "Books")
        
        do{
            let results = try managedContext.fetch(myRequest)
            
            for result in results
            {
                print(result.value(forKey: "author")!)
                print(result.value(forKey: "isbn")!)
                print(result.value(forKey: "price")!)
                print(result.value(forKey: "sellerUsername")!)
                print(result.value(forKey: "title")!)

            }
            
        } catch let error{
            print(error)
            return
        }
    }
    
}