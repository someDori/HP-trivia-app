//
//  ContentView.swift
//  HPTriviaApp
//
//  Created by Demetre Panjakidze on 11.12.24.
//

import AVKit
import SwiftUI

struct ContentView: View {
    @State private var audioPlayer: AVAudioPlayer!
    @State private var scalePlayButton = false
    @State private var moveBackroundImage = false
    @State private var animateViewsIn = false
    @State private var showInstructions = false
    @State private var showSettings = false
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Image("hogwarts")
                    .resizable()
                    .frame(width: geo.size.width * 3, height: geo.size.height * 1.05)
                    .offset(x: moveBackroundImage ?
                        geo.size.width / 1.1 :
                        geo.size.width / -1.1)
                    .onAppear {
                        withAnimation(.linear(duration: 60).repeatForever()) {
                            moveBackroundImage.toggle()
                        }
                    }
                
                VStack {
                    VStack {
                        if animateViewsIn {
                            VStack {
                                Image(systemName: "bolt.fill")
                                    .font(.largeTitle)
                                    .imageScale(.large)
                                
                                Text("HP")
                                    .font(.custom(Constants.hpFont, size: 70))
                                    .padding(.bottom, -50)
                                
                                Text("Trivia")
                                    .font(.custom(Constants.hpFont, size: 60))
                            }
                            .padding(.top, 120)
                            .transition(.move(edge: .top))
                        }
                    }
                    .animation(
                        .easeOut(
                            duration: 0.7).delay(2),
                        value: animateViewsIn
                    )
                    
                    Spacer()
                    
                    VStack {
                        if animateViewsIn {
                            VStack {
                                Text("Recent Scores")
                                    .font(.title2)
                                
                                Text("33")
                                Text("27")
                                Text("15")
                            }
                            .font(.title3)
                            .padding(.horizontal)
                            .foregroundStyle(.white)
                            .background(.black.opacity(0.7))
                            .clipShape(.rect(cornerRadius: 15))
                            .transition(.opacity)
                        }
                    }
                    .animation(
                        .linear(
                            duration: 1).delay(4),
                        value: animateViewsIn
                    )
                    
                    Spacer()
                    
                    HStack {
                        Spacer()
                        
                        VStack {
                            if animateViewsIn {
                                Button {
                                    showInstructions.toggle()
                                } label: {
                                    Image(systemName: "info.circle.fill")
                                        .font(.largeTitle)
                                        .foregroundStyle(.white)
                                        .shadow(radius: 5)
                                }
                                .transition(.offset(x: -geo.size.width / 4))
                            }
                        }
                        .animation(
                            .easeOut(
                                duration: 0.7).delay(2.7),
                            value: animateViewsIn
                        )
                        
                        Spacer()
                        
                        VStack {
                            if animateViewsIn {
                                Button {
                                    // start new game
                                } label: {
                                    Text("Play")
                                        .font(.largeTitle)
                                        .foregroundStyle(.white)
                                        .padding(.vertical, 7)
                                        .padding(.horizontal, 50)
                                        .background(.brown)
                                }
                                .clipShape(.rect(cornerRadius: 7))
                                .shadow(radius: 5)
                                .scaleEffect(scalePlayButton ? 1.2 : 1)
                                .onAppear {
                                    withAnimation(.easeInOut(duration: 1.3).repeatForever()) {
                                        scalePlayButton.toggle()
                                    }
                                }
                                .transition(.offset(y: geo.size.height / 3))
                            }
                        }
                        .animation(
                            .easeOut(
                                duration: 0.7).delay(2),
                            value: animateViewsIn
                        )
                        
                        Spacer()
                        
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
                                .transition(.offset(x: geo.size.width / 4))
                            }
                        }
                        .animation(
                            .easeOut(
                                duration: 0.7).delay(2.7),
                            value: animateViewsIn
                        )
                        
                        Spacer()
                    }
                    .frame(width: geo.size.width)
                    
                    Spacer()
                }
            }
            .frame(width: geo.size.width, height: geo.size.height)
        }
        .ignoresSafeArea()
        .sheet(isPresented: $showInstructions) {
            Instructions()
        }
        .sheet(isPresented: $showSettings) {
            Settings()
        }
        .onAppear {
            animateViewsIn = true
//            playAudio()
        }
    }
    
    private func playAudio() {
        guard let soundPath = Bundle.main.path(
            forResource: "magic-in-the-air",
            ofType: "mp3"
        ) else {
            print("audio not found.")
            return
        }
        
        do {
            audioPlayer = try AVAudioPlayer(
                contentsOf: URL(filePath: soundPath)
            )
            audioPlayer?.numberOfLoops = -1
            audioPlayer?.play()
        } catch {
            print("Error: \(error)")
        }
    }
}

#Preview {
    ContentView()
}
