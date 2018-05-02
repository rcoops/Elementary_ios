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
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let avatarNames = (1...7).map { "av_\(String($0))" }
    var selectedAvatarName = ""
    
    @IBOutlet weak var avatarPicker: UIPickerView!
    
    @IBOutlet weak var txtPlayerName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackground()
        for avatar in avatarPicker.subviews {
            avatar.alpha = 1.0
        }
        selectedAvatarName = avatarNames[avatarPicker.selectedRow(inComponent: 0)]
        txtPlayerName.becomeFirstResponder()
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
        return avatarNames.count
    }
    
    // MARK: UIPickerViewDelegate
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        let myView = UIView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: pickerView.bounds.width - 30, height: 60)))
        
        let myImageView = UIImageView(frame: CGRect(origin: CGPoint(x: myView.center.x - 25, y: 0), size: CGSize(width: 50, height: 50)))
        
        myImageView.image = UIImage(named: avatarNames[row])
        myView.addSubview(myImageView)
        
        return myView
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedAvatarName = avatarNames[row]
        // do something with selected row
    }
    
    @IBAction func newGameAction(_ sender: Any) {
        if (isNameValid()) {
            appDelegate.appModel.initPlayer(name: txtPlayerName.text!, avatarName: selectedAvatarName)
            self.performSegue(withIdentifier: "game", sender: self)
        } else {
            alertWithTitle(title: "Player Name Empty", message: "You need a player name before starting silly!", ViewController: self, toFocus: txtPlayerName)
        }
    }
    
    func isNameValid() -> Bool {
        return (txtPlayerName.text?.isEmpty ?? true) == false
    }
    
    func alertWithTitle(title: String!, message: String, ViewController: UIViewController, toFocus:UITextField) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel,handler: {_ in
            toFocus.becomeFirstResponder()
        });
        alert.addAction(action)
        ViewController.present(alert, animated: true, completion:nil)
    }
    
}
