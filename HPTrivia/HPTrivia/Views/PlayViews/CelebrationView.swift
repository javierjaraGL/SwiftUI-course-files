//
//  CelebrationView.swift
//  HPTrivia
//
//  Created by Javier Jara Montoya on 27/8/25.
//

import SwiftUI

struct CelebrationView: View {
    @Binding var animateViewsIn: Bool
    @Binding var tapCorrectAnswer: Bool
    @Binding var movePointsToScore: Bool
    @Binding var wrongAnsweredTapped: [String]
    @Binding var revealHint: Bool
    @Binding var revealBook: Bool

    let namespace: Namespace.ID
    let geo: GeometryProxy

    @Environment(Game.self) private var game

    var body: some View {
        VStack {
            Spacer()
            
            VStack {
                if tapCorrectAnswer {
                    Text("\(game.questionScore)")
                        .font(.largeTitle)
                        .padding(.top, 50)
                        .transition(.offset(y: -geo.size.height/4))
                        .offset(x: movePointsToScore ? (geo.size.width/2.3) : 0 , y: movePointsToScore ? (-geo.size.height/13) : 0)
                        .opacity(movePointsToScore ? 0 : 1)
                        .onAppear {
                            withAnimation(.easeInOut(duration: 1).delay(3)) {
                                movePointsToScore = true
                            }
                        }
                }
            }.animation(.easeInOut(duration: animateViewsIn ? 1 : 0).delay( animateViewsIn ? 2 : 0), value: tapCorrectAnswer)
            
            Spacer()
            
            VStack {
                if tapCorrectAnswer {
                    Text("Brilliant")
                        .font(.custom("PartyLetPlain", size: 100))
                        .transition(.scale.combined(with: .offset(y: -geo.size.height/2)))
                }
            }
            .animation(.easeInOut(duration: tapCorrectAnswer ? 1 : 0).delay(tapCorrectAnswer ? 1 : 0),
                       value: tapCorrectAnswer)
            
            Spacer()
            Spacer()
            
            if tapCorrectAnswer {
                Text(game.currentQuestion.answer)
                    .minimumScaleFactor(0.5)
                    .multilineTextAlignment(.center)
                    .padding(10)
                    .frame(width: geo.size.width/2.15, height: 80)
                    .background(.green.opacity(0.5))
                    .clipShape(.rect(cornerRadius: 25))
                    .scaleEffect(2)
                    .matchedGeometryEffect(id: 1, in: namespace)
            }
            
            Spacer()
            
            VStack {
                if tapCorrectAnswer {
                    Button("Next Level>") {
                        animateViewsIn = false
                        revealHint = false
                        revealBook = false
                        tapCorrectAnswer = false
                        wrongAnsweredTapped = []
                        movePointsToScore = false
                        
                        game.newQuestion()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            animateViewsIn = true
                        }
                    }
                    .font(.largeTitle)
                    .buttonStyle(.borderedProminent)
                    .tint(.blue.opacity(0.5))
                    .transition(.offset(y: geo.size.height/3))
                    .phaseAnimator([false, true]) { content, phase in
                        content
                            .scaleEffect(phase ? 1.2 : 1)
                    } animation: { _ in
                            .easeInOut(duration: 1.3)
                    }
                }
            }
            .animation(.easeInOut(duration: tapCorrectAnswer ? 2.7 : 0).delay( tapCorrectAnswer ? 2.7 : 0), value: tapCorrectAnswer)
            
            Spacer()
        }
    }
}

#Preview {
    GeometryReader { geo in
        CelebrationView(animateViewsIn: .constant(true),
                        tapCorrectAnswer: .constant(true),
                        movePointsToScore: .constant(true),
                        wrongAnsweredTapped: .constant([""]),
                        revealHint: .constant(true),
                        revealBook: .constant(true),
                        namespace: Namespace().wrappedValue,
                        geo: geo)
        .environment(Game())
    }
}
