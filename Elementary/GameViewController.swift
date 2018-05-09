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

class GameViewController : UserDefaultsObservingController, GameManager {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setVolume()
        handlePopGesture()
        let scene = GameScene(size: view.bounds.size)
        scene.setGameManager(self)
        let skView = view as! SKView
        scene.scaleMode = .resizeFill
        skView.presentScene(scene)
    }
    
    override internal func getMusicFileName() -> String {
        return "music_game"
    }
    
    func endGame() {
        musicPlaying = false
        let action: ((UIAlertAction) -> Swift.Void) = { _ in self.performSegue(withIdentifier: "home", sender: self) }
        showPopup(title: "Game Over", message: "Uh oh! You're out of lives, your score is \(appDelegate.appModel.currentPlayer!.score)", action)
    }
    
    func showPopup(title: String, message: String, _ action: ((UIAlertAction) -> Swift.Void)? = nil) {
        alertWithTitle(title: title, message:message, ViewController: self, action: action)
    }
    
}

protocol GameManager {
    func endGame()
    func showPopup(title: String, message: String, _ action: ((UIAlertAction) -> Swift.Void)?)
}
