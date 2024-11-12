//
//  ContentView.swift
//  Recipe Fetcher
//
//  Created by Joey Chung on 11/12/24.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel(service: RecipeService())
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(viewModel.recipes, id: \.id) { recipe in
                    Text(recipe.name)
                }
            }
        }
        .overlay {
            if viewModel.isLoading {
                Text("Loading...")
            }
        }
        .task {
            await viewModel.fetchRecipes()
        }
    }
}

#Preview {
    HomeView()
}
