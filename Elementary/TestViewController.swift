//
//  TestViewController.swift
//  Elementary
//
//  Created by Cooper Richard on 4/30/18.
//  Copyright © 2018 Rick Cooper. All rights reserved.
//

import Foundation
import UIKit

class TestViewController : UIViewController {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func testButtonPushed(_ sender: Any) {
        let appModel = appDelegate.appModel
        appModel.newScore(player: Player(name: "ted", imageName: "av_4", score: 1000))
        appModel.writeToFile()
        appModel.printHighScores()
    }
    
}
