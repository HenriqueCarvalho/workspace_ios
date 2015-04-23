//
//  RankTableViewController.m
//  HOC_project
//
//  Created by Henrique Carvalho on 2015-03-29.
//  Copyright (c) 2015 NIC. All rights reserved.
//

#import "RankTableViewController.h"

@interface RankTableViewController ()

@end

@implementation RankTableViewController

//NSString * playersArrayKey = @"AplayersArrayKey";

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.clearsSelectionOnViewWillAppear = NO;
    [self loadPlayersArray];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.playersArray.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    Player *playerObject = [self.playersArray objectAtIndex:indexPath.row];
    
    cell.textLabel.text = playerObject.name;
    NSString *stringRecord = [NSString stringWithFormat:@"%d", playerObject.record];
    cell.detailTextLabel.text = stringRecord;
    
    return cell;
}

- (void) loadPlayersArray
{
    NSData * playersArrayData = [[NSUserDefaults standardUserDefaults] objectForKey:@"AplayersArrayKey"];
    
    if (playersArrayData)
    {
        self.playersArray = [NSKeyedUnarchiver unarchiveObjectWithData:playersArrayData];
        [self.playersArray sortUsingSelector:@selector(compareRecords:)];
    }
    else
    {
        self.playersArray = [NSMutableArray array];
    }
}

@end
