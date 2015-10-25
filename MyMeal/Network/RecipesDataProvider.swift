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
    
    static func parseJSON(json:AnyObject?) throws -> [Recipe] {
        
            guard let resultJSON = json else {
                throw ParseError
            }

            var json = try JSON(resultJSON)
    
            let recipes = json["recipes"].array?.map({ element -> Recipe in
           
                var jsonRecipe = element as JSON
                let URL = NSURL(string: jsonRecipe["f2f_url"].string!)
                let titleString = jsonRecipe["title"].string
                let recipe = Recipe(title:titleString!, URL:URL!)
                return recipe
            })
        
        return recipes!
        
    }
}
