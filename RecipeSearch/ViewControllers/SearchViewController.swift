//
//  ViewController.swift
//  RecipeSearch
//
//  Created by Mohamed Hassan on 11/16/19.
//  Copyright © 2019 Mohamed Hassan. All rights reserved.
//

import UIKit

protocol RecipeDisplayProtocol: class {
    func showRecipes(_ recipes: [RecipeProtocol])
    func presentError(_ error:NetworkError)
}

class SearchViewController: UIViewController, RecipeDisplayProtocol {
    
    private let interactor = RecipesInteractor(dataProvider: NetworkManager.sharedInstance)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        interactor.searchRecipes(query: "pizza")
    }

    func setup() {
        navigationItem.titleView = UIImageView(image: UIImage(named: "logo"))
        let presenter = RecipesPresenter()
        presenter.viewController = self
        interactor.presenter = presenter
    }

    func showRecipes(_ recipes: [RecipeProtocol]) {
        
    }
}

