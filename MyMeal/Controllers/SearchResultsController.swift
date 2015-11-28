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
import CoreData

class SearchResultsController: BaseViewController, UISearchBarDelegate {
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var items:[Recipe]?
    var favoriteItems:[RecipeModel]?
    var currentQuery: String?
    var dataProvider:RecipesDataProvider!
    var sortType = SortType.Rating
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        items = []
        
        segmentedControl.addTarget(self, action: "segmentPressed:", forControlEvents: UIControlEvents.ValueChanged)
        
        dataProvider = RecipesDataProvider()
        tableView.estimatedRowHeight = 200.0
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.registerNib(UINib(nibName: "LoadingCell", bundle: nil), forCellReuseIdentifier: "LoadingCell")
        
        fetchFavorities()
    }
    

    func segmentPressed(segment:UISegmentedControl) {
        
        sortType = segment.selectedSegmentIndex == 0 ? SortType.Rating : SortType.Tranding
        
    }
    
    func loadData(query:String, force:Bool) {
        
        if (force) {
            let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
            hud.labelText = "Fetching recipes..."
            hud.mode = .Indeterminate
        }
        dataProvider.fetchRecipes(sortType, force:force,query:query,completionHandler:{ (recipes, success) -> Void in
            
           MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
            
            if (!success) {
                
                self.showAlertWithText("Loading failed, check Internet connection, please")
                return
            }
            
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
        if (indexPath.row == ((items?.count)! - 1) && items?.count > 0) {
           let lCell = tableView.dequeueReusableCellWithIdentifier("LoadingCell", forIndexPath: indexPath) as! LoadingCell
            cell = lCell
            loadData(currentQuery!, force:false)
        } else {
            let recipe = items![indexPath.row]
            let rCell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! RecepiesCell
            rCell.updateWithRecipe(recipe)
            rCell.addTarget(self, action: "addToFavorites:")
            var isFav = isFavorite(recipe) // 1 step - check if item was fetched from DB
            if (!isFav) {
                isFav = recipe.isFavorite // 2 step - item could be set as favorite by pressing 'star'
            }
            rCell.setFavorite(isFav)
            cell = rCell
        }
        
        return cell;
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath ) -> Void {
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
        let recipe = items![indexPath.row]
        self.performSegueWithIdentifier("showRecipe", sender: recipe.recipeId)
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
        let view = button.superview!
        let cell = view.superview as! RecepiesCell
        let indexPath = tableView.indexPathForCell(cell)
        let recipe = items?[(indexPath?.row)!]
        recipe?.setFavorite(button.selected)
        if (recipe!.isFavorite) {
           saveRecipe(recipe!)
        } else {
            removeRecipe(recipe!)
        }
        CoreDataManager.sharedInstance.save()
    }
    

    
    func fetchFavorities() {
        
        let recipesRequest = NSFetchRequest(entityName: "RecipeModel")
        
        do {
         let _items = try CoreDataManager.sharedInstance.mainContex!.executeFetchRequest(recipesRequest) as? [RecipeModel]
          self.favoriteItems = _items
        } catch {
            print("no favorites exist")
        }
        
    }
    
    func isFavorite(recipe:RecipeData) -> Bool {
        
        var isFavorite = false
        if let _favItems = self.favoriteItems {
            for model in _favItems {
                isFavorite = model.recipeId == recipe.recipeId
                if (isFavorite) {
                    break
                }
            }
        }
        return isFavorite
    }

    
}



extension SearchResultsController {
    
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
