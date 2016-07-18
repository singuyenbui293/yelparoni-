//
//  SortTableViewCell.swift
//  Yelp
//
//  Created by admin on 7/15/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit

@objc protocol selectedDelegate {
    optional func selectedCell(switchCell: SortTableViewCell, didChangeValue value: Bool)
}


class SortTableViewCell: UITableViewCell {

    @IBOutlet weak var filterLabel: UILabel!
    
    @IBOutlet weak var switchButton: UISwitch!
    
    
    @IBAction func switchButtonAction(sender: AnyObject) {
        delegate?.selectedCell!(self, didChangeValue: switchButton.on)
        
    }
    var delegate: selectedDelegate?
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
    }
    
    

}
