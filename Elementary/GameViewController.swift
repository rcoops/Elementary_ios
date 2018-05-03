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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let scene = GameScene(size: view.bounds.size)
        scene.setGameManager(self)
        let skView = view as! SKView
        scene.scaleMode = .resizeFill
        skView.presentScene(scene)
    }
    
    func endGame() {
        alertWithTitle(title: "Game Over", message: "Uh oh! You're out of lives, your score is \(model.currentPlayer!.score)", ViewController: self)
        self.performSegue(withIdentifier: "home", sender: self)
    }
    
    func showPopup(title: String, message: String) {
        alertWithTitle(title: title, message:message, ViewController: self)
    }
    
}

protocol GameManager {
    func endGame()
    func showPopup(title: String, message: String)
}
