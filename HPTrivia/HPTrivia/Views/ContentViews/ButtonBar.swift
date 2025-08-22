//
//  ButtonBar.swift
//  HPTrivia
//
//  Created by Javier Jara Montoya on 21/8/25.
//

import SwiftUI

struct ButtonBar: View {
    @Binding var animateViewsIn: Bool
    @Binding  var playGame: Bool

    let geo: GeometryProxy

    var body: some View {
        HStack {
            Spacer()
            InstructionsButton(animateViewsIn: $animateViewsIn, geo: geo)
            Spacer()
            // Play Button
            PlayButton(animateViewsIn: $animateViewsIn, geo: geo, playGame: $playGame)
            Spacer()
            // Settins Button
            SettingsButton(animateViewsIn: $animateViewsIn, geo: geo)
            Spacer()
        }
        .frame(width: geo.size.width)
    }
}

#Preview {
    GeometryReader { geo in
        ButtonBar(animateViewsIn: .constant(true), playGame: .constant(false), geo: geo)
            .frame(width: geo.size.width, height: geo.size.height)
    }
    .ignoresSafeArea()
}
