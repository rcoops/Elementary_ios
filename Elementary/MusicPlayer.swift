//
//  MusicPlayer.swift
//  Elementary
//
//  Created by Cooper Richard on 5/4/18.
//  Copyright © 2018 Rick Cooper. All rights reserved.
//

import Foundation
import AVFoundation

class MusicPlayer {
    
    static let musicPlayer = MusicPlayer()
    
    private var audioPlayer: AVAudioPlayer?
    
    func playBackgroundMusic(url: URL) {
        if audioPlayer != nil {
            audioPlayer?.stop()
            audioPlayer = nil
        }
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer!.numberOfLoops = -1
            audioPlayer!.prepareToPlay()
            audioPlayer!.play()
        } catch {
            print("Cannot play the file")
            print(error)
        }
    }
    
    func play() {
        audioPlayer?.play()
    }
    
    func pause() {
        audioPlayer?.pause()
    }
    
    func setVolume(_ volume: Float, fadeDuration: TimeInterval) {
        audioPlayer?.setVolume(volume, fadeDuration: fadeDuration)
    }
    
}
