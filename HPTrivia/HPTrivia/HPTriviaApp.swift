//
//  HPTriviaApp.swift
//  HPTrivia
//
//  Created by Javier Jara Montoya on 21/8/25.
//

import SwiftUI
import SwiftData

@main
struct HPTriviaApp: App {
    private var game = Game()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(game)
        }
    }
}
