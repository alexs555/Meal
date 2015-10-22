//
//  FoodAPI.swift
//  MyMeal
//
//  Created by Алексей Шпирко on 19/10/15.
//  Copyright © 2015 AlexShpirko LLC. All rights reserved.
//
import Foundation
#if !RX_NO_MODULE
    import RxSwift
    import RxCocoa
#endif

func apiError(error: String) -> NSError {
    return NSError(domain: "FoodAPI", code: -1, userInfo: [NSLocalizedDescriptionKey: error])
}

public let FoodParseError = apiError("Error during parsing")

func URLEscape(pathSegment: String) -> String {
    return pathSegment.stringByAddingPercentEncodingWithAllowedCharacters(.URLHostAllowedCharacterSet())!
}

public let ApiParseError = apiError("Error during parsing")

protocol FoodAPI {
    func getSearchResults(query: String) -> Observable<[Recepie]>
   // func recepeContent(searchResult: Int) -> Observable<String>
}

class DefaultAPI: FoodAPI {
    
    static let sharedAPI = DefaultAPI() // Singleton
    
    let baseUrl = "http://food2fork.com/api/search?key=73e3ebee222652cf459384f7dbcb6c4c"
    
    let $: Dependencies = Dependencies.sharedDependencies
    
    private init() {}
    //73e3ebee222652cf459384f7dbcb6c4c
    // Example wikipedia response http://en.wikipedia.org/w/api.php?action=opensearch&search=Rx
   // http://food2fork.com/api/search?key={API_KEY}&q=shredded%20chicken
    
    func getSearchResults(query: String) -> Observable<[Recepie]> {
        let escapedQuery = URLEscape(query)
        let urlContent = "\(baseUrl)&q=\(escapedQuery)"
        let url = NSURL(string: urlContent)!
        
        return $.URLSession
            .rx_JSON(url)
            .observeOn($.backgroundWorkScheduler)
            .map { json in
                guard let json = json as? [AnyObject] else {
                    throw  NSError(domain: "ParsingError", code: -1, userInfo: nil)
                }
                return try Recepie.parseJSON(json)
            }
            .observeOn($.mainScheduler)
    }
    
    // http://en.wikipedia.org/w/api.php?action=parse&page=rx&format=json
    /*func recepeContent(searchResult: WikipediaSearchResult) -> Observable<WikipediaPage> {
        let escapedPage = URLEscape(searchResult.title)
        guard let url = NSURL(string: "http://en.wikipedia.org/w/api.php?action=parse&page=\(escapedPage)&format=json") else {
            return failWith(apiError("Can't create url"))
        }
        
        return $.URLSession.rx_JSON(url)
            .map { jsonResult in
                guard let json = jsonResult as? NSDictionary else {
                    throw exampleError("Parsing error")
                }
                
                return try WikipediaPage.parseJSON(json)
            }
            .observeOn($.mainScheduler)
    }*/
}