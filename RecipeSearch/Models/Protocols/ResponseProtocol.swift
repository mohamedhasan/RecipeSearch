//
//  RecipeObject.swift
//  RecipeSearch
//
//  Created by Mohamed Hassan on 11/16/19.
//  Copyright © 2019 Mohamed Hassan. All rights reserved.
//

import Foundation

protocol ResponseProtocol {
    var data: [RecipeProtocol] { get }
    var error: String? { get }
    var isSuccess: Bool { get }
    var hasMore: Bool { get }
    var currentPage: Int { get }
    var pageSize: Int { get }
    var totalPages: Int { get }
}
