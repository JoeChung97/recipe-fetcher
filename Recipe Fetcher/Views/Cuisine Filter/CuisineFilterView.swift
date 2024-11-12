//
//  CuisineFilterView.swift
//  Recipe Fetcher
//
//  Created by Joey Chung on 11/12/24.
//

import SwiftUI

struct CuisineFilterView: View {
    @Binding var selectedCuisine: Cuisine?
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                // Clear button appears when a filter
                // is selected
                if selectedCuisine != nil {
                    Circle()
                        .fill(Color.backgroundSecondary)
                        .frame(width: 50, height: 50)
                        .overlay {
                            Image(systemName: "xmark")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 20, height: 20)
                                .bold()
                                .foregroundStyle(Color.white)
                        }
                        .onTapGesture {
                            withAnimation {
                                selectedCuisine = nil
                            }
                        }
                        .transition(.flipFromLeft)
                }
                
                ForEach(Cuisine.allCases, id: \.self) { cuisine in
                    cuisinePillView(cuisine)
                }
            }
            .padding(.horizontal)
        }
    }
    
    private func cuisinePillView(_ cuisine: Cuisine) -> some View {
        Text("\(cuisine.flag) \(cuisine.rawValue)")
            .font(.body)
            .padding()
            .background(Color.backgroundSecondary)
            .clipShape(Capsule())
            .overlay {
                if cuisine == selectedCuisine {
                    Capsule()
                        .strokeBorder(Color.white, lineWidth: 2)
                        .transition(.opacity)
                }
            }
            .onTapGesture {
                withAnimation {
                    selectedCuisine = cuisine
                }
            }
    }
}

#Preview {
    CuisineFilterView(selectedCuisine: .constant(nil))
}
