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
    
    private let cellIdentifier = "scoreIdentifier"
    
    private let model = (UIApplication.shared.delegate as! AppDelegate).appModel
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackground(#imageLiteral(resourceName: "game_background"))
        self.tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.highScores.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath as IndexPath) as! HighScoreTableCellView
        let highScores = model.highScores
        cell.avatarImageView.image = UIImage(named: highScores[indexPath.row].imageName)
        cell.nameLabel?.text = highScores[indexPath.row].name
        cell.scoreLabel?.text = String(highScores[indexPath.row].score)
        cell.avatarImageView.backgroundColor = UIColor.clear
        cell.nameLabel?.backgroundColor = UIColor.clear
        cell.scoreLabel?.backgroundColor = UIColor.clear
        cell.layer.backgroundColor = UIColor.clear.cgColor
        return cell
    }
    
}
