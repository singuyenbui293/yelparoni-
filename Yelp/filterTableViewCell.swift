//
//  filterTableViewCell.swift
//  Yelp
//
//  Created by admin on 7/13/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit

@objc protocol SwitchCellDelegate {
    optional func switchCell(switchCell: filterTableViewCell, didChangeValue value: Bool)
}

class filterTableViewCell: UITableViewCell {

    @IBOutlet weak var categoryLabel: UILabel!
    
    @IBOutlet weak var switchButton: UISwitch!
    
       
    weak var delegate: SwitchCellDelegate?
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
              // Initialization code
    }
    
    @IBAction func onSwitchChanged(sender: AnyObject) {
        delegate?.switchCell?(self, didChangeValue: switchButton.on)

    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
