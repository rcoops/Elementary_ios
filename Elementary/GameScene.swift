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
    
    private var gameManager: GameManager?
    private let model = (UIApplication.shared.delegate as! AppDelegate).appModel
    
    private var touchPoint: CGPoint = CGPoint()
    private let elementStartingPoints = [(-75, 0), (-52, 52), (0, 75), (52, 52), (75, 0), (52, -52), (0, -75), (-52, -52)]
    
    private var startingAngle: CGFloat? = 0
    private var startingTime: TimeInterval? = 0
    private var touching: Bool = false
    private var restart = true
    
    private let arrow = SKSpriteNode(imageNamed: "arrow-2.png")
    private let lives = SKLabelNode(fontNamed: "AvenirNext-Bold")
    private let score = SKLabelNode(fontNamed: "AvenirNext-Bold")
    private var spinnerShape: SpinnerShapeNode?
    private var sprite: SKNode!
    
    private var answerFacades = [AnswerFacade]()
    private var elementFacades = [ElementFacade]()
    
    static let elementCategory: UInt32 = 0x1 << 1;
    static let answerCategory: UInt32 = 0x1 << 2;
    static let worldCategory: UInt32 = 0x1 << 4;
    private let fallingCategory: UInt32 = 0x1 << 5;
    
    private let soundCorrect = SKAction.playSoundFileNamed("positive.wav", waitForCompletion: false)
    private let soundIncorrect = SKAction.playSoundFileNamed("negative.wav", waitForCompletion: false)
    private let soundGameOver = SKAction.playSoundFileNamed("game_over.wav", waitForCompletion: false)
    
    override func didMove(to view: SKView) {
        initQuizRound()
        physicsWorld.gravity = CGVector(dx: 0.0, dy: -9.8);
        physicsWorld.contactDelegate = self
        initInstructions()
    }
    
    private func initBackground() {
        let background = SKSpriteNode(imageNamed: "game_background")
        background.position = CGPoint(x: frame.midX, y: frame.midY)
        background.size = CGSize(width: frame.size.width, height: frame.size.height)
        addChild(background)
    }
    
    private func initElementSpinner(elements: [Element]){
        spinnerShape = SpinnerShapeNode(circleOfRadius: 120, position: CGPoint(x: frame.midX, y: frame.midY - 50), name: "spinner")
        addChild(spinnerShape!)
        initElements(spinnerShape!, elements)
    }
    
    private func initInstructions() {
        func reverseRotation(_ rotation: CGFloat) -> CGFloat {
            return rotation > 0 ? -rotation : rotation
        }
        arrow.alpha = 0.6
        addChild(arrow)
        // curve round spinner
        let arrowPath = UIBezierPath(arcCenter: spinnerShape!.position, radius: 140, startAngle: CGFloat(345).toRadians(), endAngle: CGFloat(-15).toRadians(), clockwise: false)
        arrowPath.move(to: spinnerShape!.position)
        let rotate = SKAction.rotate(byAngle: CGFloat(90).toRadians(), duration: 0)
        let arc = SKAction.follow(arrowPath.cgPath, speed: 600)
        let rotate2 = SKAction.rotate(byAngle: reverseRotation(arrow.zRotation), duration: 0)
        let teleport2 = SKAction.move(to: CGPoint(x: frame.midX, y: frame.midY + 60), duration: 0)
        let line = SKAction.move(to: CGPoint(x: frame.midX, y: frame.maxY + 80), duration: 1)
        let teleport = SKAction.move(to: CGPoint(x: 0, y: 0), duration: 0)
        arrow.run(SKAction.repeatForever(SKAction.sequence([rotate, arc, rotate2, teleport2, line, teleport])))
        // Remove arrow child asynchronously after 6 seconds (async so screen wont pause)
        let action: ((UIAlertAction) -> Swift.Void) = { _ in
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(6), execute: {
                self.arrow.removeAllActions()
                self.removeChildren(in: [self.arrow])
            })
        }
        gameManager?.showPopup(title: "Instructions", message: "The game is easy! Rotate the spinner to position the element, then flick it into the property you think matches!", action)
    }
    
    func setGameManager(_ gameManager: GameManager) {
        self.gameManager = gameManager
    }
    
    private func initHudLabel(label: SKLabelNode, position: CGPoint) {
        label.fontColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
        label.fontSize = 30
        label.position = CGPoint(x: position.x, y: (position.y - label.frame.height) / 2)
    }
    
    private func initQuizRound() {
        model.resetAnswerCount()
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
        scoreImage.position = CGPoint(x: 220, y: 40 + scoreImage.frame.height / 2)
        addChild(scoreImage)
        initHudLabel(label: lives, position: CGPoint(x: 100, y: 55 + avatar.frame.height))
        initHudLabel(label: score, position: CGPoint(x: 260, y: 55 + scoreImage.frame.height))
        addChild(lives)
        addChild(score)
        updateHud()
    }
    
    private func initAnswers(answers: [Answer]) {
        let top = AnswerFacade(answer: answers[0], size: CGSize(width: frame.width, height: 30), position: CGPoint(x: frame.midX, y: frame.maxY - 79))
        let bottom = AnswerFacade(answer: answers[1], size: CGSize(width: frame.width, height: 30), position: CGPoint(x: frame.midX, y: frame.minY + 15))
        let left = AnswerFacade(answer: answers[2], size: CGSize(width: frame.height - 126, height: 30), position: CGPoint(x: frame.minX + 15, y: frame.midY - 32), rotationDegrees: 90)
        let right = AnswerFacade(answer: answers[3], size: CGSize(width: frame.height - 126, height: 30), position: CGPoint(x: frame.maxX - 15, y: frame.midY - 32), rotationDegrees: -90)
        answerFacades = [left, right, top, bottom]
        for facade in answerFacades {
            addChild(facade.getNode())
        }
    }
    
    private func initElements(_ spinnerShape: SKShapeNode, _ elements: [Element]) {
        for (index, element) in elements.enumerated() {
            let startingPosition = CGPoint(x: elementStartingPoints[index].0, y: elementStartingPoints[index].1)
            let elementFacade = ElementFacade(element: element, startingPosition: startingPosition, index: index)
            elementFacades.append(elementFacade)
            spinnerShape.addChild(elementFacade.getNode())
        }
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
            let adjustment = deltaAngle > 0 ? 2.0 : -2.0
            deltaAngle = deltaAngle + CGFloat.pi * CGFloat(adjustment)
        }
        let dt = CGFloat(timestamp - startingTime!)
        let velocity = deltaAngle / dt
        node.physicsBody?.angularVelocity = velocity
        
        startingAngle = angle
        startingTime = timestamp
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        startingAngle = 0
        startingTime = 0
        touching = false
    }
    
    override func update(_ currentTime: CFTimeInterval) {
        if touching {
            let dt: CGFloat = 1.0 / 10.0
            let spritePosition = calculateRotatedGlobalPosition()
            let distance = CGVector(dx: touchPoint.x - spritePosition.x, dy: touchPoint.y - spritePosition.y)
            let velocity = CGVector(dx: distance.dx / dt, dy: distance.dy / dt)
            sprite.physicsBody?.pinned = false
            sprite.physicsBody?.velocity = velocity
        }
        let allOut = elementFacades
            .reduce(true, { current, node in (current && !intersects(node.getNode())) })
        if allOut && restart {
            model.answeredCount = 4
            restart = false
            updateModel(isCorrect: false)
        }
    }
    
    private func calculateRotatedGlobalPosition() -> CGPoint {
        let rotatedLocalPosition = sprite.position.toRotatedPosition(rotationInRadians: spinnerShape!.zRotation)
        return rotatedLocalPosition + spinnerShape!.position
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        let bodyA = contact.bodyA.node?.physicsBody
        let bodyB = contact.bodyB.node?.physicsBody
        if (isElementOnAnswer(bodyA?.categoryBitMask, bodyB?.categoryBitMask)) {
            resolveAnswer(bodyA: bodyA, bodyB: bodyB)
        }
    }
    
    private func resolveAnswer(bodyA: SKPhysicsBody?, bodyB: SKPhysicsBody?) {
        [bodyA, bodyB].forEach({ setFalling(physicsBody: $0) })
        let answerFacade = getFacade(nodeA: bodyA?.node, nodeB: bodyB?.node, facades: answerFacades)
        let elementFacade = getFacade(nodeA: bodyA?.node, nodeB: bodyB?.node, facades: elementFacades)
        let isCorrect = Element.Property.isMatching(property: answerFacade.answer.property, ofElement: elementFacade.element, hasValue: answerFacade.answer.value)
        performActionsOnAnswer(isCorrect: isCorrect, answerBox: answerFacade.getNode())
    }
    
    private func performActionsOnAnswer(isCorrect: Bool, answerBox: SKShapeNode) {
        playAnswerSound(isCorrect: isCorrect)
        colourInHitAnswerBox(isCorrect: isCorrect, answerBox: answerBox)
        updateModel(isCorrect: isCorrect)
    }
    
    private func colourInHitAnswerBox(isCorrect: Bool, answerBox: SKShapeNode) {
        let redGreen: (CGFloat, CGFloat) = isCorrect ? (0, 255) : (255, 0)
        answerBox.fillColor = UIColor.createTranslucent(red: redGreen.0, green: redGreen.1, blue: 0)
    }
    
    private func updateModel(isCorrect: Bool) {
        model.answeredCount += 1
        if isCorrect {
            model.onCorrectAnswer()
        } else if model.isGameOverOnDeductLife() {
            endGame()
        }
        if model.answeredCount == 4 {
            endRound()
        } else {
            continueRound(isCorrect: isCorrect)
        }
    }
    
    private func continueRound(isCorrect: Bool) {
        let title = isCorrect ? "Correct!" : "Wrong!"
        let message = isCorrect ? "Have another \(String(model.correctAnswerCount * 10)) points!" : "No points =/"
        gameManager?.showPopup(title: title, message: message, nil)
        updateHud()
    }
    
    private func endRound() {
        let goodScore = model.isGoodScore()
        let messagePrefix = goodScore ? "Well done!" : "Uh Oh,"
        gameManager?.showPopup(title: "Round End", message: "\(messagePrefix) You got \(goodScore ? "" : "only ")\(String(model.correctAnswerCount)) answers correct", nil)
        initQuizRound()
    }
    
    private func endGame() {
        model.newScore()
        run(soundGameOver)
        gameManager?.endGame()
    }
    
    private func setFalling(physicsBody: SKPhysicsBody?) {
        physicsBody?.categoryBitMask = fallingCategory
        physicsBody?.contactTestBitMask = fallingCategory
        physicsBody?.collisionBitMask = fallingCategory
        physicsBody?.affectedByGravity = true
        physicsBody?.allowsRotation = true
    }
    
    private func getNode(nodeA: SKNode?, nodeB: SKNode?, getAnswer: Bool) -> SKNode? {
        return nodeA?.name?.contains("E_") ?? false == getAnswer ? nodeB : nodeA
    }
    
    private func getFacade<T : SKNodeFacade>(nodeA: SKNode?, nodeB: SKNode?, facades: Array<T>) -> T {
        let answer = facades.first is AnswerFacade ? true : false
        let node = getNode(nodeA: nodeA, nodeB: nodeB, getAnswer: answer)
        
        return facades.first(where: { $0.getNode() == node} )!
    }
    
    private func isElementOnAnswer(_ maskA: UInt32?, _ maskB: UInt32?) -> Bool  {
        return (maskA == GameScene.elementCategory && maskB == GameScene.answerCategory) || (maskA == GameScene.answerCategory && maskB == GameScene.elementCategory)
    }
    
    private func updateHud() {
        lives.text = String(model.currentPlayer!.lives)
        score.text = String(model.currentPlayer!.score)
    }
    
    private func playAnswerSound(isCorrect: Bool) {
        run(isCorrect ? soundCorrect : soundIncorrect)
    }
    
}

