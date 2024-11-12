//
//  RecipeServiceError.swift
//  Recipe Fetcher
//
//  Created by Joey Chung on 11/12/24.
//

import Foundation

public enum RecipeServiceError: Error {
    case invalidUrl(_ url: String? = nil)
}
