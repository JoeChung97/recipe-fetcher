//
//  MockRecipeService.swift
//  Recipe Fetcher
//
//  Created by Joey Chung on 11/12/24.
//

import Foundation

class MockRecipeService: RecipeServiceProtocol {
    var recipes: [Recipe]?
    var error: Error?
    
    func fetchRecipes() async -> Result<[Recipe], Error> {
        if let error {
            return .failure(error)
        }else if let recipes {
            return .success(recipes)
        }else{
            return .success([])
        }
    }
}
