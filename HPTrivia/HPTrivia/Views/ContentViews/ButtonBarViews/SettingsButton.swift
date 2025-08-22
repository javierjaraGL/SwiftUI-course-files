//
//  SettingsButton.swift
//  HPTrivia
//
//  Created by Javier Jara Montoya on 21/8/25.
//

import SwiftUI

struct SettingsButton: View {
    @Binding var animateViewsIn: Bool
    let geo: GeometryProxy

    // State
    @State private var showSettings = false

    var body: some View {
        VStack {
            if animateViewsIn {
                Button {
                    showSettings.toggle()
                } label: {
                    Image(systemName: "gearshape.fill")
                        .font(.largeTitle)
                        .foregroundStyle(.white)
                        .shadow(radius: 5)
                }
                .transition(.offset(x: geo.size.width/4))
            }
        }
        .animation(.easeOut(duration: 0.7).delay(2.7), value: animateViewsIn)
        .sheet(isPresented: $showSettings) {
            SelectBooks()
        }
    }
}

#Preview {
    GeometryReader { geo in
        SettingsButton(animateViewsIn: .constant(true), geo: geo)
            .frame(width: geo.size.width, height: geo.size.height)
            .environment(Game())
    }
    .ignoresSafeArea()
}
