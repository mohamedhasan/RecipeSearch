//
//  EdamamSearchResponse.swift
//  RecipeSearch
//
//  Created by Mohamed Hassan on 11/16/19.
//  Copyright © 2019 Mohamed Hassan. All rights reserved.
//

import Foundation


struct EdamamSearchResponse: Codable {
    let from: Int!
    let to: Int!
    let more: Bool!
    let count: Int!
    let hits: [EdamamResult]!
}

extension EdamamSearchResponse: ResponseProtocol {
    var data: [RecipeProtocol] { get {return self.hits ?? [RecipeProtocol]()}}
    var error: String? {return nil}
    var isSuccess: Bool {return true}
    var hasMore: Bool {return more && (currentPage + 1) * pageSize <= 100}
    var pageSize: Int {return 20}
    //Edamam free account only allow 100 results so I will override here and use the beauty of Protocols
    var totalPages: Int {return 100 / pageSize}
//    var totalPages: Int {return self.hits.count / pageSize}
    var currentPage: Int {return (from / pageSize)}
}

