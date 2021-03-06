//
//  AttractionViewController.h
//  assn4
//
//  Created by Frank Lu on 2015-01-12.
//  Copyright (c) 2015 Frank Lu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Attraction.h"
#import "AttractionDetailsViewController.h"

@interface AttractionViewController : UITableViewController<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) AttractionDetailsViewController * attractionDetailsViewController;
@property (strong, nonatomic) NSMutableDictionary *attractionsDictionary;
@property (strong, nonatomic) NSMutableArray *provincesAbbArray;

@end
