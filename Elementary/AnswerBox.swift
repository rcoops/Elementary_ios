//
//  AnswerBox.swift
//  Elementary
//
//  Created by Cooper Richard on 5/2/18.
//  Copyright © 2018 Rick Cooper. All rights reserved.
//

import Foundation
import SpriteKit

class AnswerBox {
    
    private let propertyLabel = SKLabelNode()
    private let valueLabel = SKLabelNode()
    private static let backgroundColour = SKColor(red: 255, green: 255, blue: 255, alpha: 0.75)
    
    let container: SKShapeNode
    
    init(size: CGSize, position: CGPoint, rotation: CGFloat = 0) {
        container = SKShapeNode(rectOf: size)
        container.position = position
        container.zRotation = rotation
        container.fillColor = AnswerBox.backgroundColour
        container.strokeColor = AnswerBox.backgroundColour
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initLabels(_ answer: Answer) {
        propertyLabel.fontSize = 20
        valueLabel.fontSize = 20
        propertyLabel.text = answer.property
        valueLabel.text = answer.value
        propertyLabel.fontColor = SKColor.black
        valueLabel.fontColor = SKColor.black
        propertyLabel.position = CGPoint(x: container.frame.midX - propertyLabel.frame.width, y: container.frame.midY / 2)
        
//        testRect(location: propertyLabel.position, size: propertyLabel.frame.size)
        
        valueLabel.horizontalAlignmentMode = .left
        let xPos = propertyLabel.position.x
        valueLabel.position = CGPoint(x: container.frame.midX, y: container.frame.midY - valueLabel.frame.maxY / 2)
//        self.addChild(propertyLabel)
//        self.addChild(valueLabel)
    }
    
    func testRect(location: CGPoint, size: CGSize) {
        var barra = SKShapeNode(rectOf: size)
        barra.name = "bar"
        barra.strokeColor = SKColor.black
        barra.fillColor = SKColor.clear
        barra.position = location
        
        container.addChild(barra)
    }
    
}
