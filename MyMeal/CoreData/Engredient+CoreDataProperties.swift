//
//  Engredient+CoreDataProperties.swift
//  
//
//  Created by Алексей Шпирко on 11/11/15.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Engredient {

    @NSManaged var title: String?
    @NSManaged var recipe: RecipeModel?

}
