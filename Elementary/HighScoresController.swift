//
//  HighScoresController.swift
//  Elementary
//
//  Created by Cooper Richard on 5/3/18.
//  Copyright © 2018 Rick Cooper. All rights reserved.
//

import Foundation
import UIKit

class HighScoresController : UITableViewController {
    
    let cellIdentifier = "scoreIdentifier"
    
    let model = (UIApplication.shared.delegate as! AppDelegate).appModel
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackground(#imageLiteral(resourceName: "game_background"))
    }
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.highScores.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath as IndexPath)
        let highScores = model.highScores
        cell.textLabel?.text = highScores[indexPath.row].name
        cell.textLabel?.backgroundColor = UIColor.clear
        cell.imageView?.image = UIImage(named: highScores[indexPath.row].imageName)
        cell.imageView?.backgroundColor = UIColor.clear
        cell.layer.backgroundColor = UIColor.clear.cgColor
        return cell
    }
    
}
