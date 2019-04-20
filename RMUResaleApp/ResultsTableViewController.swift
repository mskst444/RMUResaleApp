//
//  ResultsTableViewController.swift
//  RMUResaleApp
//
//  Created by Jacob Wright on 4/19/19.
//  Copyright © 2019 Mitchell Keller. All rights reserved.
//

import UIKit
import CoreData

class ResultsTableViewController: UITableViewController {

   
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Search Results"
       
    }

    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SearchResult.title.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellidentifer = "ResultsTableViewCell"
       
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellidentifer, for: indexPath) as?
            ResultsTableViewCell else {
                fatalError("The dequeued cell is not an instance of MealTableViewCell.")
        }
        
        
        let titleData = SearchResult.title[indexPath.row]
        let authorData = SearchResult.author[indexPath.row]
        let priceData = SearchResult.price[indexPath.row]
        
        cell.titleLabel?.text = titleData
        cell.priceLabel?.text = "$" + "\(priceData)"
        cell.authorLabel?.text = authorData
        
        return cell
    }
    
    
    override func tableView( _ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
        let resultsVC = storyboard?.instantiateViewController(withIdentifier: "ResultsViewController") as! ResultsViewController
        
        ResultsData.titleData = SearchResult.title[indexPath.row]
        ResultsData.priceData = "\(SearchResult.price[indexPath.row])"
        ResultsData.authorData = SearchResult.author[indexPath.row]
        ResultsData.sellerData = SearchResult.sellerUsername[indexPath.row]
        
        
        navigationController?.pushViewController(resultsVC, animated: true)
    }
    

}

struct ResultsData {
    static var titleData = ""
    static var priceData = ""
    static var authorData = ""
    static var sellerData = ""
}
