//
//  RecipesInteractor.swift
//  RecipeSearch
//
//  Created by Mohamed Hassan on 11/16/19.
//  Copyright © 2019 Mohamed Hassan. All rights reserved.
//

import UIKit

protocol RecipesInteractorProtocol
{
    func searchRecipes(query: String)
    init(dataProvider: DataProvider)
}

class RecipesInteractor: NSObject, RecipesInteractorProtocol {
    
    var presenter: RecipesPresentationProtocol?
    private var recipes = [RecipeProtocol]()
    var dataProvider: DataProvider
    
    required init(dataProvider: DataProvider) {
        self.dataProvider = dataProvider
    }
    
    func searchRecipes(query: String) {
        dataProvider.performRequest(request: EdamamRequest.searchRecipesRequest(query: query), of: EdamamSearchResponse.self, completion: { (response) in
            guard let recipesList = response?.data else {
                return
            }
            self.recipes = recipesList
            self.presenter?.presentRecipes(recipesList)
        }) { (error) in
            self.presenter?.presentError(error)
        }
    }
    
    
}
