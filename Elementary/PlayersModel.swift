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
        accessScores({ path in
            let data = try String(contentsOfFile: path, encoding: .utf8)
            let myLines = data.components(separatedBy: .newlines)
            for line in myLines {
                if !line.isEmpty {
                    let player = Player.fromCsvString(userStr: line)
                    players.append(player)
                }
            }
            sortPlayers() // Just to be sure
//            printPlayers()
        })
    }
    
    open func newScore(player: Player) {
        if (isHighScore(player)) {
            if players.count >= 10 {
                players.removeLast()
            }
            players.append(player)
            sortPlayers()
        }
    }
    
    open func isHighScore(_ player: Player) -> Bool {
        return player.score > (players.last?.score ?? -1)
    }
    
    open func writeToFile() {
        let fileName = "scores"
        let docDirUrl = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        
        let fileUrl = docDirUrl.appendingPathComponent(fileName).appendingPathExtension("csv")
        
        let outStr = players.map { $0.toCsvString() }.joined(separator: "\n")
        
        do {
            try outStr.write(to: fileUrl, atomically: true, encoding: String.Encoding.utf8)
        } catch let error as NSError {
            print("failed to write to URL")
            print(error)
        }
    }
    
    open func printPlayers() {
        for player in players {
            print(player.toCsvString())
        }
    }
    
    private func accessScores(_ action: (String) throws -> Void) {
        if let path = Bundle.main.path(forResource: "scores", ofType: "csv") {
            do {
                try action(path)
            } catch {
                print(error)
            }
        }
    }
    
    private func sortPlayers() {
        players.sort(by: { $0.score > $1.score })
    }
    
}
