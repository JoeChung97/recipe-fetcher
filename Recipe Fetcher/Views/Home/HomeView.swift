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
                    RecipeCellView(recipe: recipe)
                }
            }
            .padding()
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

struct RecipeCellView: View {
    let recipe: Recipe
    
    var body: some View {
        HStack {
            if let thumbnailUrl = recipe.smallPhotoUrl {
                AsyncImage(url: URL(string: thumbnailUrl),
                           content: { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 75, height: 75)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                },
                           placeholder: {
                    Text("Loading...")
                })
                
                VStack(alignment: .leading) {
                    Text(recipe.cuisine)
                        .font(.body)
                        .lineLimit(1)
                    
                    Text(recipe.name)
                        .font(.title3)
                        .bold()
                        .lineLimit(2)
                        .multilineTextAlignment(.leading)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .padding()
        .background(Color.backgroundSecondary)
        .clipShape(RoundedRectangle(cornerRadius: 15))
    }
}

#Preview {
    HomeView()
}
