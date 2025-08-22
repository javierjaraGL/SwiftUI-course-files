//
//  Currency.swift
//  LTORConverter
//
//  Created by Javier Jara Montoya on 29/7/25.
//
import SwiftUI

enum Currency: Double, CaseIterable, Identifiable {
    
    case copperPenny = 6400.0
    case silverPenny = 64.0
    case silverPiece = 16.0
    case goldPenny = 4.0
    case goldPiece = 1.0

    var id: Double {
        self.rawValue
    }

    var image: ImageResource {
        switch self {
        case .copperPenny:
            return .copperpenny
        case .silverPenny:
            return .silverpenny
        case .silverPiece:
            return .silverpiece
        case .goldPenny:
            return .goldpenny
        case .goldPiece:
            return .goldpiece
        }
    }
    
    var name: String {
        switch self {
        case .copperPenny:
                "Cooper Penny"
        case .silverPenny:
            "Silver Penny"
        case .silverPiece:
            "Silver Piece"
        case .goldPenny:
            "Gold Penny"
        case .goldPiece:
            "Gold Piece"
        }
    }
    
    func convert(_ amount: String, to currency: Currency) -> String {
        guard let amount = Double(amount) else {
            return ""
        }
        let convertedAmount = (amount / self.rawValue) * currency.rawValue
        return String(format: "%2.f", convertedAmount)
    }
}
