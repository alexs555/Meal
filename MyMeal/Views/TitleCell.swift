//
//  TitleCell.swift
//  MyMeal
//
//  Created by Алексей Шпирко on 01/11/15.
//  Copyright © 2015 AlexShpirko LLC. All rights reserved.
//

import UIKit

class TitleCell: BaseTableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    override func updateWithItem(item:Recipe) {
        
       titleLabel.text = item.title
    }
    
}
