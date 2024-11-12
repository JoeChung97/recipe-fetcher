//
//  HomeViewModel.swift
//  Recipe Fetcher
//
//  Created by Joey Chung on 11/12/24.
//

import Foundation

@MainActor
class HomeViewModel: ObservableObject {
    private let service: RecipeServiceProtocol
    
    @Published var isLoading = false
    @Published var recipes: [Recipe] = []
    @Published var error: Error?
    
    init(service: RecipeServiceProtocol) {
        self.service = service
    }
    
    func fetchRecipes() async {
        defer { isLoading = false }
        
        isLoading = true
        
        let result = await service.fetchRecipes()
        switch result {
        case .success(let recipes):
            self.recipes = recipes
        case .failure(let error):
            self.error = error
        }
    }
}
