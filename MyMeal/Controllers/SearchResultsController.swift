//
//  SearchResultsController.swift
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

class SearchResultsController: UIViewController {
    
    private var disposeBag = DisposeBag()
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let selectedResult: Observable<SearchResultViewModel> = tableView.rx_modelSelected().asObservable()
        
        let viewModel = SearchViewModel(
            searchText: textField.rx_text.asObservable(),
            selectedResult: selectedResult
        )
        
        viewModel.rows
            .bindTo(tableView.rx_itemsWithCellIdentifier("cell")) { (_, viewModel, cell: RecepiesCell) in
                cell.viewModel = viewModel
            }
            .addDisposableTo(disposeBag)
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    

    
}
