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
    var answerFacades = [AnswerFacade]()
    var elementFacades = [ElementFacade]()
    
    static let elementCategory:UInt32 = 0x1 << 0;
    static let answerCategory:UInt32 = 0x1 << 3;
    let spinnerCategory:UInt32 = 0x1 << 1;
    let spinnerMiddleCategory:UInt32 = 0x1 << 2;
    let collidesWithElementCategory:UInt32 = 0x1 << 8;
    let doesNotCollideWithElementCategory:UInt32 = 0x1 << 9;
    
    override func didMove(to view: SKView) {
        initQuizRound()
        physicsWorld.gravity = CGVector(dx: 0.0, dy: -9.8);
        physicsWorld.contactDelegate = self
    }
    
    private func initQuizRound() {
        removeAllChildren()
        initBackground()
        let quizQuestion = model.initQuizQuestion()
        initElementSpinner(elements: quizQuestion.elements)
        initAnswers(answers: quizQuestion.answers)
    }
    
    private func initAnswers(answers: [Answer]) {
        let top = AnswerFacade(answer: answers[0], size: CGSize(width: frame.width, height: 30), position: CGPoint(x: frame.midX, y: frame.maxY - 79))
        setRecanglularPhysicsBody(for: top.container)
        let bottom = AnswerFacade(answer: answers[1], size: CGSize(width: frame.width, height: 30), position: CGPoint(x: frame.midX, y: frame.minY + 15))
        setRecanglularPhysicsBody(for: bottom.container)
        let left = AnswerFacade(answer: answers[2], size: CGSize(width: frame.height - 126, height: 30), position: CGPoint(x: frame.minX + 15, y: frame.midY - 32), rotationDegrees: 90)
        setRecanglularPhysicsBody(for: left.container, rotated: true)
        let right = AnswerFacade(answer: answers[3], size: CGSize(width: frame.height - 126, height: 30), position: CGPoint(x: frame.maxX - 15, y: frame.midY - 32), rotationDegrees: -90)
        setRecanglularPhysicsBody(for: right.container, rotated: true)
        answerFacades = [left, right, top, bottom]
        for box in answerFacades {
            addChild(box.container)
            box.container.physicsBody?.affectedByGravity = false
            box.container.physicsBody?.pinned = true
            box.container.physicsBody?.categoryBitMask = GameScene.answerCategory
        }
    }
    
    private func setRecanglularPhysicsBody(for node: SKNode, rotated: Bool = false) {
        let width = rotated ? node.frame.height : node.frame.width
        let height = rotated ? node.frame.width : node.frame.height
        node.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: width, height: height))
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
            [bodyA, bodyB].forEach({ setNodeToFall(physicsBody: $0) })
            let answerFacade = getFacade(nodeA: bodyA?.node, nodeB: bodyB?.node, facades: answerFacades)
            let elementFacade = getFacade(nodeA: bodyA?.node, nodeB: bodyB?.node, facades: elementFacades)
            let matches = Element.Property.hasMatchingPropertyValue(for: elementFacade.element, and: answerFacade.answer.value, matches: answerFacade.answer.property)
            let redGreen: (CGFloat, CGFloat) = matches ? (0, 255) : (255, 0)
            answerFacade.container.fillColor = UIColor(red: redGreen.0, green: redGreen.1, blue: 0, alpha: 0.75)
            
        }
    }
    
    private func setNodeToFall(physicsBody: SKPhysicsBody?) {
        physicsBody?.collisionBitMask = 0
        physicsBody?.categoryBitMask = 0
        physicsBody?.affectedByGravity = true
        physicsBody?.pinned = false
    }
    
    private func getNode(nodeA: SKNode?, nodeB: SKNode?, getAnswer: Bool) -> SKNode? {
        let nodeNameA = nodeA?.name
        let nodeNameB = nodeB?.name
        let elementIsNodeA = nodeA?.name?.contains("E_") ?? false
        return elementIsNodeA == getAnswer ? nodeB : nodeA
    }
    
    private func getFacade<T : SKElementHolderFacade>(nodeA: SKNode?, nodeB: SKNode?, facades: Array<T>) -> T {
        let answer = facades.first is AnswerFacade ? true : false
        let node = getNode(nodeA: nodeA, nodeB: nodeB, getAnswer: answer)
        
        return facades.first(where: { $0.getNode() == node} )!
    }
    
    private func getAnswerFacade(nodeA: SKNode?, nodeB: SKNode?) -> AnswerFacade {
        let node = getNode(nodeA: nodeA, nodeB: nodeB, getAnswer: true)
        return answerFacades.first(where: { $0.container == node} )!
    }
    
    private func getElementFacade(nodeA: SKNode?, nodeB: SKNode?) -> ElementFacade {
        let node = getNode(nodeA: nodeA, nodeB: nodeB, getAnswer: false)
        return elementFacades.first(where: { $0.shape == node} )!
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
        spinnerShape.physicsBody = SKPhysicsBody(circleOfRadius: 120)
        spinnerShape.position = CGPoint(x: frame.midX, y: frame.midY - 50)
        spinnerShape.physicsBody?.pinned = true
        spinnerShape.physicsBody?.affectedByGravity = false
        spinnerShape.physicsBody?.categoryBitMask = spinnerCategory
        spinnerShape.physicsBody?.angularDamping = 0.25
        spinnerShape.physicsBody?.collisionBitMask = doesNotCollideWithElementCategory
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
        middle.physicsBody?.categoryBitMask = spinnerMiddleCategory
        middle.physicsBody?.contactTestBitMask = GameScene.elementCategory
        spinnerShape.addChild(middle)
        addChild(spinnerShape)
        addElements(spinnerShape, elements)
    }
    
    func addElements(_ spinnerShape: SKShapeNode, _ elements: [Element]) {
        for (index, element) in elements.enumerated() {
            let elementFacade = ElementFacade(element: element, startingPosition: CGPoint(x: points[index].0, y: points[index].1), index: index)
            elementFacades.append(elementFacade)
            spinnerShape.addChild(elementFacade.shape)
//            let elementShape = SKShapeNode(circleOfRadius: 20)
//            elementShape.fillColor = UIColor(element.hexColourCode)
//            let name = SKLabelNode(fontNamed: "Chalkduster")
//            name.text = element.chemicalSymbol
//            name.fontSize = 20
//            name.position = CGPoint(x: elementShape.frame.midX, y: elementShape.frame.midY - 6)
//            name.name = "E_label_\(index)"
//            name.fontColor = getTextColour(colour: elementShape.fillColor)
//            elementShape.strokeColor = SKColor.black
//            elementShape.glowWidth = 0.5
//            elementShape.zPosition = 1
//            elementShape.physicsBody = SKPhysicsBody(circleOfRadius: 20)
//            elementShape.physicsBody?.affectedByGravity = false
//            elementShape.physicsBody?.pinned = true
//            elementShape.physicsBody?.categoryBitMask = elementCategory
//            elementShape.physicsBody?.contactTestBitMask = answerCategory
//            elementShape.physicsBody?.collisionBitMask = 0
//            elementShape.name = "E_\(index)"
//            elementShape.addChild(name)
//            elementShape.position = CGPoint(x: points[index].0, y: points[index].1)
//            spinnerShape.addChild(elementShape)
        }
    }
    
    override func update(_ currentTime: CFTimeInterval) {
        if touching {
            let dt: CGFloat = 1.0 / 2.0
            let spritePosition = sprite.position + spinnerShape!.position
            let distance = CGVector(dx: touchPoint.x - spritePosition.x, dy: touchPoint.y - spritePosition.y)
            let velocity = CGVector(dx: distance.dx/dt, dy: distance.dy/dt)
//            print("TouchPos: \(touchPoint), SpritePos: \(spritePosition)")
//            print("Velocity: \(velocity)")
            sprite.physicsBody?.pinned = false
            sprite.physicsBody!.velocity=velocity
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

