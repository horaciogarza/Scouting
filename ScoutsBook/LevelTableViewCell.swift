//
//  LevelTableViewCell.swift
//  
//
//  Created by Horacio Garza on 11/12/16.
//
//

import UIKit
import GTProgressBar

class LevelTableViewCell: UITableViewCell {
    
    @IBOutlet var levelProgressBar: GTProgressBar!
    @IBOutlet var levelImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
