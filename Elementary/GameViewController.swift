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
        self.navigationController?.interactivePopGestureRecognizer?.addTarget(self, action:#selector(self.handlePopGesture))
        handlePopGesture()
        let scene = GameScene(size: view.bounds.size)
        scene.setGameManager(self)
        let skView = view as! SKView
        scene.scaleMode = .resizeFill
        skView.presentScene(scene)
    }
    
    @objc private func handlePopGesture() {
        if !musicPlaying {
            MusicPlayer.musicPlayer.playBackgroundMusic(url: URL(fileURLWithPath: Bundle.main.path(forResource: "music_game", ofType: "mp3")!))
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
