//
//  AttractionsListTableViewController.m
//  HOC_Assignment3
//
//  Created by Henrique Carvalho on 2015-02-03.
//  Copyright (c) 2015 Student. All rights reserved.
//

#import "AttractionsListTableViewController.h"
#import "Attraction.h"
#import "AttractionDetailsViewController.h"

static NSString * attractionsDictionarytKey = @"attractionsDictionarytKey";

@interface AttractionsListTableViewController ()

@end

@implementation AttractionsListTableViewController

- (id) initWithStyle:(UITableViewStyle)style
{
  self = [super initWithStyle:style];
  if (self)
  {
    // Custom initialization
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

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
  // Return the number of sections.
  return self.attractionsDictionary.count;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  // Return the number of rows in the section.
  NSString * firstLetter = [self.firstLettersArray objectAtIndex:section];
  NSMutableArray * attractionsForLetter = [self.attractionsDictionary objectForKey:firstLetter];

  return attractionsForLetter.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  static NSString * CellIdentifier = @"Cell";
  UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];

  NSString * firstLetter = [self.firstLettersArray objectAtIndex:indexPath.section];
  NSMutableArray * attractionsForLetter = [self.attractionsDictionary objectForKey:firstLetter];
  Attraction * attractionObject = [attractionsForLetter objectAtIndex:indexPath.row];

  // Configure the cell...
  cell.textLabel.text = attractionObject.province;

  return cell;
}

- (NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
  return [self.firstLettersArray objectAtIndex:section];
}

- (int) tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
  return [self.firstLettersArray indexOfObject:title];
}

- (BOOL) tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
  return YES;
}

- (void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
  if (editingStyle == UITableViewCellEditingStyleDelete)
  {
    [self deleteAttractionAtIndexPath:indexPath];
  }
}

- (void) addNewAttraction:(Attraction *)attractionObject
{
  NSString * attractionProvinceFirstLetter = [attractionObject.province substringToIndex:2];
  NSMutableArray * attractionsForLetter = [self.attractionsDictionary objectForKey:attractionProvinceFirstLetter];

  if (!attractionsForLetter)
  {
    attractionsForLetter = [NSMutableArray array];
  }

  [attractionsForLetter addObject:attractionObject];
  [attractionsForLetter sortUsingSelector:@selector(compare:)];
  [self.attractionsDictionary setObject:attractionsForLetter forKey:attractionProvinceFirstLetter];

  if (![self.firstLettersArray containsObject:attractionProvinceFirstLetter])
  {
    [self.firstLettersArray addObject:attractionProvinceFirstLetter];
    [self.firstLettersArray sortUsingSelector:@selector(compare:)];
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
    self.firstLettersArray = [NSMutableArray arrayWithArray:self.attractionsDictionary.allKeys];
    [self.firstLettersArray sortUsingSelector:@selector(compare:)];
  }
  else
  {
    self.attractionsDictionary = [NSMutableDictionary dictionary];
    self.firstLettersArray = [NSMutableArray array];
  }
}

- (IBAction) addAttractionTouched:(id)sender
{
  UIStoryboard * mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];

  self.attractionInfoViewController = (AttractionDetailsViewController *) [mainStoryboard instantiateViewControllerWithIdentifier:@"attractionDetails"];

  [self presentViewController:self.attractionInfoViewController animated:YES completion:nil];
}

- (void) deleteAttractionAtIndexPath:(NSIndexPath *)indexPath
{
  NSString * sectionHeader = [self.firstLettersArray objectAtIndex:indexPath.section];
  NSMutableArray * attractionsForLetter = [self.attractionsDictionary objectForKey:sectionHeader];

  [attractionsForLetter removeObjectAtIndex:indexPath.row];

  if (attractionsForLetter.count == 0)
  {
    [self.firstLettersArray removeObject:sectionHeader];
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
  NSString * sectionHeader = [self.firstLettersArray objectAtIndex:selectedIndexPath.section];
  NSMutableArray * attractionsForSection = [self.attractionsDictionary objectForKey:sectionHeader];

  [attractionsForSection removeObjectAtIndex:indexPath.row];
  [attractionsForSection addObject:attractionObject];
  [attractionsForSection sortUsingSelector:@selector(compare:)];
  [self.attractionsDictionary setObject:attractionsForSection forKey:sectionHeader];
  [self saveAttractionsDictionary];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
  NSIndexPath * selectedIndexPath = [self.tableView indexPathForSelectedRow];
  NSString * sectionHeader = [self.firstLettersArray objectAtIndex:selectedIndexPath.section];
  NSMutableArray * attractionsForSection = [self.attractionsDictionary objectForKey:sectionHeader];
  Attraction * attractionObject = [attractionsForSection objectAtIndex:selectedIndexPath.row];

  self.attractionInfoViewController = segue.destinationViewController;
  self.attractionInfoViewController.attractionObject = attractionObject;
  self.attractionInfoViewController.saveAttraction = YES;
}


@end
