//
//  Recepie.swift
//  MyMeal
//
//  Created by Алексей Шпирко on 22/10/15.
//  Copyright © 2015 AlexShpirko LLC. All rights reserved.
//

import Foundation
import SwiftyJSON

class Recipe : RecipeData {
    
    var title: String
    let imageURL: NSURL
    let publisher: String
    let rank: NSNumber
    let recipeId : String
    let recipeURL: NSURL?
    let ingredients: Array<String>?
    var isFavorite: Bool
    
     func setFavorite(favorite: Bool) {
        isFavorite = favorite
    }
    
     func setTitle(newTitle: String) {
        title = newTitle
    }
    
    init(dictionary:JSON) {
        
        imageURL = NSURL(string: dictionary["image_url"].string!)!
        title = dictionary["title"].string!
        publisher = dictionary["publisher"].string!
        recipeURL = NSURL(string: dictionary["f2f_url"].string!)
        rank = dictionary["social_rank"].int!
        recipeId = dictionary["recipe_id"].string!
        ingredients = dictionary["ingredients"].array?.map({element -> String in
            
            return element.string!
        })
        isFavorite = false
    }
    
}
