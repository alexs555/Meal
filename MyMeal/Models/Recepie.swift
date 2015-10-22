//
//  Recepie.swift
//  MyMeal
//
//  Created by Алексей Шпирко on 22/10/15.
//  Copyright © 2015 AlexShpirko LLC. All rights reserved.
//

import Foundation


struct Recepie : CustomStringConvertible {
    
    let title: String
    let description: String
    let URL: NSURL
    
    static func parseJSON(json: [AnyObject]) throws -> [Recepie] {
        let rootArrayTyped = json.map { $0 as? [AnyObject] }
            .filter { $0 != nil }
            .map { $0! }
        
        if rootArrayTyped.count != 3 {
            throw FoodParseError
        }
        
        let titleAndDescription = Array(Swift.zip(rootArrayTyped[0], rootArrayTyped[1]))
        let titleDescriptionAndUrl: [((AnyObject, AnyObject), AnyObject)] = Array(Swift.zip(titleAndDescription, rootArrayTyped[2]))
        
        let searchResults: [Recepie] = try titleDescriptionAndUrl.map ( { result -> Recepie in
            let (first, url) = result
            let (title, description) = first
            
            guard let titleString = title as? String,
                let descriptionString = description as? String,
                let urlString = url as? String,
                let URL = NSURL(string: urlString) else {
                    throw FoodParseError
            }
            
            return Recepie(title: titleString, description: descriptionString, URL: URL)
        })
        
        return searchResults
    }
}
