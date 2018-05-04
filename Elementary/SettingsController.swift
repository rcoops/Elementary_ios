//
//  SettingsController.swift
//  Elementary
//
//  Created by Cooper Richard on 5/4/18.
//  Copyright © 2018 Rick Cooper. All rights reserved.
//

import Foundation
import UIKit
import MediaPlayer

class SettingsController : UIViewController {
    @IBOutlet weak var volumeLabel: UILabel!
    
    @IBOutlet weak var volumeSlider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func switchAction(_ sender: UISwitch) {
        UserDefaults.standard.set(sender.isOn, forKey: "musicToggle")
        volumeSlider.isEnabled = sender.isOn
        volumeLabel.textColor = sender.isOn ? UIColor.black : UIColor.gray
    }
    
    @IBAction func sliderAction(_ sender: UISlider) {
        UserDefaults.standard.set(sender.value, forKey: "volume")
    }
    
}
