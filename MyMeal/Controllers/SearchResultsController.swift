//
//  SearchResultsController.swift
//  MyMeal
//
//  Created by Алексей Шпирко on 24/10/15.
//  Copyright © 2015 AlexShpirko LLC. All rights reserved.
//

import UIKit

// UITextFieldDelegate, UITableViewDelegate,UITableViewDatasource
class SearchResultsController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textField: UITextField!
    
    var items:[Recipe]?
    var currentPage = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        items = []
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func loadData(query:String,page:Int,sort:String) {
        
        ApiClient.defaultClient.fetchRecipesForQuery("", page: 100  , sort: "t", completionHandler:{ (recipes, success)-> Void in
            
            print(recipes)
            if let recipes = recipes {
                self.items = recipes
            } else {
                //show error
            }
            self.tableView.reloadData()
            
        })
        
    }
    
    //MARK: Tableview delegate&datasourse
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return items!.count;
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! RecepiesCell
        var recipe = items![indexPath.row]
        cell.updateWithRecipe(recipe)
        return cell;
        
    }
    
    //MARK: Textfield delegate

    func textFieldShouldReturn(textField: UITextField!) -> Bool {   //delegate method
        textField.resignFirstResponder()
        
        loadData(textField.text!, page: currentPage, sort: SortType.Rating.rawValue)
        return true
    }
    
}
