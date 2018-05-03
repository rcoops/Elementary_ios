//
//  HighScoresController.swift
//  Elementary
//
//  Created by Cooper Richard on 5/3/18.
//  Copyright © 2018 Rick Cooper. All rights reserved.
//

import Foundation
import UIKit

class HighScoresController : UIViewController {
    
    let model = (UIApplication.shared.delegate as! AppDelegate).appModel
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackground(#imageLiteral(resourceName: "game_background"))
    }
    
}
