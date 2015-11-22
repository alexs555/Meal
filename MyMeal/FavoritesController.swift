//
//  ViewController.swift
//  MyMeal
//
//  Created by Алексей Шпирко on 13/10/15.
//  Copyright (c) 2015 AlexShpirko LLC. All rights reserved.
//

import UIKit
import DZNEmptyDataSet
import CoreData

class FavoritesController: BaseViewController, NSFetchedResultsControllerDelegate {

      var items:[RecipeModel]?
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
          try fetchedResultsController.performFetch()
        } catch {
            print("error!")
        }
       
        
        items = fetchedResultsController.fetchedObjects as? Array<RecipeModel>
        
        tableView.estimatedRowHeight = 200.0
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.registerNib(UINib(nibName: "LoadingCell", bundle: nil), forCellReuseIdentifier: "LoadingCell")
        title = "Favorites"
    }
    
    override func viewWillAppear(animated: Bool) {
        
        tableView.reloadData()
        
    }

   
    
    lazy var fetchedResultsController: NSFetchedResultsController = {
        
        var recipesRequest = NSFetchRequest(entityName: "RecipeModel")
        
        let primarySortDescriptor = NSSortDescriptor(key: "recipeId", ascending: true)
        recipesRequest.sortDescriptors = [primarySortDescriptor]
        
        let frc = NSFetchedResultsController(
            fetchRequest: recipesRequest,
            managedObjectContext: CoreDataManager.sharedInstance.mainContex!,
            sectionNameKeyPath: nil,
            cacheName: nil)
        
        frc.delegate = self
        
        return frc
        }()
    

    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        items = controller.fetchedObjects as? Array<RecipeModel>
        tableView.reloadData()
    }

}

extension FavoritesController: UITableViewDataSource {
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let sections = fetchedResultsController.sections {
            let currentSection: AnyObject = sections[section]
            return currentSection.numberOfObjects
        }
        return 0
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let recipe = fetchedResultsController.objectAtIndexPath(indexPath) as! RecipeModel
        let rCell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! RecepiesCell
        rCell.updateWithRecipe(recipe)
        rCell.addTarget(self, action: "remove:")
        return rCell
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath ) -> Void {
        
        let recipe = items![indexPath.row]
        self.performSegueWithIdentifier("showRecipe", sender: recipe.recipeId)
    }
    
    func remove(button:UIButton) {
        
        let view = button.superview!
        let cell = view.superview as! RecepiesCell
        let indexPath = tableView.indexPathForCell(cell)
        let recipe = fetchedResultsController.objectAtIndexPath(indexPath!) as! RecipeModel
        self.removeRecipe(recipe)
        tableView.reloadData()
        
    }
    
}




extension FavoritesController {
    
    func titleForEmptyDataSet(scrollView: UIScrollView!) -> NSAttributedString! {
        return NSAttributedString(string:"No favorites :(")
    }
    
    func descriptionForEmptyDataSet(scrollView: UIScrollView!) -> NSAttributedString! {
        return NSAttributedString(string:"Tap 'star' button on any recipe you like to add it to favorities")
    }
    
    func imageForEmptyDataSet(scrollView: UIScrollView!) -> UIImage! {
        
        return  UIImage(named:"big_star")
    }
  
}
