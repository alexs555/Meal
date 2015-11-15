//
//  RecepiesCell.swift
//  MyMeal
//
//  Created by Алексей Шпирко on 24/10/15.
//  Copyright © 2015 AlexShpirko LLC. All rights reserved.
//

import UIKit

class RecepiesCell: UITableViewCell {

    @IBOutlet weak var starButton: UIButton!
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var publisherLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        starButton.setImage(UIImage(named:"star"), forState: UIControlState.Normal)
        starButton.setImage(UIImage(named:"star_selected"), forState: UIControlState.Selected)
        starButton.setImage(UIImage(named:"star_selected"), forState: UIControlState.Highlighted)
        // Initialization code
    }
    
    func addTarget(target:AnyObject, action:Selector) {
        starButton.addTarget(target, action: action, forControlEvents: UIControlEvents.TouchUpInside)
        
    }
 
    func updateWithRecipe(recipe:Recipe) {
        
        rankLabel.text = String(recipe.rank)
        titleLabel.text = recipe.title
        publisherLabel.text = recipe.publisher
        mainImageView.setImageFromUrl(recipe.imageURL.absoluteString, animated: true)
        starButton.selected = recipe.isFavorite
        contentView.bringSubviewToFront(starButton)
        
    }
    
    func setFavorite(isFavorite:Bool) {
        starButton.selected = isFavorite
    }
 
    internal override func prepareForReuse() {
        super.prepareForReuse()
        
        contentView.bringSubviewToFront(starButton)
        starButton.selected = false
        
    }


}
