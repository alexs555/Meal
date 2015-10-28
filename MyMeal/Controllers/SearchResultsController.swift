//
//  SearchResultsController.swift
//  MyMeal
//
//  Created by Алексей Шпирко on 24/10/15.
//  Copyright © 2015 AlexShpirko LLC. All rights reserved.
//

import UIKit
import MBProgressHUD
import DZNEmptyDataSet

// UITextFieldDelegate, UITableViewDelegate,UITableViewDatasource
class SearchResultsController: BaseViewController, UISearchBarDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var items:[Recipe]?
    var currentQuery: String?
    var dataProvider:RecipesDataProvider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        items = []
        
        dataProvider = RecipesDataProvider()
        tableView.estimatedRowHeight = 200.0
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.registerNib(UINib(nibName: "LoadingCell", bundle: nil), forCellReuseIdentifier: "LoadingCell")
        
        configureEmptyState()
    }
    
    func configureEmptyState() {
        tableView.emptyDataSetSource = self
        tableView.emptyDataSetDelegate = self
    }
    
    func loadData(query:String, force:Bool) {
        
        if (force) {
            let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
            hud.labelText = "Fetching recipes..."
            hud.mode = .Indeterminate
        }
        dataProvider.fetchRecipes(force,query:query,completionHandler:{ (recipes, success) -> Void in
            
           MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
            if let recipes = recipes {
                self.items?.appendContentsOf(recipes)
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
       
        let cell:UITableViewCell
        if (indexPath.row == ((items?.count)! - 1)) {
           let lCell = tableView.dequeueReusableCellWithIdentifier("LoadingCell", forIndexPath: indexPath) as! LoadingCell
            cell = lCell
            loadData(currentQuery!, force:false)
        } else {
            let recipe = items![indexPath.row]
            let rCell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! RecepiesCell
            rCell.updateWithRecipe(recipe)
            rCell.addTarget(self, action: "addToFavorites:")
            cell = rCell
        }
        
        return cell;
        
    }
    
    //MARK: Search bar delegate
     func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        
        items?.removeAll()
        currentQuery = searchBar.text!
        loadData(currentQuery!,force:true)
        searchBar.resignFirstResponder()
     }
    
    func addToFavorites(button:UIButton) {
        
        button.selected = !button.selected
        
    }
    
}


extension SearchResultsController : DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    
    func titleForEmptyDataSet(scrollView: UIScrollView!) -> NSAttributedString! {
        return NSAttributedString(string: searchWasActivated() ? "Nothing found :(" : "")
    }
    
    func descriptionForEmptyDataSet(scrollView: UIScrollView!) -> NSAttributedString! {
        return NSAttributedString(string: searchWasActivated() ? "Sorry about this, try to type less specific ingredients" : "")
    }
    
    func imageForEmptyDataSet(scrollView: UIScrollView!) -> UIImage! {
        
        return searchWasActivated() ? nil : UIImage(named:"search_dish")
    }
    
    func searchWasActivated() -> Bool {
        
        return searchBar.text!.characters.count > 0
    }
}
