//
//  BooksViewController.h
//  midterm
//
//  Created by Frank Lu on 2015-01-12.
//  Copyright (c) 2015 Frank Lu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BookDetailsViewController.h"
#import "Book.h"

@interface BooksViewController : UITableViewController<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView * tableView;
@property (strong, nonatomic) BookDetailsViewController * bookDetailsViewController;
@property (strong, nonatomic) NSMutableArray * booksArray;
- (IBAction) addBookButtonTouched:(id)sender;

@end
