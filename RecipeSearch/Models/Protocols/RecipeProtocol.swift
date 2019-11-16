//
//  RecipeObject.swift
//  RecipeSearch
//
//  Created by Mohamed Hassan on 11/16/19.
//  Copyright © 2019 Mohamed Hassan. All rights reserved.
//

import Foundation

protocol RecipeProtocol {
    var title: String { get }
    var imageUrl: String { get }
    var ingredients: [String]? { get }
    var sourceUrl: String { get }
    var instructionsUrl: String { get }
    var publisherName: String { get }
    var socialRank: Int { get }
}
