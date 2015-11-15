//
//  RecipeDataSource.swift
//  MyMeal
//
//  Created by Алексей Шпирко on 01/11/15.
//  Copyright © 2015 AlexShpirko LLC. All rights reserved.
//

import Foundation
import UIKit



class RecipeDataSource: NSObject, UITableViewDelegate, UITableViewDataSource {
    
     var titleIdentifier = "TitleCell"
     var imageViewIdentifier = "ImageCellTableViewCell"
     var ingredientIdentifier =  "IngredientCell"
     var recipe:Recipe?
    
    init(item : Recipe) {
        
        recipe = item
        
    }
    

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //title+image+ingredients
        return 2 + (recipe?.ingredients?.count)!;
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell:BaseTableViewCell
        if (indexPath.row == 0) {
            let titleCell = tableView.dequeueReusableCellWithIdentifier(titleIdentifier, forIndexPath: indexPath) as! TitleCell
            cell = titleCell
        } else if (indexPath.row == 1) {
            let imageCell = tableView.dequeueReusableCellWithIdentifier(imageViewIdentifier, forIndexPath: indexPath) as! ImageCellTableViewCell
            cell = imageCell
            
        } else {
            
            let ingredients = recipe!.ingredients
            let stringIngredient = ingredients![indexPath.row - 2]
            let ingredientCell = tableView.dequeueReusableCellWithIdentifier(ingredientIdentifier, forIndexPath: indexPath) as! IngredientCell
            ingredientCell.updateWithIngredient(stringIngredient)
            cell = ingredientCell
            return cell
        }
        
        cell.updateWithItem(recipe!)
        return cell
        
    }
    
}

