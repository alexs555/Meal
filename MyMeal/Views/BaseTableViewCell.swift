//
//  BaseTableViewCell.swift
//  MyMeal
//
//  Created by Алексей Шпирко on 01/11/15.
//  Copyright © 2015 AlexShpirko LLC. All rights reserved.
//

import UIKit

class BaseTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateWithItem(item:Recipe) {
        
        //override in subclasses
    }

}
