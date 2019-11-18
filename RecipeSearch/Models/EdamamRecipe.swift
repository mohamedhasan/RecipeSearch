//
//  EdamamRecipe.swift
//  RecipeSearch
//
//  Created by Mohamed Hassan on 11/16/19.
//  Copyright © 2019 Mohamed Hassan. All rights reserved.
//

import Foundation

struct EdamamRecipe: Codable {
    let uri: String!
    let label: String!
    let image: String!
    let source: String!
    let url: String!
    let shareAs: String!
    let ingredientLines:[String]!
    let yield:Int!
}

struct EdamamResult: Codable {
    let recipe: EdamamRecipe!
}

extension EdamamResult: RecipeProtocol {
    
    var title: String {
        return recipe.label
    }
    
    var imageUrl: String {
        return recipe.image
    }
    
    var ingredients: [String]? {
        return recipe.ingredientLines
    }
    
    var sourceUrl: String {
        return recipe.url
    }
    
    var instructionsUrl: String {
        return recipe.shareAs
    }
    
    var publisherName: String {
        return recipe.source
    }
    
//    EdamamRecipe doesn't support social Counts for now will return (Zero)
    var socialRank: Int {
        return 0
    }
}
