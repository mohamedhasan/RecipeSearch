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
    
    static let defaultPageSize: Int = 20
    var presenter: RecipesPresentationProtocol?
    private var recipes = [RecipeProtocol]()
    private var dataProvider: DataProvider
    public var hasMore: Bool = false
    private var page: Int = 0
    private var totalPages: Int?
    private var pageSize: Int?
    private var currentQuery:String?
    
    required init(dataProvider: DataProvider) {
        self.dataProvider = dataProvider
    }
    
    func searchRecipes(query: String) {
        currentQuery = query
        dataProvider.performRequest(request: EdamamRequest.searchRecipesRequest(query: query), of: EdamamSearchResponse.self, completion: { (response) in
            
            self.hasMore = response?.hasMore ?? false
            self.totalPages = response?.totalPages
            self.pageSize = response?.pageSize
            guard let recipesList = response?.data else {
                return
            }
            self.recipes = recipesList
            self.presenter?.presentRecipes(recipesList)
        }) { (error) in
            self.presenter?.presentError(error)
        }
    }
    
    func loadNextPage() {
        let request =  EdamamRequest.searchRecipesRequest(query: currentQuery ?? "", page: page, size: pageSize ?? RecipesInteractor.defaultPageSize)
        dataProvider.performRequest(request: request, of: EdamamSearchResponse.self, completion: { (response) in
            guard let recipesList = response?.data else {
                return
            }
            self.page += 1
            self.recipes = recipesList
            self.presenter?.loadMoreRecipes(recipesList)
        }) { (error) in
            self.presenter?.presentError(error)
        }
    }
    
    
}
