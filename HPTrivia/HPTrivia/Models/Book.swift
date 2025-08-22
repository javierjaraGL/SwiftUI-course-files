//
//  Book.swift
//  HPTrivia
//
//  Created by Javier Jara Montoya on 21/8/25.
//

struct Book: Identifiable, Codable {
    let id: Int
    let image: String
    let questions: [Question]
    var status: BookStatus
}


enum BookStatus: Codable {
    case active
    case inactive
    case locked
}

