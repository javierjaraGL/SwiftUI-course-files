//
//  IconGrid.swift
//  LTORConverter
//
//  Created by Javier Jara Montoya on 28/7/25.
//

import SwiftUI

struct IconGrid: View {
    @Binding var selectedCurrency: Currency

    var body: some View {
        LazyVGrid(columns: [GridItem(),GridItem(),GridItem()]) {
            ForEach(Currency.allCases) { currency in
                if currency == self.selectedCurrency {
                    CurrencyIcon(currencyImage: currency.image, currencyName: currency.name)
                        .shadow(color: .black, radius: 10)
                        .overlay{
                            RoundedRectangle(cornerRadius: 25)
                                .stroke(lineWidth: 3)
                                .opacity(0.5)
                        }
                } else {
                    CurrencyIcon(currencyImage: currency.image, currencyName: currency.name)
                        .onTapGesture{
                            self.selectedCurrency = currency
                        }
                }
            }
        }
    }
}

#Preview {
    @Previewable @State var currency = Currency.silverPiece
    IconGrid(selectedCurrency: $currency)
}
