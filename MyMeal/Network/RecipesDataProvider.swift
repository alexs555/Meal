//
//  RecipesDataProvider.swift
//  MyMeal
//
//  Created by Алексей Шпирко on 25/10/15.
//  Copyright © 2015 AlexShpirko LLC. All rights reserved.
//

import Foundation
import SwiftyJSON

func apiError(error: String) -> NSError {
    return NSError(domain: "FoodAPI", code: -1, userInfo: [NSLocalizedDescriptionKey: error])
}

public let ParseError = apiError("Error during parsing")

class RecipesDataProvider {
    
    private var currentPage = 0
    
    static func parseJSONArray(json:AnyObject?) throws -> [Recipe] {
        
            guard let resultJSON = json else {
                throw ParseError
            }

            var json = try JSON(resultJSON)
    
            let recipes = json["recipes"].array?.map({ element -> Recipe in
           
                return RecipesDataProvider.parseJSONItem(element)
            })
        
        return recipes!
        
    }
    
    static func parseJSONItem(json:JSON?) -> Recipe {
        
        let recipe = Recipe(dictionary: json!)
        return recipe
     
    }
    
    func fetchRecipes(forse:Bool,query:String, completionHandler:(recipes:[Recipe]?,success:Bool)->Void) {
        
        currentPage = forse ? 1 : ++currentPage
        ApiClient.defaultClient.fetchRecipesForQuery(query, page: currentPage , sort: SortType.Rating.rawValue, completionHandler:{ (recipes, success)-> Void in
            
            completionHandler(recipes:recipes, success:success)
        
        })
    }
    
    func recipeById(recipeId:String, completionHandler:(recipe:Recipe?, success:Bool) -> Void) {
        
        ApiClient.defaultClient.fetchRecipeById(recipeId, completionHandler:{ (recipe, success)-> Void in
            
            completionHandler(recipe:recipe, success:success)
            
        })
        
    }
}
