//
//  EdamamResponseTest.swift
//  RecipeSearchTests
//
//  Created by Mohamed Hassan on 11/18/19.
//  Copyright © 2019 Mohamed Hassan. All rights reserved.
//

import XCTest

class EdamamResponseTest: XCTestCase {

    private var response: EdamamSearchResponse?
    
    override func setUp() {
        let networkMock = NetworkMockingManager(bundle: Bundle(for: type(of: self) as AnyClass))
        let request = EdamamRequest.searchRecipesRequest(query: "pasta")
        networkMock.performRequest(request: request, of: EdamamSearchResponse.self, completion: { (response) in
            self.response = response
        }) { (error) in
            
        }
    }

    func testNotNil() {
        XCTAssertNotNil(response)
    }
    
    func testResultsCount() {
        XCTAssertEqual(response?.count ?? 0, 41954)
    }
    
    func testFirstPageCount() {
        XCTAssertEqual(response?.data.count ?? 0, 10)
    }
}
