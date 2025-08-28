//
//  AnswersView.swift
//  HPTrivia
//
//  Created by Javier Jara Montoya on 27/8/25.
//

import SwiftUI

struct AnswersView: View {
    @Binding var animateViewsIn: Bool
    @Binding var tapCorrectAnswer: Bool
    let namespace: Namespace.ID
    
    @Binding var wrongAnsweredTapped: [String]

    let geo: GeometryProxy
    var playCorrectSound: () -> Void
    var playWrongSound: () -> Void

    @Environment(Game.self) private var game
    
    var body: some View {
        LazyVGrid(columns: [GridItem(), GridItem()]) {
            ForEach(game.answers, id: \.self) { answer in
                if answer == game.currentQuestion.answer {
                    VStack {
                        if animateViewsIn {
                            if !tapCorrectAnswer {
                                Button {
                                    withAnimation(.easeOut(duration: 1)) {
                                        tapCorrectAnswer = true
                                    }
                                    playCorrectSound()
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
                                        game.correct()
                                    }
                                } label: {
                                    Text(answer)
                                        .minimumScaleFactor(0.5)
                                        .multilineTextAlignment(.center)
                                        .padding(10)
                                        .frame(width: geo.size.width/2.15, height: 80)
                                        .background(.green.opacity(0.5))
                                        .clipShape(.rect(cornerRadius: 25))
                                        .matchedGeometryEffect(id: 1, in: namespace)
                                }
                                .transition(.asymmetric(insertion: .scale, removal: .scale(scale: 15).combined(with: .opacity)))
                            }
                        }
                    }
                    .animation(.easeOut(duration: 1).delay(1.5), value: animateViewsIn)
                } else {
                    // Wrong answer
                    VStack {
                        if animateViewsIn {
                            Button {
                                withAnimation(.easeOut(duration: 1)) {
                                    wrongAnsweredTapped.append(answer)
                                }
                                playWrongSound()
                                game.questionScore -= 1
                            } label: {
                                Text(answer)
                                    .minimumScaleFactor(0.5)
                                    .multilineTextAlignment(.center)
                                    .padding(10)
                                    .frame(width: geo.size.width/2.15, height: 80)
                                    .background(wrongAnsweredTapped.contains(answer) ? .red.opacity(0.5) : .green.opacity(0.5))
                                    .clipShape(.rect(cornerRadius: 25))
                                    .scaleEffect(wrongAnsweredTapped.contains(answer) ? 0.8 : 1)
                            }
                            .transition(.scale)
                            .sensoryFeedback(.error, trigger: wrongAnsweredTapped)
                            .disabled(wrongAnsweredTapped.contains(answer))
                        }
                    }
                    .animation(.easeOut(duration: animateViewsIn ? 1 : 0).delay(animateViewsIn ? 1.5 : 0), value: animateViewsIn)
                }
            }
        }
    }
}

#Preview {
    GeometryReader { geo in
        AnswersView(animateViewsIn: .constant(true),
                    tapCorrectAnswer: .constant(true),
                    namespace: Namespace().wrappedValue,
                    wrongAnsweredTapped: .constant([""]),
                    geo: geo,
                    playCorrectSound: { print("play correct sound") },
                    playWrongSound: { print ("Play wrong sound")}
        )
        .environment(Game())
    }
}
