//
//  SelectCurrency 2.swift
//  LTORConverter
//
//  Created by Javier Jara Montoya on 30/7/25.
//


import SwiftUI

struct SelectCurrency: View {
    @Environment(\.dismiss) var dismissMe
    @Binding var topCurrency: Currency
    @Binding var bottomCurrency: Currency

    var body: some View {
       // Back Ground Image
        ZStack {
            // Parchmet Background image
            Image(.parchment)
                .resizable()
                .ignoresSafeArea()
                .background(.brown)
            VStack {
                // Text
                Text("Select the currenty you are starting with:")
                    .fontWeight(.bold)
                // Currency Icons
                #warning("review lazyVGrid")
                IconGrid(selectedCurrency: $topCurrency)
                // Text
                Text("Select the currenty you would like to convert to:")
                    .fontWeight(.bold)
                    .padding(.top)
                // Currency Icons
                IconGrid(selectedCurrency: $bottomCurrency)
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
            .padding()
            .multilineTextAlignment(.center)
            .foregroundStyle(.black)
        }
        
    }
}

#Preview {
    @Previewable @State var topCurrency = Currency.silverPenny
    @Previewable @State var bottomCurrency = Currency.goldPenny

    SelectCurrency(topCurrency: $topCurrency, bottomCurrency: $bottomCurrency)
}

