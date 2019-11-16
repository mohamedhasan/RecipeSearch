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
    var error: String? {get {return nil}}
    var isSuccess: Bool {get {return true}}
    var currentPage: Int {get {return (to - from)}}
}

