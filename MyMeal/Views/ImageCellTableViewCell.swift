//
//  ImageCellTableViewCell.swift
//  MyMeal
//
//  Created by Алексей Шпирко on 01/11/15.
//  Copyright © 2015 AlexShpirko LLC. All rights reserved.
//

import UIKit

class ImageCellTableViewCell: BaseTableViewCell {

    
    @IBOutlet weak var mainImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func updateWithItem(recipe:Recipe) {
        
        mainImageView.setImageFromUrl(recipe.imageURL.absoluteString, animated: true)
    }
    
}
