//
//  LoadingCell.swift
//  MyMeal
//
//  Created by Алексей Шпирко on 28/10/15.
//  Copyright © 2015 AlexShpirko LLC. All rights reserved.
//

import UIKit

class LoadingCell: UITableViewCell {

    @IBOutlet weak var activity: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
   
    override func prepareForReuse() {
        super.prepareForReuse()
        activity.startAnimating()
    }
  
    
}
