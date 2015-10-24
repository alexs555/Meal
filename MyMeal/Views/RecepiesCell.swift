//
//  RecepiesCell.swift
//  MyMeal
//
//  Created by Алексей Шпирко on 24/10/15.
//  Copyright © 2015 AlexShpirko LLC. All rights reserved.
//

import UIKit
#if !RX_NO_MODULE
    import RxSwift
    import RxCocoa
#endif

class RecepiesCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    var disposeBag: DisposeBag!
    
    //let imageService = DefaultImageService.sharedImageService
    
    /*override func awakeFromNib() {
        super.awakeFromNib()
        
        self.imagesOutlet.registerNib(UINib(nibName: "WikipediaImageCell", bundle: nil), forCellWithReuseIdentifier: "ImageCell")
    }*/
    
    var viewModel: SearchResultViewModel! {
        didSet {
            let disposeBag = DisposeBag()
            
            (viewModel?.title ?? just(""))
                .subscribe(self.titleLabel.rx_text)
                .addDisposableTo(disposeBag)
            
            //self.URLOutlet.text = viewModel.searchResult.URL.absoluteString ?? ""
            
            /*viewModel.imageURLs
                .bindTo(self.imagesOutlet.rx_itemsWithCellIdentifier("ImageCell")) { [unowned self] (_, URL, cell: CollectionViewImageCell) in
                    let loadingPlaceholder: UIImage? = nil
                    
                    cell.image = self.imageService.imageFromURL(URL)
                        .map { $0 as UIImage? }
                        .catchErrorJustReturn(nil)
                        .startWith(loadingPlaceholder)
                }
                .addDisposableTo(disposeBag)*/
            
            self.disposeBag = disposeBag
        }
    }
    
    internal override func prepareForReuse() {
        super.prepareForReuse()
        
        self.disposeBag = nil
    }


}
