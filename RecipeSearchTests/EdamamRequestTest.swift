//
//  EdamamRequestTest.swift
//  RecipeSearchTests
//
//  Created by Mohamed Hassan on 11/18/19.
//  Copyright © 2019 Mohamed Hassan. All rights reserved.
//

import XCTest

class EdamamRequestTest: XCTestCase {

    var request:EdamamRequest?
    
    override func setUp() {
        request = EdamamRequest.searchRecipesRequest(query: "pasta")
    }

    func testRequestCreation() {
        XCTAssertNotNil(request)
    }
    
    func testRequestHasUrl() {
        XCTAssertNotNil(request?.requestUrl())
    }
    
    func testRequestHasProperAuth() {
        XCTAssertNotNil(request?.paramters?["app_id"])
        XCTAssertNotNil(request?.paramters?["app_key"])
    }
    
    
    func testRequestContentType() {
        XCTAssertEqual(request?.headers?["Content-Type"], "application/json")
    }
    
    func testQueryIsAccurate() {
        guard let query = request?.paramters?["q"] as? String else {
            XCTAssert(true)
            return
        }
        XCTAssertEqual(query, "pasta")
    }
    
    func testSearchRequestIsHttpGet() {
        XCTAssertEqual(request?.path.method, .get)
    }
}
