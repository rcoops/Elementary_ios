//
//  GameViewController.swift
//  Elementary
//
//  Created by Cooper Richard on 5/1/18.
//  Copyright © 2018 Rick Cooper. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

class GameViewController : UIViewController, GameManager {
    
    let model = (UIApplication.shared.delegate as! AppDelegate).appModel
    
    var musicPlaying = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UserDefaults.standard.addObserver(self, forKeyPath: "volume", options: .new, context: nil)
        UserDefaults.standard.addObserver(self, forKeyPath: "musicToggle", options: .new, context: nil)
        setVolume()
        self.navigationController?.interactivePopGestureRecognizer?.addTarget(self, action:#selector(self.handlePopGesture))
        handlePopGesture()
        let scene = GameScene(size: view.bounds.size)
        scene.setGameManager(self)
        let skView = view as! SKView
        scene.scaleMode = .resizeFill
        skView.presentScene(scene)
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
    
    private func setVolume() {
        let volume = UserDefaults.standard.float(forKey: "volume")
        MusicPlayer.musicPlayer.audioPlayer?.setVolume(volume, fadeDuration: 0.2)
    }
    
    private func toggleMusic() {
        if UserDefaults.standard.bool(forKey: "musicToggle") {
            MusicPlayer.musicPlayer.audioPlayer?.play()
        } else {
            MusicPlayer.musicPlayer.audioPlayer?.pause()
        }
    }
    
    @objc private func handlePopGesture() {
        if !musicPlaying {
            setVolume()
            MusicPlayer.musicPlayer.playBackgroundMusic(url: URL(fileURLWithPath: Bundle.main.path(forResource: "music_game", ofType: "mp3")!))
            toggleMusic()
            musicPlaying = true
        }
    }
    
    func endGame() {
        musicPlaying = false
        let action: ((UIAlertAction) -> Swift.Void) = { _ in self.performSegue(withIdentifier: "home", sender: self) }
        showPopup(title: "Game Over", message: "Uh oh! You're out of lives, your score is \(model.currentPlayer!.score)", action)
    }
    
    func showPopup(title: String, message: String, _ action: ((UIAlertAction) -> Swift.Void)? = nil) {
        alertWithTitle(title: title, message:message, ViewController: self, action: action)
    }
    
}

protocol GameManager {
    func endGame()
    func showPopup(title: String, message: String, _ action: ((UIAlertAction) -> Swift.Void)?)
}
