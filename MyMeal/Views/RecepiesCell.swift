//
//  RecepiesCell.swift
//  MyMeal
//
//  Created by Алексей Шпирко on 24/10/15.
//  Copyright © 2015 AlexShpirko LLC. All rights reserved.
//

import UIKit

class RecepiesCell: UITableViewCell {

    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var publisherLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func updateWithRecipe(recipe:Recipe) {
        
        rankLabel.text = String(recipe.rank!)
        titleLabel.text = recipe.title
        publisherLabel.text = recipe.publisher
        mainImageView.setImageFromUrl(recipe.imageURL!.absoluteString, animated: true)
        
    }
 
    internal override func prepareForReuse() {
        super.prepareForReuse()
        
    }


}
