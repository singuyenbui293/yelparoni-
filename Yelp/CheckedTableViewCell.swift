//
//  CheckedTableViewCell.swift
//  Yelp
//
//  Created by admin on 7/16/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit

class CheckedTableViewCell: UITableViewCell {

    @IBOutlet weak var CheckedLabel: UILabel!
    
    
    @IBOutlet weak var checkedImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        checkedImageView.hidden = true
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
