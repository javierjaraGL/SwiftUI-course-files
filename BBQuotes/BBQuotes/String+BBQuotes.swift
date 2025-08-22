//
//  String+BBQuotes.swift
//  BBQuotes
//
//  Created by Javier Jara Montoya on 14/8/25.
//

import Foundation

extension String {
    func removeSpaces() -> String {
        self.replacingOccurrences(of: " ", with: "")
    }
    
    func removeCaseAndSpace() -> String {
        self.removeSpaces().lowercased()
    }
}
