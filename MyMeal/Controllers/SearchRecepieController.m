//
//  SearchRecepieController.m
//  MyMeal
//
//  Created by Алексей Шпирко on 17/10/15.
//  Copyright © 2015 AlexShpirko LLC. All rights reserved.
//

#import "SearchRecepieController.h"

@interface SearchRecepieController ()
@property (weak, nonatomic) IBOutlet UITextField *textField;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation SearchRecepieController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   // self.tableView.tableHeaderView = self.textField;
    
    // Do any additional setup after loading the view.
}



@end
