//
//  ExchangeInfo.swift
//  LTORConverter
//
//  Created by Javier Jara Montoya on 24/7/25.
//

import SwiftUI

struct ExchangeInfo: View {
    @Environment(\.dismiss) var dismissMe
    var body: some View {
        ZStack {
            // Background parchment image
            Image(.parchment)
                .resizable()
                .ignoresSafeArea()
                .background(.brown)
            VStack {
                // Title Text
                Text("Exchange Rates")
                    .font(.largeTitle)
                    .tracking(3)
                // Description Text
                Text("Here at the Prancing Pony, we are happy to offer you a place where you can exchange all the known currencies in the entire world except one. We used to take Brandy Bucks, but after finding out that it was a person instead of a piece of paper, we realized it had no value to us. Below is a simple guide to our currency exchange rates:")
                    .font(.title3)
                    .padding()
                // Exchange rates
                ExchangeRate(leftImage: .goldpiece, rigthImage: .goldpenny, text: "1 Gold Piece = 4 Gold Pennis")
                
                ExchangeRate(leftImage: .goldpenny, rigthImage: .silverpiece, text: "1 Gold Penni = 4 Silver Pieces")
                
                ExchangeRate(leftImage: .silverpiece, rigthImage: .silverpenny, text: "1 Silver Piece = 4 Silver Pennis")
                
                ExchangeRate(leftImage: .silverpenny, rigthImage: .copperpenny, text: "1 Silver Penni = 100 Cooper Pennis")
                // Done Button

                Button("Done") {
                    dismissMe()
                }
                .buttonStyle(.borderedProminent)
                .tint(.brown.mix(with: .black, by: 0.2))
                .font(.largeTitle)
                .padding()
                .foregroundStyle(.white)
            }
            .foregroundStyle(.black)
        }
    }
}

#Preview {
    ExchangeInfo()
}
