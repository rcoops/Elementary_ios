//
//  MainMenuController.swift
//  Elementary
//
//  Created by Cooper Richard on 4/30/18.
//  Copyright © 2018 Rick Cooper. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

class MainMenuController : UserDefaultsObservingController, UIPickerViewDataSource, UIPickerViewDelegate {
    private let avatarNames = (1...7).map { "av_\(String($0))" }
    private var selectedAvatarName = ""
    
    @IBOutlet weak var avatarPicker: UIPickerView!
    
    @IBOutlet weak var txtPlayerName: UITextField!
    
    private let clickSound = URL(fileURLWithPath: Bundle.main.path(forResource: "click", ofType: "wav")!)
    private var soundPlayer: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initSound()
        handlePopGesture()
        setBackground(#imageLiteral(resourceName: "main_background"))
        selectedAvatarName = avatarNames[avatarPicker.selectedRow(inComponent: 0)]
        txtPlayerName.becomeFirstResponder()
    }
    
    
    override internal func getMusicFileName() -> String {
        return "music_menu"
    }
    
    private func initSound() {
        do {
            try soundPlayer = AVAudioPlayer(contentsOf: clickSound)
        } catch {
            print("failed to initialise audio")
            print(error)
        }
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
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        let myView = UIView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: pickerView.bounds.width - 30, height: 60)))
        
        let myImageView = UIImageView(frame: CGRect(origin: CGPoint(x: myView.center.x - 25, y: 0), size: CGSize(width: 50, height: 50)))
        
        myImageView.image = UIImage(named: avatarNames[row])
        myView.addSubview(myImageView)
        
        return myView
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedAvatarName = avatarNames[row]
    }
    
    @IBAction func newGameAction(_ sender: Any) {
        soundPlayer?.play()
        if (isNameValid()) {
            appDelegate.appModel.initPlayer(name: txtPlayerName.text!, avatarName: selectedAvatarName) // txt must have content for name valid check
            musicPlaying = false
            self.performSegue(withIdentifier: "game", sender: self)
        } else {
            let action: ((UIAlertAction) -> Swift.Void) = { _ in self.txtPlayerName?.becomeFirstResponder() }
            alertWithTitle(title: "Player Name Empty", message: "You need a player name before starting silly!", ViewController: self, action: action)
        }
    }
    
    func isNameValid() -> Bool {
        return (txtPlayerName.text?.isEmpty ?? true) == false
    }
    
}
