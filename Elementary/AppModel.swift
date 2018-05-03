//
//  Players.swift
//  Elementary
//
//  Created by Cooper Richard on 4/30/18.
//  Copyright © 2018 Rick Cooper. All rights reserved.
//

import Foundation
import UIKit

class AppModel {
    
    var currentPlayer: Player?
    var highScores = [Player]()
    var quizQuestion: QuizQuestion?
    var answeredCount = 0
    var correctAnswerCount = 0
    private let scoresFileName = "scores"
    private let scoresFileExtension = "csv"
    
    init() {
        readFile()
    }
    
    open func isGameOverOnDeductLife() -> Bool {
        currentPlayer?.lives -= 1
        return currentPlayer?.lives ?? 0 == 0
    }
    
    open func initQuizQuestion() -> QuizQuestion {
        quizQuestion = QuizQuestion()
        return quizQuestion!
    }
    
    open func initPlayer(name: String, avatarName: String) {
        currentPlayer = Player(name, avatarName)
    }
    
    open func adjustPlayerScore(scoreAdjustment: Int) {
        currentPlayer?.adjustScore(scoreAdjustment)
    }
    
    open func newScore(player: Player) {
        if (isHighScore(player)) {
            if highScores.count >= 10 {
                highScores.removeLast()
            }
            highScores.append(player)
            sortHighScores()
        }
    }
    
    open func isHighScore(_ player: Player) -> Bool {
        return player.score > (highScores.last?.score ?? -1)
    }
    
    open func writeToFile() {
        let fileUrl = Bundle.main.url(forResource: scoresFileName, withExtension: scoresFileExtension)!
        
        let outStr = highScores.map { $0.toCsvString() }.joined(separator: "\n")
        
        do {
            try outStr.write(to: fileUrl, atomically: true, encoding: String.Encoding.utf8)
        } catch {
            print("failed to write to file")
            print(error)
        }
    }
    
    open func printHighScores() {
        for score in highScores {
            print(score.toCsvString())
        }
    }
    
    private func readFile() {
        let path = Bundle.main.path(forResource: scoresFileName, ofType: scoresFileExtension)!
        do {
            let data = try String(contentsOfFile: path, encoding: .utf8)
            let myLines = data.components(separatedBy: .newlines)
            for line in myLines {
                if !line.isEmpty {
                    let player = Player.fromCsvString(userStr: line)
                    highScores.append(player)
                }
            }
            sortHighScores() // Just to be sure
            printHighScores()
        } catch {
            print("failed to read from file")
            print(error)
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
    
    private func sortHighScores() {
        highScores.sort(by: { $0.score > $1.score })
    }
    
}

