//
//  RankTableViewController.h
//  HOC_project
//
//  Created by Henrique Carvalho on 2015-03-29.
//  Copyright (c) 2015 NIC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GameViewController.h"
#import "Player.h"

@interface RankTableViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) Player * playerObject;
@property (strong, nonatomic) IBOutlet UITableView * tableView;
@property (strong, nonatomic) NSMutableArray * playersArray;

@end
