//
//  UserDefaultsObservingController.swift
//  Elementary
//
//  Created by Rick on 09/05/2018.
//  Copyright © 2018 Rick Cooper. All rights reserved.
//

import Foundation
import UIKit

class UserDefaultsObservingController: UIViewController {
    
    internal var musicPlaying = false
    
    internal let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UserDefaults.standard.addObserver(self, forKeyPath: "volume", options: .new, context: nil)
        UserDefaults.standard.addObserver(self, forKeyPath: "musicToggle", options: .new, context: nil)
        self.navigationController?.interactivePopGestureRecognizer?.addTarget(self, action:#selector(self.handlePopGesture))
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if let keyPath = keyPath {
            switch keyPath {
            case "volume":
                setVolume()
                break
            case "musicToggle":
                toggleMusic()
                break
            default:
                break
            }
        }
    }
    
    internal func getMusicFileName() -> String {
        preconditionFailure("this method is abstract and must be overridden")
    }
    
    
    @objc internal func handlePopGesture() {
        if !musicPlaying {
            setVolume()
            MusicPlayer.musicPlayer.playBackgroundMusic(url: URL(fileURLWithPath: Bundle.main.path(forResource: getMusicFileName(), ofType: "mp3")!))
            toggleMusic()
            musicPlaying = true
        }
    }
    
    internal func toggleMusic() {
        if UserDefaults.standard.bool(forKey: "musicToggle") {
            MusicPlayer.musicPlayer.audioPlayer?.play()
        } else {
            MusicPlayer.musicPlayer.audioPlayer?.pause()
        }
    }
    
    internal func setVolume() {
        let volume = UserDefaults.standard.float(forKey: "volume")
        MusicPlayer.musicPlayer.audioPlayer?.setVolume(volume, fadeDuration: 0.2)
    }
    
}
