//
//  FoodAPI.swift
//  MyMeal
//
//  Created by Алексей Шпирко on 19/10/15.
//  Copyright © 2015 AlexShpirko LLC. All rights reserved.
//

import Foundation
import Alamofire
import MapKit

let key = "73e3ebee222652cf459384f7dbcb6c4c"


enum SortType: String {
    case Tranding = "t", Rating = "r"
}

enum FoodRouter: URLRequestConvertible {
    
    static let baseURLString = "http://food2fork.com/api/"
    
    case SearchRecipes(String, Int, String)
    case GetRecipe(String)
    
    
    var method: Alamofire.Method {
        
        return .GET
    }
    var path: String {
        
        switch self {
            
            case .SearchRecipes(_, _, _):
                return "search"
            case .GetRecipe(_):
                return "get"
        }
        
    }
    
    var URLRequest: NSMutableURLRequest {
        
        let URL = NSURL(string: FoodRouter.baseURLString)!
        let mutableURLRequest = NSMutableURLRequest(URL: URL.URLByAppendingPathComponent(path))
        mutableURLRequest.HTTPMethod = method.rawValue
        mutableURLRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        mutableURLRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        switch self {
            
            case .SearchRecipes(let query, let page, let sort):
                
                return Alamofire.ParameterEncoding.URL.encode(mutableURLRequest, parameters:
                    ["key": key,
                    "q":query,
                    "page" : page,
                    "sort" : sort,
                    ]).0
            case .GetRecipe(let recipeId):
            
                return Alamofire.ParameterEncoding.URL.encode(mutableURLRequest, parameters:
                    ["key": key,
                     "rId":recipeId
                    ]).0
            
            default:
                return mutableURLRequest
        }
    }
    
}
