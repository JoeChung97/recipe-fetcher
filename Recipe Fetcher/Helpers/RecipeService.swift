//
//  RecipeService.swift
//  Recipe Fetcher
//
//  Created by Joey Chung on 11/12/24.
//

import Foundation

protocol RecipeServiceProtocol {
    func fetchRecipes() async -> Result<[Recipe], Error>
}

public class RecipeService: RecipeServiceProtocol {
    private let decoder = JSONDecoder()
    private let session: URLSession
    private let recipesEndpoint = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json"
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func fetchRecipes() async -> Result<[Recipe], Error> {
        guard let recipesUrl = URL(string: recipesEndpoint) else {
            return .failure(RecipeServiceError.invalidUrl(recipesEndpoint))
        }
        
        let request = URLRequest(url: recipesUrl)
        do {
            let (data, _) = try await session.data(for: request)
            let recipeContainer = try decoder.decode(RecipeContainer.self, from: data)
            return .success(recipeContainer.recipes)
        } catch {
            return .failure(error)
        }
    }
}
