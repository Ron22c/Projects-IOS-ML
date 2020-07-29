//
//  TableViewCell.swift
//  weather-message
//
//  Created by Ranajit Chandra on 24/02/20.
//  Copyright © 2020 Ranajit Chandra. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet var message: UILabel!
    @IBOutlet var username: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
