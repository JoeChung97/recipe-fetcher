//
//  BadgeView.swift
//  Recipe Fetcher
//
//  Created by Joey Chung on 11/13/24.
//

import SwiftUI

struct BadgeView: View {
    let systemImageName: String
    let text: String
    
    var body: some View {
        HStack {
            Image(systemName: systemImageName)
                .font(.body)
                .foregroundStyle(Color.darkGreen)
                .bold()
            
            Text(text)
                .font(.body)
                .foregroundStyle(Color.black)
        }
    }
}

#Preview {
    BadgeView(systemImageName: "video", text: "Video")
}
