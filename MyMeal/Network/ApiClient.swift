//
//  ApiClient.swift
//  Tourist
//
//  Created by Алексей Шпирко on 23/09/15.
//  Copyright (c) 2015 AlexShpirko LLC. All rights reserved.
//

import Foundation
import MapKit
import Alamofire
import SwiftyJSON

class ApiClient {
    
    static let defaultClient = ApiClient()
    
    func fetchRecipesForQuery(
        query:String,
        page:Int,
        sort:String,
        completionHandler: (recipes:[Recipe]?,success:Bool) -> Void) {
        
            Alamofire.request(FoodRouter.SearchRecipes(query, page, sort)).responseJSON { response in
                
                if response.result.isSuccess {
                   
                    do {
                        let recipes = try RecipesDataProvider.parseJSONArray(response.result.value)
                        completionHandler(recipes: recipes, success: true)
                        
                        print("recipes \(recipes)")
                        
                    } catch let error as NSError {
                        print(error.localizedDescription)
                        completionHandler(recipes: nil, success: false)
                    }
                    
                } else {
                   completionHandler(recipes: nil, success: false) 
                }

            }
        }
    
    func fetchRecipeById(recipeId:String,
        completionHandler: (recipe :Recipe?, success:Bool) -> Void) {
        
            Alamofire.request(FoodRouter.GetRecipe(recipeId)).responseJSON { response in
                
                 if response.result.isSuccess {
                
                    let recipeJSON = JSON(response.result.value!)
                    let recipe = RecipesDataProvider.parseJSONItem(recipeJSON["recipe"])
                    completionHandler(recipe: recipe, success: true)
                    
                 }  else {
                    completionHandler(recipe: nil, success: false)
                }
            }
    }
            
}
    
