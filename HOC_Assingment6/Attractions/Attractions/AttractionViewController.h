//
//  AttractionViewController.h
//  Attractions
//
//  Created by Henrique Carvalho on 2015-03-07.
//  Copyright (c) 2015 NIC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Attraction.h"
#import "AttractionDetailsViewController.h"

@interface AttractionViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView * tableView;
@property (strong, nonatomic) AttractionDetailsViewController * attractionDetailsViewController;
@property (strong, nonatomic) NSMutableDictionary * attractionsDictionary;
@property (strong, nonatomic) NSMutableArray * provincesAbbArray;

- (IBAction) addAttractionTouched:(id)sender;

@end
