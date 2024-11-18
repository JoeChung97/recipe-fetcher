//
//  SearchView.swift
//  Recipe Fetcher
//
//  Created by Joey Chung on 11/13/24.
//

import SwiftUI

struct SearchView: View {
    @Binding var text: String
    @FocusState private var isFocused: Bool
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .resizable()
                .frame(width: 14, height: 14)
                .foregroundStyle(isFocused ? Color.black : Color.backgroundSecondary)
            
            TextField("Search our recipe database...", text: $text)
                .tint(Color.darkGreen)
                .submitLabel(.search)
                .focused($isFocused)
                .textFieldStyle(.plain)
                .onSubmit {
                    isFocused = false
                }
        }
        .frame(height: 50)
        .padding(.horizontal, 16)
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .overlay {
            RoundedRectangle(cornerRadius: 15)
                .stroke(isFocused ? Color.darkGreen : Color.black.opacity(0.5), lineWidth: 2)
        }
        .onDisappear {
            isFocused = false
        }
    }
}

#Preview {
    SearchView(text: .constant("Test"))
}
