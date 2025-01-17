//
//  FourSquareRequest.swift
//  RecipeSearch
//
//  Created by Mohamed Hassan on 11/16/19.
//  Copyright © 2019 Mohamed Hassan. All rights reserved.
//

import UIKit
import Alamofire

enum EdamamRequestPath:RequestPathProtocol {
    case search
    
    var method: HTTPMethod {
        switch self {
        case .search:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .search:
            return "search"
        }
    }
    
    var mockName: String {
        switch self {
        case .search:
            return "EdamamResponse"
        }
    }
}

class EdamamRequest: BaseRequest {
    
    private static let APP_ID = "81684560"
    private static let APP_KEY = "e83fcffc992684f40663c1ffd2537ffe"
    private static let DEFAULT_PAGE_SIZE = 30
    
    required init(path:RequestPathProtocol,paramters:[String:Any]?) {
        super.init(path: path, paramters: paramters)
        
        let authParams:[String:Any] = ["app_id": EdamamRequest.APP_ID,
                                       "app_key": EdamamRequest.APP_KEY]
        let allParamters = authParams.merging(paramters ?? [:]) { (key, value) -> Any in
            return value
        }
        self.baseURL = "https://api.edamam.com"
        self.headers = ["Content-Type": "application/json"]
        self.paramters = allParamters
        self.path = path
    }

    class func searchRecipesRequest(query:String) -> EdamamRequest {
        return EdamamRequest(path: EdamamRequestPath.search, paramters: ["q": query, "to": DEFAULT_PAGE_SIZE])
    }
    
    //Edamam free APi doesn't allow more than 100 results per query
    class func searchRecipesRequest(query:String, page: Int, size: Int) -> EdamamRequest {
        let from = page * size
        let to = min((page + 1) * size, 100)
        return EdamamRequest(path: EdamamRequestPath.search, paramters: ["q": query, "from": from, "to": to])
    }
}
