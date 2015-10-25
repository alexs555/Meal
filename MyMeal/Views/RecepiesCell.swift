//
//  RecepiesCell.swift
//  MyMeal
//
//  Created by Алексей Шпирко on 24/10/15.
//  Copyright © 2015 AlexShpirko LLC. All rights reserved.
//

import UIKit

class RecepiesCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func updateWithRecipe(recipe:Recipe) {
        
        titleLabel.text = recipe.title
        
    }
 
    internal override func prepareForReuse() {
        super.prepareForReuse()
        
    }


}
