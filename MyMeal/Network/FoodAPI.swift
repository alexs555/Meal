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


enum SortType: String {
    case Tranding = "t", Rating = "r"
}

enum FoodRouter: URLRequestConvertible {
    
    static let baseURLString = "http://food2fork.com/api/search"
    
    case SearchRecipes(String, Int, String)
    
    
    var method: Alamofire.Method {
        
        return .GET
    }
    var path: String {
        
        return ""
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
                    ["key": "73e3ebee222652cf459384f7dbcb6c4c",
                    "q":query,
                    "page" : page,
                    "sort" : sort,
                    ]).0
            default:
                return mutableURLRequest
        }
    }
    
}
