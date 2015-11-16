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
    
    @objc var title: String
    @objc let imageURL: String
    @objc var publisher: String
    @objc var rank: NSNumber
    @objc var recipeId : String
    @objc let URL: NSURL
    @objc let ingredients: Array<String>?
    @objc var isFavorite: Bool
    
     @objc func setFavorite(favorite: Bool) {
        isFavorite = favorite
    }
    
     func setTitle(newTitle: String) {
        title = newTitle
    }
    
    init(dictionary:JSON) {
        
        imageURL = dictionary["image_url"].string!
        title = dictionary["title"].string!
        publisher = dictionary["publisher"].string!
        URL = NSURL(string: dictionary["f2f_url"].string!)!
        rank = dictionary["social_rank"].int!
        recipeId = dictionary["recipe_id"].string!
        ingredients = dictionary["ingredients"].array?.map({element -> String in
            
            return element.string!
        })
        isFavorite = false
    }
    
}
