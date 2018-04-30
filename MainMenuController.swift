//
//  MainMenuController.swift
//  Elementary
//
//  Created by Cooper Richard on 4/30/18.
//  Copyright © 2018 Rick Cooper. All rights reserved.
//

import Foundation
import UIKit

class MainMenuController : UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    let avatars = [#imageLiteral(resourceName: "av_1"), #imageLiteral(resourceName: "av_2"), #imageLiteral(resourceName: "av_3"), #imageLiteral(resourceName: "av_4"), #imageLiteral(resourceName: "av_5"), #imageLiteral(resourceName: "av_6"), #imageLiteral(resourceName: "av_7")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackground()
    }
    
    private func setBackground() {
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = #imageLiteral(resourceName: "main_background")
        backgroundImage.contentMode =  UIViewContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 60
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return avatars.count
    }
    
    // MARK: UIPickerViewDelegate
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        let myView = UIView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: pickerView.bounds.width - 30, height: 60)))
        
        let myImageView = UIImageView(frame: CGRect(origin: CGPoint(x: myView.center.x - 25, y: 0), size: CGSize(width: 50, height: 50)))
        
        myImageView.image = avatars[row]
        myView.addSubview(myImageView)
        
        return myView
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        // do something with selected row
    }
    
}
