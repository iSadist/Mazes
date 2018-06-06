//
//  HighScoreCell.swift
//  Mazers
//
//  Created by Jan Svensson on 2018-06-06.
//  Copyright © 2018 Jan Svensson. All rights reserved.
//

import UIKit

class HighScoreCell: UITableViewCell {

    @IBOutlet weak var levelNumberLabel: UILabel!
    @IBOutlet weak var levelFastestTimeLabel: UILabel!
    @IBOutlet weak var timesDiedLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
