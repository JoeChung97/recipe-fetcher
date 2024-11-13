//
//  Recipe_FetcherTests.swift
//  Recipe FetcherTests
//
//  Created by Joey Chung on 11/12/24.
//

import XCTest
@testable import Recipe_Fetcher

final class HomeViewModelTests: XCTestCase {
    var viewModel: RecipesViewModel!
    var mockService: MockRecipeService!
    
    @MainActor
    override func setUp() async throws {
        mockService = MockRecipeService()
        viewModel = RecipesViewModel(service: mockService)
    }

    override func tearDown() {
        viewModel = nil
        mockService = nil
    }

    @MainActor
    func testSuccessfulLoad() async throws {
        let mockRecipes: [Recipe] = [
            Recipe(id: "1",
                   name: "Burger",
                   cuisine: .american,
                   smallPhotoUrl: nil,
                   largePhotoUrl: nil,
                   sourceUrl: nil,
                   youtubeUrl: nil),
            Recipe(id: "2",
                   name: "Pasta",
                   cuisine: .italian,
                   smallPhotoUrl: nil,
                   largePhotoUrl: nil,
                   sourceUrl: nil,
                   youtubeUrl: nil),
            Recipe(id: "3",
                   name: "Croissant",
                   cuisine: .french,
                   smallPhotoUrl: nil,
                   largePhotoUrl: nil,
                   sourceUrl: nil,
                   youtubeUrl: nil)
        ]
        mockService.recipes = mockRecipes
        
        await viewModel.fetchRecipes()
        
        XCTAssertEqual(viewModel.recipes.count, 3)
        XCTAssertEqual(viewModel.recipes.last?.cuisine, .french)
        XCTAssertEqual(viewModel.shouldShowError, false)
        XCTAssertEqual(viewModel.isLoading, false)
    }
    
    @MainActor
    func testEmptyLoad() async throws {
        let mockRecipes: [Recipe] = []
        mockService.recipes = mockRecipes
        
        await viewModel.fetchRecipes()
        
        XCTAssertEqual(viewModel.recipes.isEmpty, true)
        XCTAssertEqual(viewModel.shouldShowError, false)
        XCTAssertEqual(viewModel.isLoading, false)
    }
    
    @MainActor
    func testNilLoad() async throws {
        mockService.recipes = nil
        
        await viewModel.fetchRecipes()
        
        XCTAssertEqual(viewModel.recipes.isEmpty, true)
        XCTAssertEqual(viewModel.shouldShowError, false)
        XCTAssertEqual(viewModel.isLoading, false)
    }
    
    @MainActor
    func testLoadWithError() async throws {
        mockService.recipes = nil
        mockService.error = RecipeServiceError.invalidUrl()
        
        await viewModel.fetchRecipes()
        
        XCTAssertEqual(viewModel.recipes.isEmpty, true)
        XCTAssertEqual(viewModel.shouldShowError, true)
        XCTAssertEqual(viewModel.isLoading, false)
    }
    
    @MainActor
    func testRecipesWithFilter() async throws {
        viewModel.recipes = [
            Recipe(id: "1",
                   name: "Burger",
                   cuisine: .american,
                   smallPhotoUrl: nil,
                   largePhotoUrl: nil,
                   sourceUrl: nil,
                   youtubeUrl: nil),
            Recipe(id: "2",
                   name: "Pasta",
                   cuisine: .italian,
                   smallPhotoUrl: nil,
                   largePhotoUrl: nil,
                   sourceUrl: nil,
                   youtubeUrl: nil),
            Recipe(id: "3",
                   name: "Croissant",
                   cuisine: .french,
                   smallPhotoUrl: nil,
                   largePhotoUrl: nil,
                   sourceUrl: nil,
                   youtubeUrl: nil)
        ]
        viewModel.selectedCuisine = .french
        
        XCTAssertEqual(viewModel.filteredRecipes.count, 1)
        XCTAssertEqual(viewModel.filteredRecipes.first?.id, "3")
    }
    
    @MainActor
    func testRecipesWithAllFilter() async throws {
        viewModel.recipes = [
            Recipe(id: "1",
                   name: "Burger",
                   cuisine: .american,
                   smallPhotoUrl: nil,
                   largePhotoUrl: nil,
                   sourceUrl: nil,
                   youtubeUrl: nil),
            Recipe(id: "2",
                   name: "Pasta",
                   cuisine: .italian,
                   smallPhotoUrl: nil,
                   largePhotoUrl: nil,
                   sourceUrl: nil,
                   youtubeUrl: nil),
            Recipe(id: "3",
                   name: "Croissant",
                   cuisine: .french,
                   smallPhotoUrl: nil,
                   largePhotoUrl: nil,
                   sourceUrl: nil,
                   youtubeUrl: nil)
        ]
        viewModel.selectedCuisine = .all
        
        XCTAssertEqual(viewModel.filteredRecipes.count, 3)
        XCTAssertEqual(viewModel.filteredRecipes.first?.id, "1")
    }
    
    @MainActor
    func testRecipesWithInvalidFilter() async throws {
        viewModel.recipes = [
            Recipe(id: "1",
                   name: "Burger",
                   cuisine: .american,
                   smallPhotoUrl: nil,
                   largePhotoUrl: nil,
                   sourceUrl: nil,
                   youtubeUrl: nil),
            Recipe(id: "2",
                   name: "Pasta",
                   cuisine: .italian,
                   smallPhotoUrl: nil,
                   largePhotoUrl: nil,
                   sourceUrl: nil,
                   youtubeUrl: nil),
            Recipe(id: "3",
                   name: "Croissant",
                   cuisine: .french,
                   smallPhotoUrl: nil,
                   largePhotoUrl: nil,
                   sourceUrl: nil,
                   youtubeUrl: nil)
        ]
        viewModel.selectedCuisine = .malaysian
        
        XCTAssertEqual(viewModel.filteredRecipes.isEmpty, true)
        XCTAssertEqual(viewModel.filteredRecipes.first?.id, nil)
    }
}
