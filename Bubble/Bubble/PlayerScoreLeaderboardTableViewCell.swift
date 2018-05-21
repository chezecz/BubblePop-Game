//
//  PlayerScoreLeaderboardTableViewCell.swift
//  Bubble
//
//  Created by Andrey Maslennikov on 30/4/18.
//  Copyright © 2018 Andrey Maslennikov. All rights reserved.
//

import UIKit

class PlayerScoreLeaderboardTableViewCell: UITableViewCell {

    @IBOutlet weak var playerName: UILabel!
    @IBOutlet weak var playerScore: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
