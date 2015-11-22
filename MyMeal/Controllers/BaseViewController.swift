//
//  BaseViewController.swift
//  MyMeal
//
//  Created by Алексей Шпирко on 25/10/15.
//  Copyright © 2015 AlexShpirko LLC. All rights reserved.
//

import UIKit
import StatefulViewController
import DZNEmptyDataSet

class BaseViewController: UIViewController, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureEmptyState()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func configureEmptyState() {
        tableView.emptyDataSetSource = self
        tableView.emptyDataSetDelegate = self
    }
   
    
    func removeRecipe(recipe:RecipeData) {
        
        let _recipe:RecipeModel? = CoreDataManager.sharedInstance.entity(recipe.recipeId,force:true)
        CoreDataManager.sharedInstance.removeEntity(_recipe!)
        CoreDataManager.sharedInstance.save()
    }

    func setupViews() {
        
       //override in subclasses
    }
    
    func saveRecipe(recipe:RecipeData) {
        
        let _recipe:RecipeModel? = CoreDataManager.sharedInstance.entity(recipe.recipeId,force:true)
        _recipe!.title = recipe.title
        _recipe!.rank = recipe.rank
        _recipe!.publisher = recipe.publisher
        _recipe!.imageURL = recipe.imageURL
        _recipe!.recipeId = recipe.recipeId
        
        CoreDataManager.sharedInstance.save()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let destinationController = segue.destinationViewController as! RecipeController
        destinationController.recipeId = sender as? String
        
    }

}
