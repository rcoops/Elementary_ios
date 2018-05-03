//
//  ElementFacade.swift
//  Elementary
//
//  Created by Cooper Richard on 5/3/18.
//  Copyright © 2018 Rick Cooper. All rights reserved.
//

import Foundation
import SpriteKit

class ElementFacade : SKElementHolderFacade {
    let element: Element
    let shape: SKShapeNode
    
    init(element: Element, startingPosition: CGPoint, index: Int) {
        self.element = element
        shape = SKShapeNode(circleOfRadius: 20)
        shape.fillColor = UIColor(element.hexColourCode)
        let name = SKLabelNode(fontNamed: "Chalkduster")
        name.text = element.chemicalSymbol
        name.fontSize = 20
        name.position = CGPoint(x: shape.frame.midX, y: shape.frame.midY - 6)
        name.name = "E_label_\(index)"
        name.fontColor = getTextColour(colour: shape.fillColor)
        shape.strokeColor = SKColor.black
        shape.glowWidth = 0.5
        shape.zPosition = 1
        shape.physicsBody = SKPhysicsBody(circleOfRadius: 20)
        shape.physicsBody?.affectedByGravity = false
        shape.physicsBody?.pinned = true
        shape.physicsBody?.categoryBitMask = GameScene.elementCategory
        shape.physicsBody?.contactTestBitMask = GameScene.answerCategory
        shape.physicsBody?.collisionBitMask = 0
        shape.name = "E_\(index)"
        shape.addChild(name)
        shape.position = startingPosition
    }
    
    func getNode() -> SKShapeNode {
        return shape
    }
    
    func getElement() -> Element {
        return element
    }
    
    // https://stackoverflow.com/questions/2509443/check-if-uicolor-is-dark-or-bright
    private func getTextColour(colour: UIColor) -> UIColor {
        let components = colour.cgColor.components!.map { $0 * 255 }
        let brightness = (components[0] * 299 + components[1] * 587 + components[2] * 114) / 1000
        return brightness > 125 ? UIColor.black : UIColor.white
    }
    
}
