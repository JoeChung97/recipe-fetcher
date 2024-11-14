//
//  CuisineFilterView.swift
//  Recipe Fetcher
//
//  Created by Joey Chung on 11/12/24.
//

import SwiftUI

struct CuisineFilterView: View {
    @Binding var selectedCuisine: Cuisine
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(Cuisine.allCases, id: \.self) { cuisine in
                    cuisinePillView(cuisine)
                }
            }
            .padding(.horizontal)
        }
    }
    
    private func cuisinePillView(_ cuisine: Cuisine) -> some View {
        Text("\(cuisine.icon) \(cuisine.rawValue)")
            .font(.body)
            .padding()
            .foregroundStyle(selectedCuisine == cuisine ? Color.white : Color.darkGreen)
            .background(selectedCuisine == cuisine ? Color.darkGreen : Color.backgroundSecondary)
            .clipShape(Capsule())
            .onTapGesture {
                selectedCuisine = cuisine
            }
    }
}

#Preview {
    CuisineFilterView(selectedCuisine: .constant(.all))
}
