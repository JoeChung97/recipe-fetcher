//
//  RecipeServiceTests.swift
//  Recipe FetcherTests
//
//  Created by Joey Chung on 11/13/24.
//

import XCTest
@testable import Recipe_Fetcher

final class RecipeServiceTests: XCTestCase {
    private var service: RecipeService!
    private var session: URLSession!

    private let encoder = JSONEncoder()
    
    override func setUp() {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        session = URLSession(configuration: config)
        service = RecipeService(session: session)
    }

    override func tearDown() {
        service = nil
        session = nil
    }

    func testSuccessfulRequest() async throws {
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
        let recipeContainer = RecipeContainer(recipes: mockRecipes)
        let mockData = try encoder.encode(recipeContainer)
        
        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)
            return (response!, mockData)
        }
        
        let result = await service.fetchRecipes()
        
        switch result {
        case .success(let recipes):
            XCTAssertEqual(recipes.count, 3)
            XCTAssertEqual(recipes.last?.id, "3")
        case .failure:
            XCTFail("Expected success with 3 recipes, but received failure")
        }
    }
    
    func testSuccessfulRequestWithEmptyResponse() async throws {
        let recipeContainer = RecipeContainer(recipes: [])
        let mockData = try encoder.encode(recipeContainer)
        
        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)
            return (response!, mockData)
        }
        
        let result = await service.fetchRecipes()
        
        switch result {
        case .success(let recipes):
            XCTAssertEqual(recipes.isEmpty, true)
            XCTAssertEqual(recipes.last?.id, nil)
        case .failure:
            XCTFail("Expected success with 0 recipes, but received failure")
        }
    }
    
    /// Tests response with recipe that has a missing name
    func testMalformedResponse() async throws {
        let responseString = """
            {
                "recipes": [
                    {
                        "uuid": "123",
                        "cuisine": "American"
                    },
                    {
                        "uuid": "246",
                        "name": "French Onion Soup",
                        "cuisine": "French"
                    }
                ]
            }
        """
        let responseData = responseString.data(using: .utf8)
        
        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)
            return (response!, responseData!)
        }
        
        let result = await service.fetchRecipes()
        
        switch result {
        case .success:
            XCTFail("Expected failure but received success")
        case .failure(let error):
            guard let error = error as? RecipeServiceError else {
                XCTFail("Expected a RecipeServiceError")
                return
            }
            
            XCTAssertEqual(error, RecipeServiceError.malformedJson)
        }
    }
    
    func testNon200StatusCode() async throws {
        let recipeContainer = RecipeContainer(recipes: [])
        let mockData = try encoder.encode(recipeContainer)
        
        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(url: request.url!, statusCode: 500, httpVersion: nil, headerFields: nil)
            return (response!, mockData)
        }
        
        let result = await service.fetchRecipes()
        
        switch result {
        case .success:
            XCTFail("Expected failure but received success")
        case .failure(let error):
            guard let error = error as? RecipeServiceError else {
                XCTFail("Expected a RecipeServiceError")
                return
            }
            
            XCTAssertEqual(error, RecipeServiceError.unknownError)
        }
    }
}
