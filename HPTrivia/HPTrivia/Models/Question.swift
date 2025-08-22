//
//  Question.swift
//  HPTrivia
//
//  Created by Javier Jara Montoya on 21/8/25.
//

struct Question: Codable {
    let id: Int
    let question: String
    let answer: String
    let wrong: [String]
    let book: Int
    let hint: String
}
