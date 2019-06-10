//
//  SoundSettings.swift
//  PresentsSections
//
//  Created by Cat on 5/12/19.
//  Copyright © 2018 Cat. All rights reserved.
//

import AVFoundation

class SoundSettings {
    static let shared = SoundSettings()
    private var audioPlayer = AVAudioPlayer()
    
    func startPlaying() {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "BackgroundSong", ofType: "mp3")!))
            audioPlayer.play()
        }
        catch {
            print(error)
        }
    }
    
    func stopPlaying() {
        if audioPlayer.isPlaying {
            audioPlayer.stop()
        }
    }
    
    private init() {}
    
}
