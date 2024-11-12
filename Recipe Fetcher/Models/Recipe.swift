//
//  Recipe.swift
//  Recipe Fetcher
//
//  Created by Joey Chung on 11/12/24.
//

import Foundation

struct Recipe: Decodable {
    let id: String
    let name: String
    let cuisine: String
    let smallPhotoUrl: String?
    let largePhotoUrl: String?
    let sourceUrl: String?
    let youtubeUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "uuid"
        case name
        case cuisine
        case smallPhotoUrl = "photo_url_small"
        case largePhotoUrl = "photo_url_large"
        case sourceUrl = "source_url"
        case youtubeUrl = "youtube_url"
    }
}

// MARK: - RecipeContainer

struct RecipeContainer: Decodable {
    let recipes: [Recipe]
}
