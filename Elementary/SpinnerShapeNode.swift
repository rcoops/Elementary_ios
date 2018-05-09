//
//  Spinner.swift
//  Elementary
//
//  Created by Rick on 09/05/2018.
//  Copyright © 2018 Rick Cooper. All rights reserved.
//

import Foundation
import SpriteKit
import UIKit

class SpinnerShapeNode: SKShapeNode {
    
    let spinnerColour = UIColor(red: 255.0, green: 255.0, blue: 255.0, alpha: 0.5)

    init(circleOfRadius radius: CGFloat, position: CGPoint, name: String) {
        super.init()
        self.path = CGPath(ellipseIn: CGRect(origin: .zero, size: CGSize(width: radius, height: radius)), transform: nil)
        self.position = CGPoint(x: frame.midX, y: frame.midY - 50)
        self.strokeColor = spinnerColour
        self.glowWidth = 1.0
        self.fillColor = spinnerColour
        self.name = name
        self.physicsBody = SKPhysicsBody(circleOfRadius: radius)
        self.physicsBody?.pinned = true
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.categoryBitMask = GameScene.worldCategory
        self.physicsBody?.collisionBitMask = GameScene.worldCategory
        self.physicsBody?.angularDamping = 0.25
        let middle = SKShapeNode(circleOfRadius: 40)
        middle.fillColor = UIColor.createTranslucent(red: 0, green: 50, blue: 255)
        middle.glowWidth = 0.6
        middle.zPosition = 0.5
        middle.strokeColor = spinnerColour
        middle.physicsBody = SKPhysicsBody(circleOfRadius: 40)
        middle.physicsBody!.pinned = true
        middle.physicsBody?.affectedByGravity = false
        middle.physicsBody?.categoryBitMask = GameScene.elementCategory
        middle.physicsBody?.collisionBitMask = GameScene.elementCategory
        self.addChild(middle)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
