//
//  QuoteView.swift
//  BBQuotes
//
//  Created by Javier Jara Montoya on 11/8/25.
//

import SwiftUI

struct FetchView: View {
    @State var showCharInfo = false
    let vm =  ViewModel()
    let show: Show

    var body: some View {
        GeometryReader { geo in
            // BackGround image
            ZStack {
                Image(show.backgroundImage)
                    .resizable()
                    .frame(width: geo.size.width * 2.7, height: geo.size.height * 1.2)
                
                VStack{
                    VStack {
                        Spacer(minLength: 60)
                        
                        switch vm.status {
                        case .notStarted:
                            EmptyView()
                        case .fetching:
                            ProgressView()
                        case .successQuote:
                            Text("\"\(vm.quote.quote)\"")
                                .minimumScaleFactor(0.5)
                                .multilineTextAlignment(.center)
                                .foregroundStyle(.white)
                                .padding()
                                .background(.black.opacity(0.5))
                                .clipShape(.rect(cornerRadius: 25))
                                .padding(.horizontal)
                            ZStack (alignment: .bottom) {
                                AsyncImage(url: vm.character.images[0]) { image in
                                    image
                                        .resizable()
                                        .scaledToFill()
                                } placeholder: {
                                    ProgressView()
                                }
                                .frame(width: geo.size.width/1.1, height: geo.size.height/1.8)
                                Text(vm.quote.character)
                                    .foregroundStyle(.white)
                                    .padding(10)
                                    .frame(maxWidth: .infinity)
                                    .background(.thinMaterial)
                            }
                            .frame(width: geo.size.width/1.1, height: geo.size.height/1.8)
                            .clipShape(.rect(cornerRadius: 50))
                            .onTapGesture{
                                showCharInfo.toggle()
                            }
                        case .successEpisode:
                            EpisodeView(episode: vm.episode)
                        case .failed(let error):
                            Text(error.localizedDescription)
                        }
                        
                        Spacer(minLength: 20)
                        HStack {
                            Button {
                                Task {
                                    await vm.getQuoteData(for: show.rawValue)
                                }
                            } label: {
                                let backgroundColor = "\(show.rawValue.removeSpaces())Button"
                                let shadowColor = "\(show.rawValue.removeSpaces())Shadow"
                                Text("Get Random Quote")
                                    .font(.title3)
                                    .foregroundStyle(.white)
                                    .padding()
                                    .background(Color(backgroundColor))
                                    .clipShape(.rect(cornerRadius: 7))
                                    .shadow(color: Color(shadowColor), radius: 2)
                            }
                            Spacer()
                            Button {
                                Task {
                                    await vm.getEpisode(for: show.rawValue)
                                }
                            } label: {
                                let backgroundColor = "\(show.rawValue.removeSpaces())Button"
                                let shadowColor = "\(show.rawValue.removeSpaces())Shadow"
                                Text("Get Random Episode")
                                    .font(.title3)
                                    .foregroundStyle(.white)
                                    .padding()
                                    .background(Color(backgroundColor))
                                    .clipShape(.rect(cornerRadius: 7))
                                    .shadow(color: Color(shadowColor), radius: 2)
                            }
                        }
                        .padding(.horizontal, 25)
                    }
                    Spacer(minLength: 95)
                }
                .frame(width: geo.size.width, height: geo.size.height)
            }
            .frame(width: geo.size.width, height: geo.size.height)
        }
        .ignoresSafeArea()
        .sheet(isPresented: $showCharInfo) {
            CharacterView(character: vm.character, show: show)
        }
    }
}

#Preview {
    FetchView(show: .breakingbad)
        .preferredColorScheme(.dark)
}
