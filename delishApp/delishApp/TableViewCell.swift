//
//  TableViewCell.swift
//  RealmRecipes
//
//  Created by admin on 11/12/2016.
//  Copyright © 2016 Vik Nikolova. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var labelLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var recipeImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
