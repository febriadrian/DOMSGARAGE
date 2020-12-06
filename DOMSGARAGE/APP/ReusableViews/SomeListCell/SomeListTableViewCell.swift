//
//  SomeListTableViewCell.swift
//  DOMSGARAGE
//
//  Created by Febri Adrian on 20/11/20.
//  Copyright © 2020 Febri Adrian. All rights reserved.
//

import UIKit

class SomeListTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
