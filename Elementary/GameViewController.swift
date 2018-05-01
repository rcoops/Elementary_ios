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

class GameViewController : UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let scene = GameScene(size: view.bounds.size)
        let skView = view as! SKView
        scene.scaleMode = .resizeFill
        skView.presentScene(scene)
    }
    
}
