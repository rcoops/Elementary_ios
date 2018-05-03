//
//  AnswerBox.swift
//  Elementary
//
//  Created by Cooper Richard on 5/2/18.
//  Copyright © 2018 Rick Cooper. All rights reserved.
//

import Foundation
import SpriteKit

class AnswerFacade : SKNodeFacade {
    
    private let label = SKLabelNode()
    private static let backgroundColour = UIColor.createTranslucent(red: 255, green: 255, blue: 255)
    let answer: Answer
    
    let container: SKShapeNode
    
    init(answer: Answer, size: CGSize, position: CGPoint, rotationDegrees: CGFloat = 0) {
        self.answer = answer
        container = SKShapeNode(rectOf: size)
        container.fillColor = AnswerFacade.backgroundColour
        container.strokeColor = AnswerFacade.backgroundColour
        initLabel(answer)
        container.position = position
        container.zRotation = rotationDegrees.toRadians()
        setRecanglularPhysicsBody(for: container, rotated: rotationDegrees != 0)
    }
    
    func getNode() -> SKShapeNode {
        return container
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initLabel(_ answer: Answer) {
        label.fontSize = 20
        label.text = "\(answer.property): \(answer.value)"
        label.fontColor = SKColor.black
        label.position = CGPoint(x: container.frame.midX, y: container.frame.midY - label.frame.midY)
        container.addChild(label)
    }
    
    private func setRecanglularPhysicsBody(for node: SKNode, rotated: Bool = false) {
        let width = rotated ? node.frame.height : node.frame.width
        let height = rotated ? node.frame.width : node.frame.height
        node.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: width, height: height))
        node.physicsBody?.affectedByGravity = false
        node.physicsBody?.allowsRotation = false
        node.physicsBody?.categoryBitMask = GameScene.answerCategory
        node.physicsBody?.contactTestBitMask = GameScene.elementCategory
        node.physicsBody?.collisionBitMask = GameScene.elementCategory
    }
    
}
