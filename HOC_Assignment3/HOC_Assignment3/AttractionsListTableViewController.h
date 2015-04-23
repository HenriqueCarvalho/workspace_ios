//
//  AttractionsListTableViewController.h
//  HOC_Assignment3
//
//  Created by Henrique Carvalho on 2015-02-03.
//  Copyright (c) 2015 Student. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Attraction, AttractionDetailsViewController;
@interface AttractionsListTableViewController : UITableViewController

@property (nonatomic, strong) NSMutableDictionary * attractionsDictionary;
@property (nonatomic, strong) NSMutableArray * firstLettersArray;
@property (nonatomic, strong) AttractionDetailsViewController * attractionInfoViewController;

- (void) addNewAttraction:(Attraction *)attractionObject;
- (void) saveAttractionsDictionary;
- (void) loadAttractionsDictionary;
- (void) deleteAttractionAtIndexPath:(NSIndexPath *)indexPath;
- (void) updateAttractionObject:(Attraction *)attractionObject atIndexPath:(NSIndexPath *)indexPath;

// button plus
- (IBAction) addAttractionTouched:(id)sender;

@end
