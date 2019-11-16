//
//  RecipesPresenter.swift
//  RecipeSearch
//
//  Created by Mohamed Hassan on 11/16/19.
//  Copyright © 2019 Mohamed Hassan. All rights reserved.
//

import UIKit

protocol RecipesPresentationProtocol
{
    func presentRecipes(_ recipes: [RecipeProtocol])
    func loadMoreRecipes(_ recipes: [RecipeProtocol])
    func presentError(_ error: NetworkError)
}

class RecipesPresenter: NSObject, RecipesPresentationProtocol {

    weak var viewController: RecipeDisplayProtocol?
    
    func presentRecipes(_ recipes: [RecipeProtocol]) {
        viewController?.showRecipes(recipes)
    }
    
    func loadMoreRecipes(_ recipes: [RecipeProtocol]) {
        
    }
    
    func presentError(_ error: NetworkError) {
        self.viewController?.presentError(error)
    }
}
