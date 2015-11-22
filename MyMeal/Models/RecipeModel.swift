//
//  RecipeModel.swift
//  
//
//  Created by Алексей Шпирко on 22/11/15.
//
//

import Foundation
import CoreData

@objc(RecipeModel)
class RecipeModel: NSManagedObject, RecipeData {

// Insert code here to add functionality to your managed object subclass
    
    func setFavorite(favorite: Bool) {
        
    }
    
    var URL:NSURL {
        get {
            return NSURL(string: self.recipeURL)!
        }
    }
    
    var isFavorite:Bool {
        
        get {
            return true
        }
        
    }
}

