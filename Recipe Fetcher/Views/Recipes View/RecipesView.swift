//
//  ContentView.swift
//  Recipe Fetcher
//
//  Created by Joey Chung on 11/12/24.
//

import SDWebImageSwiftUI
import SwiftUI

struct RecipesView: View {
    @StateObject private var viewModel = RecipesViewModel(service: RecipeService())
    
    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading) {
                Text("Recipe Fetcher")
                    .font(.title)
                    .bold()
                    .foregroundStyle(Color.darkGreen)
                    .padding(.horizontal)
                
                SearchView(text: $viewModel.searchText)
                    .padding(.horizontal)
                
                CuisineFilterView(selectedCuisine: $viewModel.selectedCuisine)
                    .padding(.bottom, 15)
                
                ForEach(viewModel.filteredRecipes, id: \.id) { recipe in
                    RecipeCellView(recipe: recipe)
                        .padding(.horizontal)
                }
            }
        }
        .background(Color.backgroundPrimary)
        .refreshable {
            Task {
                await viewModel.fetchRecipes()
            }
        }
        .overlay {
            if viewModel.isLoading {
                LoadingView()
            }else if viewModel.filteredRecipes.isEmpty {
                NoRecipesView()
            }
        }
        .alert(isPresented: $viewModel.shouldShowError) {
            Alert(title: Text("An Error Occurred"),
                  message: Text("We're sorry, it looks like something went wrong. Try swiping down to load the recipes again."))
        }
        .task {
            await viewModel.fetchRecipes()
        }
    }
}

// MARK: - RecipeCellView

struct RecipeCellView: View {
    let recipe: Recipe
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 15) {
                Text("\(recipe.cuisine.icon) \(recipe.cuisine.rawValue)")
                    .font(.caption)
                    .foregroundStyle(Color.white)
                    .lineLimit(1)
                    .padding(.vertical, 5)
                    .padding(.horizontal, 8)
                    .background(Color.darkGreen)
                    .clipShape(Capsule())
                
                Text(recipe.name)
                    .font(.title2)
                    .bold()
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
                
                HStack(spacing: 15) {
                    if recipe.youtubeUrl != nil {
                        BadgeView(systemImageName: "video", text: "Video")
                    }
                    
                    if recipe.sourceUrl != nil {
                        BadgeView(systemImageName: "doc.text", text: "Text")
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            if let thumbnailUrl = recipe.smallPhotoUrl {
                WebImage(url: URL(string: thumbnailUrl))
                    .resizable()
                    .indicator(.activity)
                    .transition(.fade(duration: 0.5))
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 115, height: 115)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
            }
        }
        .padding()
        .background(Color.backgroundSecondary)
        .clipShape(RoundedRectangle(cornerRadius: 32))
    }
}

// MARK: - NoRecipesView

struct NoRecipesView: View {
    var body: some View {
        VStack {
            Text("😭")
                .font(.body)
            
            Text("It looks like there weren't any recipes to fetch")
                .font(.body)
                .foregroundStyle(Color.darkGreen)
                .bold()
                .multilineTextAlignment(.center)
        }
        .padding()
    }
}

#Preview {
    RecipesView()
}
