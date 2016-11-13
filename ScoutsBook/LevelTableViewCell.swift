//
//  LevelTableViewCell.swift
//  
//
//  Created by Horacio Garza on 11/12/16.
//
//

import UIKit
import GTProgressBar

enum ProgressLevel{
    case Low
    case Mid
    case Complete
}


class LevelTableViewCell: UITableViewCell {
    
    
    @IBOutlet var levelImage: UIImageView!
    var numberLevelProgress: Float = 0.0
    
    
    
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
        var progressBar = GTProgressBar(frame: CGRect(x: 5, y: self.layer.bounds.height - 5, width: 360, height: 15))
        
        
        progressBar.progress = CGFloat(self.numberLevelProgress)
        progressBar.barBorderColor = UIColor(red:0.35, green:0.80, blue:0.36, alpha:1.0)
        progressBar.barFillColor = UIColor(red:0.35, green:0.80, blue:0.36, alpha:1.0)
        progressBar.barBackgroundColor = UIColor(red:0.77, green:0.93, blue:0.78, alpha:1.0)
        progressBar.barBorderWidth = 0
        progressBar.barFillInset = 0
        progressBar.labelTextColor = UIColor(red:0.35, green:0.80, blue:0.36, alpha:1.0)
        
        progressBar.font = UIFont.boldSystemFont(ofSize: 18)
        progressBar.barMaxHeight = 12
        progressBar.displayLabel = false
        
        self.addSubview(progressBar)
        
    }
    
    override func awakeAfter(using aDecoder: NSCoder) -> Any? {
        <#code#>
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
