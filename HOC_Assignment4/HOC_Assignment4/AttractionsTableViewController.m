//
//  AttractionsTableViewController.m
//  HOC_Assignment4
//
//  Created by Henrique Carvalho on 2015-02-08.
//  Copyright (c) 2015 Student. All rights reserved.
//

#import "AttractionsTableViewController.h"
#import "Attraction.h"
#import "AttractionDetailsViewController.h"

static NSString * attractionsDictionarytKey = @"AattractionsDictionarytKey";

@interface AttractionsTableViewController ()

@end

@implementation AttractionsTableViewController

- (id) initWithStyle:(UITableViewStyle)style
{
  self = [super initWithStyle:style];
  if (self)
  {
  }
  return self;
}

- (void) viewDidLoad
{
  [super viewDidLoad];
  [self loadAttractionsDictionary];

  self.navigationItem.rightBarButtonItem = self.editButtonItem;
  self.clearsSelectionOnViewWillAppear = NO;
}

- (void) viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];

  if (self.attractionInfoViewController)
  {
    NSIndexPath * selectedIndexPath = [self.tableView indexPathForSelectedRow];

    if (self.attractionInfoViewController.saveAttraction)
    {
      if (selectedIndexPath)
      {
        [self updateAttractionObject:self.attractionInfoViewController.attractionObject atIndexPath:selectedIndexPath];
        [self.tableView deselectRowAtIndexPath:selectedIndexPath animated:YES];
      }
      else
      {
        [self addNewAttraction:self.attractionInfoViewController.attractionObject];
      }
      [self.tableView reloadData];
    }
    else if (selectedIndexPath)
    {
      [self deleteAttractionAtIndexPath:selectedIndexPath];
    }

    self.attractionInfoViewController = nil;
  }
}

- (void) didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
}

- (void) addNewAttraction:(Attraction *)attractionObject
{
  NSString * attractionProvinceTwoFirstLetter = [attractionObject.province substringToIndex:2];
  NSMutableArray * attractionsForLetter = [self.attractionsDictionary objectForKey:attractionProvinceTwoFirstLetter];

  if (!attractionsForLetter)
  {
    attractionsForLetter = [NSMutableArray array];
  }

  [attractionsForLetter addObject:attractionObject];
  [attractionsForLetter sortUsingSelector:@selector(compare:)];
  [self.attractionsDictionary setObject:attractionsForLetter forKey:attractionProvinceTwoFirstLetter];

  if (![self.twoFirstLettersArray containsObject:attractionProvinceTwoFirstLetter])
  {
    [self.twoFirstLettersArray addObject:attractionProvinceTwoFirstLetter];
    [self.twoFirstLettersArray sortUsingSelector:@selector(compare:)];
  }

  [self saveAttractionsDictionary];
}

- (void) saveAttractionsDictionary
{
  NSData * attractionsDictionaryData = [NSKeyedArchiver archivedDataWithRootObject:self.attractionsDictionary];

  [[NSUserDefaults standardUserDefaults] setObject:attractionsDictionaryData forKey:attractionsDictionarytKey];
  [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void) loadAttractionsDictionary
{
  NSData * attractionsDictionaryData = [[NSUserDefaults standardUserDefaults] objectForKey:attractionsDictionarytKey];

  if (attractionsDictionaryData)
  {
    self.attractionsDictionary = [NSKeyedUnarchiver unarchiveObjectWithData:attractionsDictionaryData];
    self.twoFirstLettersArray = [NSMutableArray arrayWithArray:self.attractionsDictionary.allKeys];
    [self.twoFirstLettersArray sortUsingSelector:@selector(compare:)];
  }
  else
  {
    self.attractionsDictionary = [NSMutableDictionary dictionary];
    self.twoFirstLettersArray = [NSMutableArray array];
  }
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
  return self.attractionsDictionary.count;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  NSString * firstLetter = [self.twoFirstLettersArray objectAtIndex:section];
  NSMutableArray * attractionsForLetter = [self.attractionsDictionary objectForKey:firstLetter];

  return attractionsForLetter.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
  NSString * twoFirstLetter = [self.twoFirstLettersArray objectAtIndex:indexPath.section];
  NSMutableArray * attractionsForLetter = [self.attractionsDictionary objectForKey:twoFirstLetter];
  Attraction * attractionObject = [attractionsForLetter objectAtIndex:indexPath.row];

  cell.textLabel.text = attractionObject.province;
  cell.detailTextLabel.text = attractionObject.attractionName;

  return cell;
}

- (NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
  return [self.twoFirstLettersArray objectAtIndex:section];
}

- (void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
  if (editingStyle == UITableViewCellEditingStyleDelete)
  {
    [self deleteAttractionAtIndexPath:indexPath];

  }
}

- (void) deleteAttractionAtIndexPath:(NSIndexPath *)indexPath
{
  NSString * sectionHeader = [self.twoFirstLettersArray objectAtIndex:indexPath.section];
  NSMutableArray * attractionsForLetter = [self.attractionsDictionary objectForKey:sectionHeader];

  [attractionsForLetter removeObjectAtIndex:indexPath.row];
  if (attractionsForLetter.count == 0)
  {
    [self.twoFirstLettersArray removeObject:sectionHeader];
    [self.attractionsDictionary removeObjectForKey:sectionHeader];
    [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationFade];
  }
  else
  {
    [self.attractionsDictionary setObject:attractionsForLetter forKey:sectionHeader];
    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
  }
  [self saveAttractionsDictionary];
}

- (void) updateAttractionObject:(Attraction *)attractionObject atIndexPath:(NSIndexPath *)indexPath
{
  NSIndexPath * selectedIndexPath = [self.tableView indexPathForSelectedRow];
  NSString * sectionHeader = [self.twoFirstLettersArray objectAtIndex:selectedIndexPath.section];
  NSMutableArray * attractionsForSection = [self.attractionsDictionary objectForKey:sectionHeader];

  [attractionsForSection removeObjectAtIndex:indexPath.row];
  [attractionsForSection addObject:attractionObject];
  [attractionsForSection sortUsingSelector:@selector(compare:)];
  [self.attractionsDictionary setObject:attractionsForSection forKey:sectionHeader];
  [self saveAttractionsDictionary];
}

- (IBAction) addAttractionTouched:(id)sender
{
  UIStoryboard * mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];

  self.attractionInfoViewController = (AttractionDetailsViewController *) [mainStoryboard instantiateViewControllerWithIdentifier:@"attractionDetails"];

  [self presentViewController:self.attractionInfoViewController animated:YES completion:nil];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
  NSIndexPath * selectedIndexPath = [self.tableView indexPathForSelectedRow];
  NSString * sectionHeader = [self.twoFirstLettersArray objectAtIndex:selectedIndexPath.section];
  NSMutableArray * attractionsForSection = [self.attractionsDictionary objectForKey:sectionHeader];
  Attraction * attractionObject = [attractionsForSection objectAtIndex:selectedIndexPath.row];

  self.attractionInfoViewController = segue.destinationViewController;
  self.attractionInfoViewController.attractionObject = attractionObject;
  self.attractionInfoViewController.saveAttraction = YES;
}


@end
