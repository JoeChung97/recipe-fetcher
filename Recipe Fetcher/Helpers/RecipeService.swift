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
    private let endpoint: Endpoint
    
    enum Endpoint {
        case allRecipes
        case malformed
        case empty
        
        var urlString: String {
            switch self {
            case .allRecipes:
                "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json"
            case .malformed:
                "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-malformed.json"
            case .empty:
                "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-empty.json"
            }
        }
    }
    
    init(session: URLSession = .shared, endpoint: Endpoint = .allRecipes) {
        self.session = session
        self.endpoint = endpoint
    }
    
    func fetchRecipes() async -> Result<[Recipe], Error> {
        guard let recipesUrl = URL(string: endpoint.urlString) else {
            return .failure(RecipeServiceError.invalidUrl(endpoint.urlString))
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
