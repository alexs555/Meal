//
//  RecipeData.swift
//  MyMeal
//
//  Created by Алексей Шпирко on 12/11/15.
//  Copyright © 2015 AlexShpirko LLC. All rights reserved.
//

import Foundation

protocol RecipeData {
    
    var title: String { get }
    var imageURL: NSURL { get }
    var publisher: String { get }
    var rank: NSNumber {get}
    var isFavorite: Bool {set get}
    var recipeId: String { get}
    
    mutating func setFavorite(favorite: Bool)
}
