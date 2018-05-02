//
//  QuizQuestion.swift
//  Elementary
//
//  Created by Cooper Richard on 5/2/18.
//  Copyright © 2018 Rick Cooper. All rights reserved.
//

import Foundation

class QuizQuestion {
    let elements: [Element]
    let answers: [Answer]
    
    init() {
        let elements = Element.getRandomEight()
        self.elements = elements
        
        let chosenAnswerElementIndexes = Generator.generateRandomDistinctIndexes(max: elements.count)
        let propertyIndexes = Generator.generateRandomDistinctIndexes(max: 6)
        
        let answerElements = chosenAnswerElementIndexes.map { elements[$0] }
        let allProperties: Array<Element.Property> = Array(Element.Property.all())
        let chosenProperties: Array<Element.Property> = propertyIndexes.map { allProperties[$0] }
        answers = answerElements.enumerated().map { Element.getPropertyNameAndValue($1, chosenProperties[$0]) }
    }
    
    private class Generator {
        static func generateRandomDistinctIndexes(max: Int) -> Array<Int> {
            var randomIndexes = Set<Int>()
            while (randomIndexes.count < 4) {
                randomIndexes.insert(Int(arc4random_uniform(UInt32(max))))
            }
            return Array(randomIndexes)
        }
    }
    
}

/*
 public let fullName : String
 public let atomicNumber : Int
 public let atomicMass : Int
 public let naturalState : State
 public let bondingType : BondingType
 public let group : Group
 */
