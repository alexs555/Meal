//
//  RecipeController.swift
//  MyMeal
//
//  Created by Алексей Шпирко on 29/10/15.
//  Copyright © 2015 AlexShpirko LLC. All rights reserved.
//

import UIKit

class RecipeController: BaseViewController {
    
    var recipeId:String?
    var recipesProvider: RecipesDataProvider?
    var dataSource:RecipeDataSource!

   // @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let recipesProvider = recipesProvider,
            let recipeId = recipeId {
            
                recipesProvider.recipeById(recipeId, completionHandler:{ (recipe, success) -> Void in
                    
                    if let recipe = recipe {
                        print(recipe)
                        self.setupDataSource(recipe)
                    } else {
                        //show error
                    }
                    self.tableView.reloadData()
                    
                })
        }
        
        tableView.registerNib(UINib(nibName: "TitleCell", bundle: nil), forCellReuseIdentifier: "TitleCell")
        tableView.registerNib(UINib(nibName: "ImageCellTableViewCell", bundle: nil), forCellReuseIdentifier: "ImageCellTableViewCell")
        tableView.registerNib(UINib(nibName: "IngredientCell", bundle: nil), forCellReuseIdentifier: "IngredientCell")
        tableView.estimatedRowHeight = 100.0
        tableView.rowHeight = UITableViewAutomaticDimension

        // Do any additional setup after loading the view.
    }

    func setupDataSource(item:Recipe) {
        
        dataSource = RecipeDataSource(item: item)
        tableView.dataSource = dataSource
        tableView.delegate = dataSource
    }
    
    @IBAction func addToFavoritesPressed(sender: AnyObject) {
        
        
    }

  

}
