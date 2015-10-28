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
    
    private var currentPage = -1
    
    static func parseJSON(json:AnyObject?) throws -> [Recipe] {
        
            guard let resultJSON = json else {
                throw ParseError
            }

            var json = try JSON(resultJSON)
    
            let recipes = json["recipes"].array?.map({ element -> Recipe in
           
                let jsonRecipe = element as JSON
                let recipe = Recipe(dictionary: jsonRecipe)
                return recipe
            })
        
        return recipes!
        
    }
    
    func fetchRecipes(forse:Bool,query:String, completionHandler:(recipes:[Recipe]?,success:Bool)->Void) {
        
        currentPage = forse ? 0 : ++currentPage
        ApiClient.defaultClient.fetchRecipesForQuery(query, page: currentPage , sort: SortType.Rating.rawValue, completionHandler:{ (recipes, success)-> Void in
            
            completionHandler(recipes:recipes, success:success)
        
        })
        
    }
}
