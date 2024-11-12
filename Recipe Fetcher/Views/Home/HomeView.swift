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
        .refreshable {
            Task {
                await viewModel.fetchRecipes()
            }
        }
        .overlay {
            if viewModel.isLoading {
                Text("Loading...")
            }else if viewModel.recipes.isEmpty {
                Text("It looks like there weren't any recipes to fetch")
            }
        }
        .alert(isPresented: $viewModel.shouldShowError) {
            Alert(title: Text("An Error Occurred"),
                  message: Text(viewModel.error?.localizedDescription ?? "We're sorry, it looks like something went wrong. Try loading the recipes again."))
        }
        .task {
            await viewModel.fetchRecipes()
        }
    }
}

#Preview {
    HomeView()
}
