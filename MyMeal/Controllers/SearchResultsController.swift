//
//  SearchResultsController.swift
//  MyMeal
//
//  Created by Алексей Шпирко on 24/10/15.
//  Copyright © 2015 AlexShpirko LLC. All rights reserved.
//

import UIKit

// UITextFieldDelegate, UITableViewDelegate,UITableViewDatasource
class SearchResultsController: BaseViewController, UISearchBarDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textField: UITextField!
    
    var items:[Recipe]?
    var currentPage = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        items = []
        
        tableView.estimatedRowHeight = 200.0
        tableView.rowHeight = UITableViewAutomaticDimension
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(animated:Bool) {
        super.viewDidAppear(animated)
        
        //tableView.reloadData()
        
    }
    
    func loadData(query:String,page:Int,sort:String) {
        
        ApiClient.defaultClient.fetchRecipesForQuery(query, page: page , sort: sort, completionHandler:{ (recipes, success)-> Void in
            
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
        let recipe = items![indexPath.row]
        cell.updateWithRecipe(recipe)
        cell.addTarget(self, action: "addToFavorites:")
        return cell;
        
    }
    
    
    //MARK: Search bar delegate
     func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        
         loadData(searchBar.text!, page: currentPage, sort: SortType.Rating.rawValue)
     }
    
    func addToFavorites(button:UIButton) {
        
        button.selected = !button.selected
        
    }
    
}
