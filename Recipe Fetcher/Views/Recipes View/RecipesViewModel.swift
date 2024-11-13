//
//  HomeViewModel.swift
//  Recipe Fetcher
//
//  Created by Joey Chung on 11/12/24.
//

import Foundation

@MainActor
class RecipesViewModel: ObservableObject {
    private let service: RecipeServiceProtocol
    
    @Published var isLoading = false
    @Published var recipes: [Recipe] = []
    @Published var shouldShowError = false
    @Published var selectedCuisine: Cuisine = .all
    @Published var searchText: String = ""
    
    /// Filters available recipes based off of the
    /// selected cuisine & case-insensitive searchText
    var filteredRecipes: [Recipe] {
        var filteredRecipes = recipes
        if searchText.isEmpty == false {
            filteredRecipes = recipes.filter {
                $0.name.lowercased().contains(searchText.lowercased()) || $0.cuisine.rawValue.lowercased().contains(searchText.lowercased())
            }
        }
        
        if selectedCuisine == .all {
            return filteredRecipes
        }else{
            return filteredRecipes.filter { $0.cuisine == selectedCuisine }
        }
    }
    
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
        case .failure(_):
            self.shouldShowError = true
        }
    }
}
