//
//  Gameplay.swift
//  HPTrivia
//
//  Created by Javier Jara Montoya on 21/8/25.
//

import SwiftUI
import AVKit

struct Gameplay: View {
    @Environment(Game.self) private var game
    @Environment(\.dismiss) private var dismiss
    @Namespace private var namespace

    @State private var musicPlayer: AVAudioPlayer!
    @State private var sfxPlayer: AVAudioPlayer!

    @State private var animateViewsIn = false
    @State private var revealHint = false
    @State private var revealBook = false
    @State private var tapCorrectAnswer = false
    @State private var wrongAnsweredTapped:[String] = []
    @State private var movePointsToScore = false

    var body: some View {
        GeometryReader { geo in
            ZStack {
                Image(.hogwarts)
                    .resizable()
                    .frame(width: geo.size.width * 3, height: geo.size.height * 1.05)
                    .overlay {
                        Rectangle()
                            .foregroundStyle(.black.opacity(0.8))
                    }
                VStack {
                    // MARK: - Controls
                    HStack {
                        Button("End Game") {
                            game.endGame()
                            dismiss()
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(.red.opacity(0.5))
                        
                        Spacer()
                        
                        Text("Score: \(game.gameScore)")
                    }
                    .padding()
                    .padding(.vertical, 30)
                    // MARK: - Question
                    
                    VStack {
                        VStack {
                            if animateViewsIn {
                                Text(game.currentQuestion.question)
                                    .font(.custom("PartyLetPlain", size: 50))
                                    .multilineTextAlignment(.center)
                                    .padding()
                                    .transition(.scale)
                            }
                        }
                        .animation(.easeInOut(duration: animateViewsIn ? 2: 0), value: animateViewsIn)
                        Spacer()
                        // MARK: - Hints
                        HintsView(animateViewsIn: $animateViewsIn,
                                  revealHint: $revealHint,
                                  revealBook: $revealBook,
                                  geo: geo, playFlipSound: playFlipSound)
                        // MARK: - Answers
                        AnswersView(animateViewsIn: $animateViewsIn,
                                    tapCorrectAnswer: $tapCorrectAnswer,
                                    namespace: namespace,
                                    wrongAnsweredTapped: $wrongAnsweredTapped,
                                    geo: geo,
                                    playCorrectSound: playCorrectSound,
                                    playWrongSound: playWrongSound)
                        Spacer()
                    }
                    .disabled(tapCorrectAnswer)
                    .opacity(tapCorrectAnswer ? 0.1 : 1)
                }
                .foregroundStyle(.white)
                .frame(width: geo.size.width, height: geo.size.height)
                
                // MARK: - Celebration
                CelebrationView(animateViewsIn: $animateViewsIn,
                                tapCorrectAnswer: $tapCorrectAnswer,
                                movePointsToScore: $movePointsToScore,
                                wrongAnsweredTapped: $wrongAnsweredTapped,
                                revealHint: $revealHint,
                                revealBook: $revealBook,
                                namespace: namespace,
                                geo: geo)
            }
            .frame(width: geo.size.width, height: geo.size.height)
            .foregroundStyle(.white)
        }
        .ignoresSafeArea()
        .onAppear{
            game.startGame()
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                playMusic()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                animateViewsIn = true
            }
        }
    }
    
    private func playMusic() {
        let songs = ["let-the-mystery-unfold", "spellcraft", "hiding-place-in-the-forest", "deep-in-the-dell"]
        
        let song = songs.randomElement()!
        
        let sound = Bundle.main.path(forResource: song, ofType: "mp3")
        musicPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
        musicPlayer.numberOfLoops = -1
        musicPlayer.volume = 0.1
        musicPlayer.play()
    }

    private func playFlipSound() {
        let sound = Bundle.main.path(forResource: "page-flip", ofType: "mp3")
        sfxPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
        sfxPlayer.play()
    }
    
    private func playWrongSound() {
        let sound = Bundle.main.path(forResource: "negative-beeps", ofType: "mp3")
        sfxPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
        sfxPlayer.play()
    }
    
    private func playCorrectSound() {
        let sound = Bundle.main.path(forResource: "magic-wand", ofType: "mp3")
        sfxPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
        sfxPlayer.play()
    }
}

#Preview {
    Gameplay()
        .environment(Game())
}


