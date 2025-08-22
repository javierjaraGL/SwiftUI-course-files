//
//  ExchangeRateView.swift
//  LTORConverter
//
//  Created by Javier Jara Montoya on 28/7/25.
//

import SwiftUI

struct ExchangeRate: View {
    let leftImage: ImageResource
    let rigthImage: ImageResource
    let text: String

    var body: some View {
        HStack {
            // Left Currency Image
            Image(leftImage)
                .resizable()
                .scaledToFit()
                .frame(height: 33)
            // Exchange rate text
            Text(text)
            // Right Currency Image
            Image(rigthImage)
                .resizable()
                .scaledToFit()
                .frame(height: 33)
        }
    }
}

#Preview {
    ExchangeRate(leftImage: .goldpiece, rigthImage: .goldpenny, text: "1 Gold Piece = 4 Gold Pennis")
}
