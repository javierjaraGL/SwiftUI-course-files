//
//  Show.swift
//  BBQuotes
//
//  Created by Javier Jara Montoya on 14/8/25.
//

import Foundation

enum Show: String {
    case breakingbad = "Breaking Bad"
    case bettercallsaul = "Better Call Saul"
    case elcamino = "El Camino"
    
    var backgroundImage: String {
        return self.rawValue.removeCaseAndSpace()
//        switch self {
//        case .breakingbad:
//            "breakingbad"
//        case .bettercallsaul:
//            "bettercallsaul"
//        case .elcamino:
//            "elcamino"
//        }
    }
}
