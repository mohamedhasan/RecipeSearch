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
    private var pageSize: Int?
    private var currentQuery:String?
    
    required init(dataProvider: DataProvider) {
        self.dataProvider = dataProvider
    }
    
    private func updateData(response: ResponseProtocol?) {
        self.hasMore = response?.hasMore ?? false
        self.pageSize = response?.pageSize
        self.page += 1
        guard let recipesList = response?.data else {
            return
        }
        self.recipes = recipesList
    }
    
    func searchRecipes(query: String) {
        currentQuery = query
        dataProvider.performRequest(request: EdamamRequest.searchRecipesRequest(query: query), of: EdamamSearchResponse.self, completion: { (response) in
            
            self.updateData(response: response)
            guard let recipesList = response?.data else {
                return
            }
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
            self.updateData(response: response)
            self.presenter?.loadMoreRecipes(recipesList)
        }) { (error) in
            self.presenter?.presentError(error)
        }
    }
}
