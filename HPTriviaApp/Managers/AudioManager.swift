//
//  AudioManager.swift
//  HPTriviaApp
//
//  Created by Demetre Panjakidze on 13.12.24.
//

import Foundation
import AVKit

class AudioManager: ObservableObject {
    private var musicPlayer: AVAudioPlayer?
    var audioPlayers: [AVAudioPlayer] = []
    
    init() {
        setupAudioSession()
    }
    
    private func setupAudioSession() {
        do {
            try AVAudioSession.sharedInstance().setCategory(
                .ambient,
                mode: .default,
                options: [.mixWithOthers]
            )
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Failed to set up audio session: \(error)")
        }
    }
    
    func playMusic() {
        let songs = ["let-the-mystery-unfold", "spellcraft", "hiding-place-in-the-forest", "deep-in-the-dell"]
        
        guard let soundPath = Bundle.main.path(
            forResource: songs.randomElement(),
            ofType: "mp3"
        ) else {
            print("audio not found.")
            return
        }
        
        do {
            musicPlayer?.stop()
            
            musicPlayer = try AVAudioPlayer(
                contentsOf: URL(filePath: soundPath)
            )
            musicPlayer?.volume = 0.1
            musicPlayer?.numberOfLoops = -1
            musicPlayer?.prepareToPlay()
            musicPlayer?.play()
        } catch {
            print("Error: \(error)")
        }
    }
    
    func playSound(_ soundPath: String) {
        guard let sound = Bundle.main.path(
            forResource: soundPath,
            ofType: "mp3"
        ) else {
            print("audio not found.")
            return
        }
        
        do {
            let player = try AVAudioPlayer(contentsOf: URL(filePath: sound))
            player.prepareToPlay()
            player.play()
            
            audioPlayers = audioPlayers.filter { $0.isPlaying }
            
            audioPlayers.append(player)
        } catch {
            print("Error: \(error)")
        }
    }
    
    func stopAllSounds() {
        audioPlayers.forEach { $0.stop() }
        audioPlayers.removeAll()
    }
}
