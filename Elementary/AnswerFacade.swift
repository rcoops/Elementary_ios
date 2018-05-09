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
    private let shape: SKShapeNode
    
    let answer: Answer
    
    init(answer: Answer, size: CGSize, position: CGPoint, rotationDegrees: CGFloat = 0) {
        self.answer = answer
        shape = SKShapeNode(rectOf: size)
        shape.fillColor = AnswerFacade.backgroundColour
        shape.strokeColor = AnswerFacade.backgroundColour
        initLabel(answer)
        shape.position = position
        shape.zRotation = rotationDegrees.toRadians()
        setRecanglularPhysicsBody(for: shape, rotated: rotationDegrees != 0)
    }
    
    func getNode() -> SKShapeNode {
        return shape
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initLabel(_ answer: Answer) {
        label.fontSize = 20
        label.text = "\(answer.property): \(answer.value)"
        label.fontColor = SKColor.black
        label.position = CGPoint(x: shape.frame.midX, y: shape.frame.midY - label.frame.midY)
        shape.addChild(label)
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
