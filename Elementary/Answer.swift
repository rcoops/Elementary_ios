//
//  Answer.swift
//  Elementary
//
//  Created by Cooper Richard on 5/2/18.
//  Copyright © 2018 Rick Cooper. All rights reserved.
//

import Foundation

class Answer {
    let property: String
    let value: String
    let element: Element
    
    init(element: Element, property: String, value: String) {
        self.property = property
        self.value = value
        self.element = element
    }
    
}
