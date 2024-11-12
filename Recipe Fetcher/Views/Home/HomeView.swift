//
//  ContentView.swift
//  Recipe Fetcher
//
//  Created by Joey Chung on 11/12/24.
//

import SDWebImageSwiftUI
import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel(service: RecipeService())
    
    var body: some View {
        ScrollView {
            LazyVStack {
                CuisineFilterView(selectedCuisine: $viewModel.selectedCuisine)
                
                ForEach(viewModel.filteredRecipes, id: \.id) { recipe in
                    RecipeCellView(recipe: recipe)
                        .padding(.horizontal)
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

struct RecipeCellView: View {
    let recipe: Recipe
    
    var body: some View {
        HStack {
            if let thumbnailUrl = recipe.smallPhotoUrl {
                WebImage(url: URL(string: thumbnailUrl))
                    .resizable()
                    .indicator(.activity)
                    .transition(.fade(duration: 0.5))
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 75, height: 75)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                
                VStack(alignment: .leading) {
                    Text("\(recipe.cuisine.flag) \(recipe.cuisine.rawValue)")
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
