//
//  RecipeSearchTests.swift
//  RecipeInteractorTests
//
//  Created by Mohamed Hassan on 11/16/19.
//  Copyright © 2019 Mohamed Hassan. All rights reserved.
//

import XCTest
@testable import RecipeSearch

class RecipeInteractorTests: XCTestCase, RecipesPresentationProtocol {
    
    private var interactor: RecipesInteractor?
    private var recipes: [RecipeProtocol]?
    private var moreRecipes: [RecipeProtocol]?
    private var error: Error?
    
    override func setUp() {
        interactor = RecipesInteractor(dataProvider:NetworkMockingManager(bundle: Bundle(for: type(of: self) as AnyClass)))
        interactor?.presenter = self
        interactor?.searchRecipes(query: "pasta")
        interactor?.loadNextPage()
    }

    func presentRecipes(_ recipes: [RecipeProtocol]) {
        self.recipes = recipes
    }
    
    func loadMoreRecipes(_ recipes: [RecipeProtocol]) {
        self.moreRecipes = recipes
    }
    
    func presentError(_ error: NetworkError) {
        self.error = error
    }
    
    func testRecipesNotEmpty() {
        XCTAssertNotNil(recipes)
        XCTAssertNotEqual(recipes?.count ?? 0, 0)
    }

    func testMoreRecipesNotEmpty() {
        XCTAssertNotNil(moreRecipes)
        XCTAssertNotEqual(moreRecipes?.count ?? 0, 0)
    }
}
