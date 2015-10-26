//
//  Recepie.swift
//  MyMeal
//
//  Created by Алексей Шпирко on 22/10/15.
//  Copyright © 2015 AlexShpirko LLC. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Recipe  {
    
    let title: String?
    let imageURL: NSURL?
    let publisher: String?
    let rank: Int?
    let recipeId : String?
    let recipeURL: NSURL?
    
    
    init(dictionary:JSON) {
        
        imageURL = NSURL(string: dictionary["image_url"].string!)
        title = dictionary["title"].string
        publisher = dictionary["publisher"].string
        recipeURL = NSURL(string: dictionary["f2f_url"].string!)
        rank = dictionary["social_rank"].int
        recipeId = dictionary["recipe_id"].string
    }
    
}
