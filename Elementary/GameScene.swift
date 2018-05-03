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
    var restart = true
    
    let lives = SKLabelNode(fontNamed: "AvenirNext-Bold")
    let score = SKLabelNode(fontNamed: "AvenirNext-Bold")
    let model = (UIApplication.shared.delegate as! AppDelegate).appModel
    let points = [(-75, 0), (-52, 52), (0, 75), (52, 52), (75, 0), (52, -52), (0, -75), (-52, -52)]
    var spinnerShape: SKShapeNode?
    var startingAngle: CGFloat? = 0
    var startingTime: TimeInterval? = 0
    var answerFacades = [AnswerFacade]()
    var elementFacades = [ElementFacade]()
    
    static let elementCategory:UInt32 = 0x1 << 1;
    static let answerCategory:UInt32 = 0x1 << 2;
    let spinnerMiddleCategory:UInt32 = 0x1 << 3;
    let worldCategory:UInt32 = 0x1 << 4;
    let fakeCategory:UInt32 = 0x1 << 5;
    
    override func didMove(to view: SKView) {
        initQuizRound()
        physicsWorld.gravity = CGVector(dx: 0.0, dy: -9.8);
        physicsWorld.contactDelegate = self
    }
    
    private func initHudLabel(label: SKLabelNode, position: CGPoint) {
        label.fontColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
        label.fontSize = 30
        label.position = CGPoint(x: position.x, y: (position.y - label.frame.height) / 2)
    }
    
    private func initQuizRound() {
        model.answeredCount = 0
        model.correctAnswerCount = 0
        removeAllChildren()
        initBackground()
        let quizQuestion = model.initQuizQuestion()
        initElementSpinner(elements: quizQuestion.elements)
        initAnswers(answers: quizQuestion.answers)
        initHud()
        restart = true
    }
    
    private func initHud() {
        let avatar = SKSpriteNode(imageNamed: model.currentPlayer!.imageName)
        avatar.alpha = 0.4
        avatar.size = CGSize(width: 40, height: 40)
        avatar.position = CGPoint(x: 60, y: 40 + avatar.frame.height / 2)
        addChild(avatar)
        let scoreImage = SKSpriteNode(imageNamed: "ic_score")
        scoreImage.alpha = 0.4
        scoreImage.position = CGPoint(x: 260, y: 40 + scoreImage.frame.height / 2)
        addChild(scoreImage)
        initHudLabel(label: lives, position: CGPoint(x: 100, y: 80 + avatar.frame.height))
        initHudLabel(label: score, position: CGPoint(x: 300, y: 80 + scoreImage.frame.height))
        addChild(lives)
        addChild(score)
        updateHud()
    }
    
    private func updateHud() {
        lives.text = String(model.currentPlayer!.lives)
        score.text = String(model.currentPlayer!.score)
    }

    private func initAnswers(answers: [Answer]) {
        let top = AnswerFacade(answer: answers[0], size: CGSize(width: frame.width, height: 30), position: CGPoint(x: frame.midX, y: frame.maxY - 79))
        let bottom = AnswerFacade(answer: answers[1], size: CGSize(width: frame.width, height: 30), position: CGPoint(x: frame.midX, y: frame.minY + 15))
        let left = AnswerFacade(answer: answers[2], size: CGSize(width: frame.height - 126, height: 30), position: CGPoint(x: frame.minX + 15, y: frame.midY - 32), rotationDegrees: 90)
        let right = AnswerFacade(answer: answers[3], size: CGSize(width: frame.height - 126, height: 30), position: CGPoint(x: frame.maxX - 15, y: frame.midY - 32), rotationDegrees: -90)
        answerFacades = [left, right, top, bottom]
        for facade in answerFacades {
            addChild(facade.container)
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
    
    func didBegin(_ contact: SKPhysicsContact) {
        let bodyA = contact.bodyA.node?.physicsBody
        let bodyB = contact.bodyB.node?.physicsBody
        if (isElementOnAnswer(bodyA?.categoryBitMask, bodyB?.categoryBitMask)) {
            resolveAnswer(bodyA: bodyA, bodyB: bodyB)
        }
    }
    
    private func resolveAnswer(bodyA: SKPhysicsBody?, bodyB: SKPhysicsBody?) {
        [bodyA, bodyB].forEach({ setNodeToFall(physicsBody: $0) })
        model.answeredCount += 1
        let answerFacade = getFacade(nodeA: bodyA?.node, nodeB: bodyB?.node, facades: answerFacades)
        let elementFacade = getFacade(nodeA: bodyA?.node, nodeB: bodyB?.node, facades: elementFacades)
        let matches = Element.Property.hasMatchingPropertyValue(for: elementFacade.element, and: answerFacade.answer.property, matches: answerFacade.answer.value)
        let redGreen: (CGFloat, CGFloat) = matches ? (0, 255) : (255, 0)
        answerFacade.container.fillColor = UIColor.createTranslucent(red: redGreen.0, green: redGreen.1, blue: 0)
        newRoundOrEndGame(matches: matches)
    }
    
    private func newRoundOrEndGame(matches: Bool) {
        if matches {
            model.correctAnswerCount += 1
            model.currentPlayer!.adjustScore(model.correctAnswerCount * 10)
        } else if model.isGameOverOnDeductLife() {
            endGame()
        }
        if model.answeredCount == 4 {
            initQuizRound()
        } else {
            updateHud()
        }
    }
    
    private func endGame() {
        initQuizRound()
    }
    
    private func setNodeToFall(physicsBody: SKPhysicsBody?) {
        physicsBody?.categoryBitMask = fakeCategory
        physicsBody?.contactTestBitMask = fakeCategory
        physicsBody?.collisionBitMask = fakeCategory
        physicsBody?.affectedByGravity = true
        physicsBody?.allowsRotation = true
    }
    
    private func getNode(nodeA: SKNode?, nodeB: SKNode?, getAnswer: Bool) -> SKNode? {
        return nodeA?.name?.contains("E_") ?? false == getAnswer ? nodeB : nodeA
    }
    
    private func getFacade<T : SKElementHolderFacade>(nodeA: SKNode?, nodeB: SKNode?, facades: Array<T>) -> T {
        let answer = facades.first is AnswerFacade ? true : false
        let node = getNode(nodeA: nodeA, nodeB: nodeB, getAnswer: answer)
        
        return facades.first(where: { $0.getNode() == node} )!
    }
    
    private func isElementOnAnswer(_ maskA: UInt32?, _ maskB: UInt32?) -> Bool  {
        return (maskA == GameScene.elementCategory && maskB == GameScene.answerCategory) || (maskA == GameScene.answerCategory && maskB == GameScene.elementCategory)
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
        spinnerShape.position = CGPoint(x: frame.midX, y: frame.midY - 50)
        spinnerShape.strokeColor = spinnerColour
        spinnerShape.glowWidth = 1.0
        spinnerShape.fillColor = spinnerColour
        spinnerShape.name = "spinner"
        spinnerShape.physicsBody = SKPhysicsBody(circleOfRadius: 120)
        spinnerShape.physicsBody?.pinned = true
        spinnerShape.physicsBody?.affectedByGravity = false
        spinnerShape.physicsBody?.categoryBitMask = worldCategory
        spinnerShape.physicsBody?.collisionBitMask = worldCategory
        spinnerShape.physicsBody?.angularDamping = 0.25
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
        spinnerShape.addChild(middle)
        addChild(spinnerShape)
        addElements(spinnerShape, elements)
    }
    
    func addElements(_ spinnerShape: SKShapeNode, _ elements: [Element]) {
        for (index, element) in elements.enumerated() {
            let elementFacade = ElementFacade(element: element, startingPosition: CGPoint(x: points[index].0, y: points[index].1), index: index)
            elementFacades.append(elementFacade)
            spinnerShape.addChild(elementFacade.shape)
        }
    }
    
    override func update(_ currentTime: CFTimeInterval) {
        if touching {
            let dt: CGFloat = 1.0 / 20.0
            let spritePosition = sprite.position + spinnerShape!.position
            let distance = CGVector(dx: touchPoint.x - spritePosition.x, dy: touchPoint.y - spritePosition.y)
            let velocity = CGVector(dx: distance.dx/dt, dy: distance.dy/dt)
            sprite.physicsBody?.pinned = false
            sprite.physicsBody?.velocity = velocity
        }
        let allOut = elementFacades
            .reduce(true, { current, node in (current && !intersects(node.shape)) })
        if allOut && restart {
            model.answeredCount = 4
            restart = false
            newRoundOrEndGame(matches: false)
        }
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

