//
//  Recipe.swift
//  Recipe Fetcher
//
//  Created by Joey Chung on 11/12/24.
//

import Foundation

struct Recipe: Codable {
    let id: String
    let name: String
    let cuisine: Cuisine
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

// MARK: - Cuisine

/// Having an Enum for cuisines makes filtering less
/// error prone and allows a flag emoji to be associated
/// with each cuisine. It would probably be better to be able
/// to fetch a list of cuisines from the API, but since that's not
/// possible for this exercise, this works as well.
enum Cuisine: String, Codable, CaseIterable {
    case all = "All"
    case malaysian = "Malaysian"
    case british = "British"
    case american = "American"
    case canadian = "Canadian"
    case italian = "Italian"
    case tunisian = "Tunisian"
    case french = "French"
    case greek = "Greek"
    case polish = "Polish"
    case portuguese = "Portuguese"
    case russian = "Russian"
    case croatian = "Croatian"
    
    var icon: String {
        switch self {
        case .malaysian:
            "🇲🇾"
        case .british:
            "🇬🇧"
        case .american:
            "🇺🇸"
        case .canadian:
            "🇨🇦"
        case .italian:
            "🇮🇹"
        case .tunisian:
            "🇹🇳"
        case .french:
            "🇫🇷"
        case .greek:
            "🇬🇷"
        case .polish:
            "🇵🇱"
        case .portuguese:
            "🇵🇹"
        case .russian:
            "🇷🇺"
        case .croatian:
            "🇭🇷"
        case .all:
            "🌎"
        }
    }
}

// MARK: - RecipeContainer

struct RecipeContainer: Codable {
    let recipes: [Recipe]
}
