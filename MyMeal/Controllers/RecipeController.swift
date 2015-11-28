//
//  RecipeController.swift
//  MyMeal
//
//  Created by Алексей Шпирко on 29/10/15.
//  Copyright © 2015 AlexShpirko LLC. All rights reserved.
//

import UIKit
import MBProgressHUD

class RecipeController: BaseViewController {
    
    var recipeId:String?
    var recipesProvider: RecipesDataProvider?
    var dataSource:RecipeDataSource!
    var currentRecipe: Recipe?
    var isFavorite = false

   // @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        recipesProvider = RecipesDataProvider()
        title = "Recipe"
        
        let _recipe:RecipeModel? = CoreDataManager.sharedInstance.entity(recipeId!,force:false)
        if let _ = _recipe {
            isFavorite = true
        }
        
        let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        hud.labelText = "Fetching recipe data..."
        hud.mode = .Indeterminate
        if let recipesProvider = recipesProvider,
            let recipeId = recipeId {
            
                recipesProvider.recipeById(recipeId, completionHandler:{ (recipe, success) -> Void in
                    
                    MBProgressHUD.hideAllHUDsForView(self.view, animated: true)

                    if let recipe = recipe {
                        self.currentRecipe = recipe
                        self.configureNavBar()
                        self.setupDataSource(recipe)

                    } else {
                        self.showAlertWithText("Loading failed, check Internet connection, please")
                    }
                    self.tableView.reloadData()
                    
                })
        }
        
        tableView.registerNib(UINib(nibName: "TitleCell", bundle: nil), forCellReuseIdentifier: "TitleCell")
        tableView.registerNib(UINib(nibName: "ImageCellTableViewCell", bundle: nil), forCellReuseIdentifier: "ImageCellTableViewCell")
        tableView.registerNib(UINib(nibName: "IngredientCell", bundle: nil), forCellReuseIdentifier: "IngredientCell")
        tableView.estimatedRowHeight = 100.0
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.allowsSelection = false
        configureNavBar()

        // Do any additional setup after loading the view.
    }

    func setupDataSource(item:Recipe) {
        
        dataSource = RecipeDataSource(item: item)
        tableView.dataSource = dataSource
        tableView.delegate = dataSource
    }
    
    @IBAction func addToFavoritesPressed(button: UIButton) {
        
        button.selected = !button.selected
        currentRecipe?.setFavorite(button.selected)
        isFavorite = !isFavorite
        if (currentRecipe!.isFavorite) {
            saveRecipe(currentRecipe!)
        } else {
            removeRecipe(currentRecipe!)
        }
        //configureNavBar()
        
    }

    func configureNavBar() {
        
        let starButton = UIButton(type: UIButtonType.Custom)
        starButton.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        starButton.setImage(UIImage(named:"star"), forState: UIControlState.Normal)
        starButton.setImage(UIImage(named:"star_selected"), forState: UIControlState.Selected)
        starButton.setImage(UIImage(named:"star_selected"), forState: UIControlState.Highlighted)
        starButton.addTarget(self, action: "addToFavoritesPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        let rightBtn = UIBarButtonItem(customView: starButton)
        navigationItem.rightBarButtonItem = rightBtn
        starButton.selected = isFavorite

    }

}
