//
//  RecipeData.swift
//  MyMeal
//
//  Created by Алексей Шпирко on 12/11/15.
//  Copyright © 2015 AlexShpirko LLC. All rights reserved.
//

import Foundation

@objc(RecipeData)
protocol RecipeData {
    
    var title: String { get set}
    var URL: NSURL { get }
    var imageURL: String { get }
    var publisher: String { get set}
    var rank: NSNumber {get set}
    var isFavorite: Bool { get }
    var recipeId: String { get set}
    
    func setFavorite(favorite: Bool)
}
