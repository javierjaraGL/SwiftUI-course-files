//
//  ContentView.swift
//  BBQuotes
//
//  Created by Javier Jara Montoya on 14/8/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            Tab(Show.breakingbad.rawValue, systemImage: "tortoise") {
                FetchView(show: .breakingbad)
                    .toolbarBackgroundVisibility(.visible, for: .tabBar)
            }
            
            Tab(Show.bettercallsaul.rawValue, systemImage: "briefcase") {
                FetchView(show: .bettercallsaul)
                    .toolbarBackgroundVisibility(.visible, for: .tabBar)
            }
            
            Tab(Show.elcamino.rawValue, systemImage: "car") {
                FetchView(show: .elcamino)
                    .toolbarBackgroundVisibility(.visible, for: .tabBar)
            }
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
}
