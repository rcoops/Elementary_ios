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
    
    private static let spinnerColour = UIColor(red: 255.0, green: 255.0, blue: 255.0, alpha: 0.5)
    private let centre = SKShapeNode(circleOfRadius: 40)

    init(circleOfRadius radius: CGFloat, position: CGPoint, name: String) {
        super.init()
        let diameter = radius * 2
        self.path = CGPath(ellipseIn: CGRect(origin: CGPoint(x: -radius, y: -radius), size: CGSize(width: diameter, height: diameter)), transform: nil)
        self.position = position
        self.strokeColor = SpinnerShapeNode.spinnerColour
        self.glowWidth = 1.0
        self.fillColor = SpinnerShapeNode.spinnerColour
        self.name = name
        initPhysicsBody()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func initPhysicsBody() {
        self.physicsBody = SKPhysicsBody(circleOfRadius: 120)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.pinned = true
        self.physicsBody?.categoryBitMask = GameScene.worldCategory
        self.physicsBody?.collisionBitMask = GameScene.worldCategory
        self.physicsBody?.angularDamping = 0.25
    }
    
    private func initCentre() {
        centre.fillColor = UIColor.createTranslucent(red: 0, green: 50, blue: 255)
        centre.glowWidth = 0.6
        centre.zPosition = 0.5 // Bit further forward
        centre.strokeColor = SpinnerShapeNode.spinnerColour
        centre.physicsBody = SKPhysicsBody(circleOfRadius: 40)
        centre.physicsBody!.pinned = true
        centre.physicsBody?.affectedByGravity = false
        centre.physicsBody?.categoryBitMask = GameScene.elementCategory
        centre.physicsBody?.collisionBitMask = GameScene.elementCategory
        self.addChild(centre)
    }
    
}
