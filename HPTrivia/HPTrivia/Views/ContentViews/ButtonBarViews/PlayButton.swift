//
//  PlayButton.swift
//  HPTrivia
//
//  Created by Javier Jara Montoya on 21/8/25.
//

import SwiftUI

struct PlayButton: View {
    @Binding var animateViewsIn: Bool
    let geo: GeometryProxy

    // State Properties
    @Binding  var playGame: Bool 
    @State private var scalePlayButton = false
    var body: some View {
        VStack {
            if animateViewsIn {
                Button {
                    playGame.toggle()
                } label: {
                    Text("Play")
                        .font(.largeTitle)
                        .foregroundStyle(.white)
                        .padding(.vertical, 7)
                        .padding(.horizontal, 50)
                        .background(.brown)
                        .clipShape(.rect(cornerRadius: 7))
                        .shadow(radius: 5)
                        .scaleEffect(scalePlayButton ? 1.2 : 1)
                        .onAppear {
                            withAnimation(.easeInOut(duration: 1.3).repeatForever()) {
                                scalePlayButton.toggle()
                            }
                        }
                }
                .transition(.offset(y: geo.size.height/3))
            }
        }
        .animation(.easeOut(duration: 0.7).delay(2), value: animateViewsIn)
    }
}

#Preview {
    GeometryReader { geo in
        PlayButton(animateViewsIn: .constant(true), geo: geo, playGame: .constant(false))
            .frame(width: geo.size.width, height: geo.size.height)
    }
    .ignoresSafeArea()
}
