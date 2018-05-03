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
    var sprite: SKNode!
    var touchPoint: CGPoint = CGPoint()
    var touching: Bool = false
    
    let model = (UIApplication.shared.delegate as! AppDelegate).appModel
    let points = [(-75, 0), (-52, 52), (0, 75), (52, 52), (75, 0), (52, -52), (0, -75), (-52, -52)]
    var spinnerShape: SKShapeNode?
    var startingAngle: CGFloat? = 0
    var startingTime: TimeInterval? = 0
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
        let top = AnswerBox(answer: answers[0], size: CGSize(width: frame.width, height: 30), position: CGPoint(x: frame.midX, y: frame.maxY - 79))
        let bottom = AnswerBox(answer: answers[1], size: CGSize(width: frame.width, height: 30), position: CGPoint(x: frame.midX, y: frame.minY + 15))
        let left = AnswerBox(answer: answers[2], size: CGSize(width: frame.height - 126, height: 30), position: CGPoint(x: frame.minX + 15, y: frame.midY - 32), rotationDegrees: 90)
        let right = AnswerBox(answer: answers[3], size: CGSize(width: frame.height - 126, height: 30), position: CGPoint(x: frame.maxX - 15, y: frame.midY - 32), rotationDegrees: -90)
        answerBoxes = [left, right, top, bottom]
        for box in answerBoxes {
            addChild(box.container)
        }
    }
    // https://stackoverflow.com/questions/28245653/how-to-throw-skspritenode
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
            } else if node.name?.contains("E_") ?? false {
                touchPoint = location
                touching = true
                sprite = node.name!.contains("label") ? node.parent! : node
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in:self)
            let node = atPoint(location)
            if node.name == "spinner" {
                doSpin(location: location, node: node, timestamp: touch.timestamp)
            } else if node.name?.contains("E_") ?? false {
                touchPoint = location
                let node = node.name!.contains("label") ? node.parent! : node
            }
        }
    }
    
    private func doSpin(location: CGPoint, node: SKNode, timestamp: TimeInterval) {
        let dx = location.x - node.position.x
        let dy = location.y - node.position.y
        
        let angle = atan2(dy, dx)
        var deltaAngle = angle - startingAngle!
        if abs(deltaAngle) > CGFloat.pi {
            if (deltaAngle > 0) {
                deltaAngle = deltaAngle - CGFloat.pi * 2
            }
            else {
                deltaAngle = deltaAngle + CGFloat.pi * 2
            }
        }
        let dt = CGFloat(timestamp - startingTime!)
        let velocity = deltaAngle / dt
        
        node.physicsBody?.angularVelocity = velocity
        
        // Update angle and time
        startingAngle = angle
        startingTime = timestamp
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        startingAngle = 0
        startingTime = 0
        touching = false
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
        let spinnerShape = SKShapeNode(circleOfRadius: 120)
        self.spinnerShape = spinnerShape
        spinnerShape.physicsBody = SKPhysicsBody(circleOfRadius: 120)
        spinnerShape.position = CGPoint(x: frame.midX, y: frame.midY - 50)
        spinnerShape.physicsBody?.pinned = true
        spinnerShape.physicsBody?.affectedByGravity = false
        spinnerShape.physicsBody!.angularDamping = 0.25
        spinnerShape.strokeColor = spinnerColour
        spinnerShape.glowWidth = 1.0
        spinnerShape.fillColor = spinnerColour
        spinnerShape.name = "spinner"
        let middle = SKShapeNode(circleOfRadius: 40)
        middle.fillColor = SKColor(red: 0, green: 50, blue: 255, alpha: 0.75)
        middle.glowWidth = 0.6
        middle.strokeColor = spinnerColour
        middle.physicsBody = SKPhysicsBody(circleOfRadius: 40)
        middle.physicsBody!.pinned = true
        middle.physicsBody?.affectedByGravity = false
        middle.zPosition = 0.5
        spinnerShape.addChild(middle)
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
            name.name = "E_label_\(index)"
            circle.strokeColor = SKColor.black
            circle.glowWidth = 0.5
            circle.fillColor = UIColor(element.hexColourCode)
            name.fontColor = getTextColour(colour: circle.fillColor)
            circle.zPosition = 1
            circle.physicsBody = SKPhysicsBody(circleOfRadius: 20)
            circle.physicsBody?.affectedByGravity = false
            circle.physicsBody!.pinned = true
            let circleName = "E_\(index)"
            circle.name = circleName
            circle.addChild(name)
            spinnerShape.addChild(circle)
            circle.position = CGPoint(x: points[index].0, y: points[index].1)
        }
    }
    
    override func update(_ currentTime: CFTimeInterval) {
        if touching {
            let dt: CGFloat = 1.0 / 2.0
            let spritePosition = sprite.position + spinnerShape!.position
            print("TouchPos: \(touchPoint), SpritePos: \(spritePosition)")
            let distance = CGVector(dx: touchPoint.x - spritePosition.x, dy: touchPoint.y - spritePosition.y)
            let velocity = CGVector(dx: distance.dx/dt, dy: distance.dy/dt)
            print("Velocity: \(velocity)")
            sprite.physicsBody?.pinned = false
            sprite.physicsBody!.velocity=velocity
        }
    }
    
    // https://stackoverflow.com/questions/2509443/check-if-uicolor-is-dark-or-bright
    func getTextColour(colour: UIColor) -> UIColor {
        let components = colour.cgColor.components!.map { $0 * 255 }
        let brightness = (components[0] * 299 + components[1] * 587 + components[2] * 114) / 1000
        return brightness > 125 ? UIColor.black : UIColor.white
    }
    // make children into sprite and and physics.boy.pointtowards
    
    // child rotation
    //https://stackoverflow.com/questions/27571794/how-to-rotate-parent-skspritenode-only-and-not-the-child-node
    
    
    // User Defaults
    // NSKeyedArchiver
    // https://developer.apple.com/documentation/swift/hashable
    // bounce once then fall off screen
    //https://www.smashingmagazine.com/2016/11/how-to-build-a-spritekit-game-in-swift-3-part-1/
    
    // control rotate
    // https://stackoverflow.com/questions/32143382/drag-rotate-a-node-around-a-fixed-point
}

