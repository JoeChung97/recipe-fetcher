//
//  LoadingView.swift
//  Recipe Fetcher
//
//  Created by Joey Chung on 11/13/24.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        VStack {
            ProgressView()
                .progressViewStyle(.circular)
                .tint(Color.backgroundSecondary)
        }
        .frame(width: 75, height: 75)
        .background(Color.darkGreen.opacity(0.9))
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

#Preview {
    LoadingView()
}
