//
//  HintsView.swift
//  HPTrivia
//
//  Created by Javier Jara Montoya on 27/8/25.
//

import SwiftUI

struct HintsView: View {
    @Binding var animateViewsIn: Bool
    @Binding var revealHint: Bool
    @Binding var revealBook: Bool
    let geo: GeometryProxy
    var playFlipSound: () -> Void
    @Environment(Game.self) private var game

    var body: some View {
        HStack {
            VStack {
                if animateViewsIn {
                    Image(systemName: "questionmark.app.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100)
                        .foregroundStyle(.cyan)
                        .padding()
                        .transition(.offset(x: -geo.size.width/2))
                        .phaseAnimator([false, true]) { content, phase in
                            content
                                .rotationEffect(Angle(degrees: phase ? -13 : -17))
                        } animation: { _ in
                                .easeIn(duration: 0.7)
                        }
                        .onTapGesture {
                            withAnimation(.easeOut(duration: 1)) {
                                revealHint = true
                            }
                            playFlipSound()
                            game.questionScore -= 1
                        }
                        .rotation3DEffect(.degrees(revealHint ? 1440: 0), axis: (x: 0 , y: 1, z: 0))
                        .scaleEffect(revealHint ? 5 : 1)
                        .offset(x: revealHint ? geo.size.width/2 : 0)
                        .opacity(revealHint ? 0 : 1)
                        .overlay {
                            Text(game.currentQuestion.hint)
                                .padding(.leading, 20)
                                .minimumScaleFactor(0.5)
                                .multilineTextAlignment(.center)
                                .opacity(revealHint ? 1 : 0)
                                .scaleEffect(revealHint ? 1.33 : 1)
                        }
                    Spacer()
                }
            }
            .animation(.easeOut(duration: animateViewsIn ? 1.5 : 0).delay(animateViewsIn ? 2: 0), value: animateViewsIn)
            
            // Right Button
            
            VStack {
                if animateViewsIn {
                    Image(systemName: "app.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100)
                        .foregroundStyle(.cyan)
                        .overlay {
                            Image(systemName: "book.closed")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50)
                                .foregroundStyle(.black)
                        }
                        .padding()
                        .transition(.offset(x: geo.size.width/2))
                        .phaseAnimator([false, true]) { content, phase in
                            content
                                .rotationEffect(Angle(degrees: phase ? 13 : 17))
                        } animation: { _ in
                                .easeIn(duration: 0.7)
                        }
                        .onTapGesture {
                            withAnimation(.easeOut(duration: 1)) {
                                revealBook = true
                            }
                            playFlipSound()
                            game.questionScore -= 1
                        }
                        .rotation3DEffect(.degrees(revealBook ? -1440: 0), axis: (x: 0 , y: 1, z: 0))
                        .scaleEffect(revealBook ? 5 : 1)
                        .offset(x: revealBook ? -geo.size.width/2 : 0)
                        .opacity(revealBook ? 0 : 1)
                        .overlay {
                            Image("hp\(game.currentQuestion.book)")
                                .resizable()
                                .scaledToFit()
                                .padding(.trailing, 20)
                                .opacity(revealBook ? 1 : 0)
                                .scaleEffect(revealBook ? 1.33 : 1)
                        }
                    Spacer()
                }
            }
            .animation(.easeOut(duration: animateViewsIn ? 1.5 : 0).delay(animateViewsIn ? 2 : 0), value: animateViewsIn)
            
        }.padding()
    }
}

#Preview {
    GeometryReader { geo in
        HintsView(animateViewsIn: .constant(true), revealHint: .constant(true), revealBook: .constant(true), geo: geo) {
            print(" playFlipSound")
        }
            .environment(Game())
    }
}
