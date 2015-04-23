//
//  AttractionsTableViewController.h
//  HOC_Assignment4
//
//  Created by Henrique Carvalho on 2015-02-08.
//  Copyright (c) 2015 Student. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Attraction, AttractionDetailsViewController;
@interface AttractionsTableViewController : UITableViewController

// variables
@property (nonatomic, strong) NSMutableDictionary * attractionsDictionary;
@property (nonatomic, strong) NSMutableArray * twoFirstLettersArray;
@property (nonatomic, strong) AttractionDetailsViewController * attractionInfoViewController;

// fuction
- (void) addNewAttraction:(Attraction *)attractionObject;
- (void) saveAttractionsDictionary;
- (void) loadAttractionsDictionary;
- (void) updateAttractionObject:(Attraction *)attractionObject atIndexPath:(NSIndexPath *)indexPath;
- (void) deleteAttractionAtIndexPath:(NSIndexPath *)indexPath;

// button function
- (IBAction) addAttractionTouched:(id)sender;

@end
