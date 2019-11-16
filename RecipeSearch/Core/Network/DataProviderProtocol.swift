//
//  DataProviderProtocol.swift
//  RecipeSearch
//
//  Created by Mohamed Hassan on 11/16/19.
//  Copyright © 2019 Mohamed Hassan. All rights reserved.
//

protocol DataProvider {
    func performRequest <T:Codable>(request:RequestProtocol, of type: T.Type, completion: @escaping (T?) -> Void,errorHandler: @escaping (NetworkError) -> Void)
}
