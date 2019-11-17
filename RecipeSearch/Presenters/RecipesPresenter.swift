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
        if recipes.count > 0 {
            viewController?.showRecipes(recipes)
        } else {
            viewController?.showError(.custom(NSLocalizedString("No Recipes Found", comment: "")))
        }
    }

    func loadMoreRecipes(_ recipes: [RecipeProtocol]) {
        if recipes.count > 0 {
            viewController?.showRecipes(recipes)
        } else {
            viewController?.showError(.custom(NSLocalizedString("No More Recipes to Show", comment: "")))
        }
    }
    
    func presentError(_ error: NetworkError) {
        self.viewController?.showError(error)
    }
}
