//
//  GameScene.swift
//  Elementary
//
//  Created by Cooper Richard on 5/1/18.
//  Copyright © 2018 Rick Cooper. All rights reserved.
//

import Foundation
import SpriteKit
import UIKit

class GameScene : SKScene, SKPhysicsContactDelegate {
    
    let model = (UIApplication.shared.delegate as! AppDelegate).appModel
    let points = [(-75, 0), (-52, 52), (0, 75), (52, 52), (75, 0), (52, -52), (0, -75), (-52, -52)]
    var spinnerShape: SKShapeNode?
    var startingAngle: CGFloat?
    var startingTime: TimeInterval?
    var answerBoxes = [AnswerBox]()
    
    override func didMove(to view: SKView) {
        initQuizRound()
    }
    
    private func initQuizRound() {
        removeAllChildren()
        initBackground()
        let quizQuestion = model.initQuizQuestion()
        initElementSpinner(elements: quizQuestion.elements)
        initAnswers(answers: quizQuestion.answers)
    }
    
    private func initAnswers(answers: [Answer]) {
        let top = AnswerBox(size: CGSize(width: frame.width, height: 30), position: CGPoint(x: frame.midX, y: frame.maxY - 79))
        let bottom = AnswerBox(size: CGSize(width: frame.width, height: 30), position: CGPoint(x: frame.midX, y: frame.minY + 15))
        let left = AnswerBox(size: CGSize(width: frame.height, height: 30), position: CGPoint(x: frame.minX + 15, y: frame.midY), rotation: -1.5708)
        let right = AnswerBox(size: CGSize(width: frame.height, height: 30), position: CGPoint(x: frame.maxX - 15, y: frame.midY), rotation: 1.5708)
        answerBoxes = [left, right, top, bottom]
        for box in answerBoxes {
            addChild(box.container)
        }
        top.initLabels(answers[0])
        bottom.initLabels(answers[1])
        left.initLabels(answers[2])
        right.initLabels(answers[3])
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in:self)
            let node = atPoint(location)
            if node.name == "spinner" {
                let dx = location.x - node.position.x
                let dy = location.y - node.position.y
                // Store angle and current time
                startingAngle = atan2(dy, dx)
                startingTime = touch.timestamp
                node.physicsBody?.angularVelocity = 0
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            let location = touch.location(in:self)
            let node = atPoint(location)
            if node.name == "spinner" {
                let dx = location.x - node.position.x
                let dy = location.y - node.position.y
                
                let angle = atan2(dy, dx)
                // Calculate angular velocity; handle wrap at pi/-pi
                if startingAngle == nil {
                    startingAngle = atan2(dy, dx)
                    startingTime = touch.timestamp
                }
                var deltaAngle = angle - startingAngle!
                if abs(deltaAngle) > CGFloat.pi {
                    if (deltaAngle > 0) {
                        deltaAngle = deltaAngle - CGFloat.pi * 2
                    }
                    else {
                        deltaAngle = deltaAngle + CGFloat.pi * 2
                    }
                }
                let dt = CGFloat(touch.timestamp - startingTime!)
                let velocity = deltaAngle / dt
                
                node.physicsBody?.angularVelocity = velocity
                
                // Update angle and time
                startingAngle = angle
                startingTime = touch.timestamp
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        startingAngle = nil
        startingTime = nil
    }
    
    private func initBackground() {
        let background = SKSpriteNode(imageNamed: "game_background")
        background.position = CGPoint(x: frame.midX, y: frame.midY)
        background.size = CGSize(width: frame.size.width, height: frame.size.height)
        addChild(background)
    }
    
    // https://stackoverflow.com/questions/26727774/how-to-draw-a-elementSpinner-in-swift-using-spritekit
    private func initElementSpinner(elements: [Element]){
        let spinnerColour = UIColor(red: 255.0, green: 255.0, blue: 255.0, alpha: 0.5)
        let spinnerShape = SKShapeNode(circleOfRadius: 100)
        spinnerShape.physicsBody = SKPhysicsBody(circleOfRadius: 100)
        self.spinnerShape = spinnerShape
        spinnerShape.position = CGPoint(x: frame.midX, y: frame.midY)
        spinnerShape.physicsBody?.pinned = true
        spinnerShape.physicsBody?.affectedByGravity = false
        spinnerShape.physicsBody!.angularDamping = 0.25
        spinnerShape.strokeColor = spinnerColour
        spinnerShape.glowWidth = 1.0
        spinnerShape.fillColor = spinnerColour
        spinnerShape.name = "spinner"
        addChild(spinnerShape)
        addElements(spinnerShape, elements)
    }
    
    func addElements(_ spinnerShape: SKShapeNode, _ elements: [Element]) {
        for (index, element) in elements.enumerated() {
            let circle = SKShapeNode(circleOfRadius: 20)
            let name = SKLabelNode(fontNamed: "Chalkduster")
            name.text = element.chemicalSymbol
            name.fontSize = 20
            name.position = CGPoint(x: circle.frame.midX, y: circle.frame.midY - 6)
            circle.strokeColor = SKColor.black
            circle.glowWidth = 0.5
            circle.fillColor = UIColor(element.hexColourCode)
            circle.zPosition = 1
            circle.physicsBody = SKPhysicsBody(circleOfRadius: 20)
            circle.physicsBody!.pinned = true
            circle.name = "E_\(index)"
            circle.addChild(name)
            spinnerShape.addChild(circle)
            circle.position = CGPoint(x: points[index].0, y: points[index].1)
        }
    }
    // make children into sprite and and physics.boy.pointtowards
    
    // child rotation
    //https://stackoverflow.com/questions/27571794/how-to-rotate-parent-skspritenode-only-and-not-the-child-node
    
    
    // User Defaults
    // NSKeyedArchiver
    // bounce once then fall off screen
    //https://www.smashingmagazine.com/2016/11/how-to-build-a-spritekit-game-in-swift-3-part-1/
    
    // control rotate
    // https://stackoverflow.com/questions/32143382/drag-rotate-a-node-around-a-fixed-point
}

