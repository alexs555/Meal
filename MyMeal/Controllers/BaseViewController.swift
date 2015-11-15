//
//  BaseViewController.swift
//  MyMeal
//
//  Created by Алексей Шпирко on 25/10/15.
//  Copyright © 2015 AlexShpirko LLC. All rights reserved.
//

import UIKit
import StatefulViewController
import DZNEmptyDataSet

class BaseViewController: UIViewController, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureEmptyState()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func configureEmptyState() {
        tableView.emptyDataSetSource = self
        tableView.emptyDataSetDelegate = self
    }
   

    func setupViews() {
        
        // Setup placeholder views
        /*loadingView = LoadingView(frame: view.frame)
        emptyView = EmptyView(frame: view.frame)
        let failureView = ErrorView(frame: view.frame)
        failureView.tapGestureRecognizer.addTarget(self, action: Selector("refresh"))
        errorView = failureView*/
    }

}
