//
//  Players.swift
//  Elementary
//
//  Created by Cooper Richard on 4/30/18.
//  Copyright © 2018 Rick Cooper. All rights reserved.
//

import Foundation

class PlayersModel {
    
    var players = [Player]()
    
    init() {
        if let path = Bundle.main.path(forResource: "scores", ofType: "csv") {
            do {
                let data = try String(contentsOfFile: path, encoding: .utf8)
                let myLines = data.components(separatedBy: .newlines)
                for line in myLines {
                    if !line.isEmpty {
                        let player = Player.fromCsvString(userStr: line)
                        print(player.toCsvString())
                        players.append(player)
                    }
                }
            } catch {
                print(error)
            }
        }
    }
    
}
