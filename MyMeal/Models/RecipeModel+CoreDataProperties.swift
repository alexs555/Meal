//
//  RecipeModel+CoreDataProperties.swift
//  
//
//  Created by Алексей Шпирко on 22/11/15.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension RecipeModel {

    @NSManaged var imageURL: String
    @NSManaged var publisher: String
    @NSManaged var rank: NSNumber
    @NSManaged var recipeId: String
    @NSManaged var recipeURL: String
    @NSManaged var title: String
    @NSManaged var ingredient: NSSet?

}
