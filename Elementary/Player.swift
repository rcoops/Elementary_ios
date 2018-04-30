//
//  UserModel.swift
//  Elementary
//
//  Created by Cooper Richard on 4/30/18.
//  Copyright © 2018 Rick Cooper. All rights reserved.
//

import Foundation


class Player {
    
    var name: String
    var imageName: String
    var score: Int = 0
    
    init(name: String, imageName: String) {
        self.name = name
        self.imageName = imageName
    }
    
    convenience init(name: String, imageName: String, score: Int) {
        self.init(name: name, imageName: imageName)
        self.score = score
    }
    
    func toCsvString() -> String {
        return "\(name),\(imageName),\(String(score))\n"
    }
    
    static func fromCsvString(userStr: String) -> Player {
        let attributes = userStr.components(separatedBy: ",")
        return Player(name: attributes[0], imageName: attributes[1], score: Int(attributes[2])!)
    }
    
}
