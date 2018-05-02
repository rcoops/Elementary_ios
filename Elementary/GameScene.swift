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
    
    let elementRelativePositionFromRadius = 80
    let points = [(-75, 0), (-52, 52), (0, 75), (52, 52), (75, 0), (52, -52), (0, -75), (-52, -52)]
    let names = ["1","2","3","4","5","6","7","8"]
    let rotateRec = UIRotationGestureRecognizer()
    var elementSpinner: SKShapeNode?
    
    override func didMove(to view: SKView) {
        setBackground()
        setElementSpinner()
    }
    
    private func setBackground() {
        let background = SKSpriteNode(imageNamed: "game_background")
        background.position = CGPoint(x: frame.midX, y: frame.midY)
        background.size = CGSize(width: frame.size.width, height: frame.size.height)
        addChild(background)
    }
    
    // https://stackoverflow.com/questions/26727774/how-to-draw-a-elementSpinner-in-swift-using-spritekit
    private func setElementSpinner(){
        let elementSpinner = SKShapeNode(circleOfRadius: 100)
        self.elementSpinner = elementSpinner
        elementSpinner.position = CGPoint(x: frame.midX, y: frame.midY)
        let spinnerColour = UIColor(red: 255.0, green: 255.0, blue: 255.0, alpha: 0.5)
        elementSpinner.strokeColor = spinnerColour
        elementSpinner.glowWidth = 1.0
        elementSpinner.fillColor = spinnerColour
        self.addChild(elementSpinner)
        let elements = Element.getRandomEight()
        addElements(elementSpinner, elements)
        rotateRec.addTarget(self, action: #selector (GameScene.rotatedView (_:) ))
        self.view!.addGestureRecognizer(rotateRec)
    }
    
    func addElements(_ elementSpinner: SKShapeNode, _ elements: [Element]) {
        for (index, element) in elements.enumerated() {
            let circle = SKShapeNode(circleOfRadius: 100)
            let name = SKLabelNode(fontNamed: "Chalkduster")
            name.text = element.chemicalSymbol
            name.fontSize = 100
            name.position = CGPoint(x: circle.frame.midX, y: circle.frame.midY - 30)
            circle.strokeColor = SKColor.black
            circle.glowWidth = 0.5
            circle.xScale = 0.20
            circle.yScale = 0.20
            circle.fillColor = UIColor(element.hexColourCode)
            circle.zPosition = 1
            circle.addChild(name)
            elementSpinner.addChild(circle)
            circle.position = CGPoint(x: points[index].0, y: points[index].1)
        }
    }
    
    func rotatedView(_ sender:UIRotationGestureRecognizer) {
        if (sender.state == .began) {
            print("rotation began")
        }
        if (sender.state == .changed) {
            
            print("rotation changed")
            let oneRevolution = SKAction.rotate(byAngle: 360, duration: 100.0)
            let `repeat` = SKAction.repeatForever(oneRevolution)
            elementSpinner?.run(`repeat`)
            //you could easily make any sprite's rotation equal this amount like so...
            //thePlayer.zRotation = -sender.rotation
            
            //convert rotation to degrees...
            let rotateAmount = Measurement(value: Double(sender.rotation), unit: UnitAngle.radians).converted(to: .degrees).value
            print("\(rotateAmount) degreess" )
        }
        if (sender.state == .ended) {
            print("rotation ended")
        }
    }
    
    // child rotation
    //https://stackoverflow.com/questions/27571794/how-to-rotate-parent-skspritenode-only-and-not-the-child-node
    
    
    // User Defaults
    // NSKeyedArchiver
    // bounce once then fall off screen
    //https://www.smashingmagazine.com/2016/11/how-to-build-a-spritekit-game-in-swift-3-part-1/
}

