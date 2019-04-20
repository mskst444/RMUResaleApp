//
//  SortByViewController.swift
//  RMUResaleApp
//
//  Created by Mitchell Keller on 4/20/19.
//  Copyright © 2019 Mitchell Keller. All rights reserved.
//

import UIKit

class SortViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var sortPicker: UIPickerView!
    
    var pickerData: [String] = [String]()
    var authorResults:[String] = SearchResult.author
    let isbnResults:[String] = SearchResult.isbn
    let priceResults:[Float] = SearchResult.price
    let sellerResults:[String] = SearchResult.sellerUsername
    let titleResults:[String] = SearchResult.title
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.sortPicker.delegate = self
        self.sortPicker.dataSource = self
        
        pickerData = ["- None -","Price: Low to High", "Price: High to Low"]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Number of columns of data
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    // The data to return fopr the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // This method is triggered whenever the user makes a change to the picker selection.
        // The parameter named row and component represents what was selected.
        print("Picker: ")
        print(row)
        print(pickerData[row])
        SortSetting.sortBy = pickerData[row]
        print(SortSetting.sortBy)
    }
    @IBAction func applySortButton(_ sender: Any) {
        sortResults(SortSetting.sortBy)
        performSegue(withIdentifier: "applyFilter", sender: sender)
    }
    func sortResults (_ sortSetting: String){
        let arraySize = SearchResult.author.count - 1
        var priceTemp: Float = 0.0
        var temp: String = ""
        
        
        
        if(sortSetting == "Price: Low to High"){
            for j in 0...arraySize {
                var lowestPrice = SearchResult.price[j]
                var newLowPriceIndex = j
                for i in j...arraySize {
                    if SearchResult.price[i] < lowestPrice {
                        lowestPrice = SearchResult.price[i]
                        newLowPriceIndex = i
                    }
                }
                priceTemp = SearchResult.price[j]
                SearchResult.price[j] = SearchResult.price[newLowPriceIndex]
                SearchResult.price[newLowPriceIndex] = priceTemp
                
                temp = SearchResult.author[j]
                SearchResult.author[j] = SearchResult.author[newLowPriceIndex]
                SearchResult.author[newLowPriceIndex] = temp
                
                temp = SearchResult.isbn[j]
                SearchResult.isbn[j] = SearchResult.isbn[newLowPriceIndex]
                SearchResult.isbn[newLowPriceIndex] = temp
                
                temp = SearchResult.sellerUsername[j]
                SearchResult.sellerUsername[j] = SearchResult.sellerUsername[newLowPriceIndex]
                SearchResult.sellerUsername[newLowPriceIndex] = temp
                
                temp = SearchResult.title[j]
                SearchResult.title[j] = SearchResult.title[newLowPriceIndex]
                SearchResult.title[newLowPriceIndex] = temp
            }
        }
        else if(sortSetting == "Price: High to Low"){
            for j in 0...arraySize {
                var highestPrice = SearchResult.price[j]
                var newHighPriceIndex = j
                for i in j...arraySize {
                    if SearchResult.price[i] > highestPrice {
                        highestPrice = SearchResult.price[i]
                        newHighPriceIndex = i
                    }
                }
                priceTemp = SearchResult.price[j]
                SearchResult.price[j] = SearchResult.price[newHighPriceIndex]
                SearchResult.price[newHighPriceIndex] = priceTemp
                
                temp = SearchResult.author[j]
                SearchResult.author[j] = SearchResult.author[newHighPriceIndex]
                SearchResult.author[newHighPriceIndex] = temp
                
                temp = SearchResult.isbn[j]
                SearchResult.isbn[j] = SearchResult.isbn[newHighPriceIndex]
                SearchResult.isbn[newHighPriceIndex] = temp
                
                temp = SearchResult.sellerUsername[j]
                SearchResult.sellerUsername[j] = SearchResult.sellerUsername[newHighPriceIndex]
                SearchResult.sellerUsername[newHighPriceIndex] = temp
                
                temp = SearchResult.title[j]
                SearchResult.title[j] = SearchResult.title[newHighPriceIndex]
                SearchResult.title[newHighPriceIndex] = temp
            }
        }
        else{
            SearchResult.author = authorResults
            SearchResult.isbn = isbnResults
            SearchResult.price = priceResults
            SearchResult.sellerUsername = sellerResults
            SearchResult.title = titleResults
        }
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

struct SortSetting {
    static var sortBy: String = ""
}

