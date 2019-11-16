//
//  NetworkError.swift
//  RecipeSearch
//
//  Created by Mohamed Hassan on 11/16/19.
//  Copyright © 2019 Mohamed Hassan. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    
    case noInternetConnection
    case custom(String)
    case other
}

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .noInternetConnection:
            return NSLocalizedString("No Internet connection", comment: "")
        case .other:
            return NSLocalizedString("Something went wrong", comment: "")
        case .custom(let message):
            return message
        }
    }
}
