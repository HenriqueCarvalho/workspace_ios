//
//  AttractionViewController.m
//  assn4
//
//  Created by Frank Lu on 2015-01-12.
//  Copyright (c) 2015 Frank Lu. All rights reserved.
//

#import "AttractionViewController.h"

@interface AttractionViewController ()

@end

@implementation AttractionViewController

static NSString *attractionsDictionarytKey = @"IMGattractionsDictionarytKey";

- (void)viewDidLoad {
	[super viewDidLoad];
    
    [self loadAttractionsDictionary];
    
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
	self.clearsSelectionOnViewWillAppear = NO;
	
	NSLog(@"Table view is loaded");
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  if (self.attractionDetailsViewController)
  {
    NSIndexPath *selectedIndexPath = [self.tableView indexPathForSelectedRow];
    
    if (self.attractionDetailsViewController.saveAttraction) {
      if (selectedIndexPath) {
        [self updateAttractionObject:self.attractionDetailsViewController.attractionObject atIndexPath:selectedIndexPath];
      }
      else {
        [self addNewAttraction:self.attractionDetailsViewController.attractionObject];
      }
      [self.tableView reloadData];
    }
    else if (self.attractionDetailsViewController.cancelAttraction) {
      //do nothing
    }
    else if (selectedIndexPath) {
      [self deleteAttractionAtIndexPath:selectedIndexPath];
    }
      
    self.attractionDetailsViewController = nil;
  }
}


- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	//#warning Potentially incomplete method implementation.
	// Return the number of sections.
	return self.attractionsDictionary.count;
	//return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	//#warning Incomplete method implementation.
	// Return the number of rows in the section.
	NSString *Abbrev = [self.provincesAbbArray objectAtIndex:section];
	NSMutableArray *atttractionsArrayForAbb = [self.attractionsDictionary objectForKey:Abbrev];
	//NSLog(@"mutable array has %lu bands in %@ section", (unsigned long)atttractionsArrayForAbb.count, [self.provincesAbbArray objectAtIndex:section]);
	return atttractionsArrayForAbb.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *CellIdentifier = @"Cell";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];

	NSString *abbrev = [self.provincesAbbArray objectAtIndex:indexPath.section];
	NSMutableArray *attractionsForAbb = [self.attractionsDictionary objectForKey:abbrev];
	Attraction *attractionObject = [attractionsForAbb objectAtIndex:indexPath.row];

	// Configure the cell...
	cell.textLabel.text = attractionObject.name;
	cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", attractionObject.location];
    cell.imageView.image = attractionObject.image;
    
	return cell;
}

- (void)addNewAttraction:(Attraction *)attractionObject {
	/*
	   Part I add the new band object to the dictionary
	   1. extract the abbrev of the province
	   2. get the array of the attractions whose prov abbrev is the same of the new attraction name
	   3. if the array is empty or nil, create a new one
	   4. add the new attractionobject to the array and sort its content
	   5. add/set the atractions array to the dictionary
	   Part II. update the provAbbrev array
	   if the abbrev of the province name doesn't exist in the abbrev array, add the abbrev to the array and sort it

	   After all is done, save the dictionary object
	 */

	NSString *provinceAbbrev = attractionObject.abbrev;
	//   if ([self.attractionsDictionary objectForKey:provinceAbbrev]==nil)
	// {
	//   [self.attractionsDictionary  setObject:attractionObject forKey:provinceAbbrev];
	NSMutableArray *attractionsForProvince = [self.attractionsDictionary objectForKey:provinceAbbrev];

	if (!attractionsForProvince) {
		attractionsForProvince = [NSMutableArray array];  //if the attraction is the 1st for the Province, create the array
	}
	[attractionsForProvince addObject:attractionObject];
	[attractionsForProvince sortUsingSelector:@selector(compare:)];
	[self.attractionsDictionary setObject:attractionsForProvince forKey:provinceAbbrev];

	//update the abbrev array
	if (![self.provincesAbbArray containsObject:attractionObject.abbrev]) {
		[self.provincesAbbArray addObject:attractionObject.abbrev];
		[self.provincesAbbArray sortUsingSelector:@selector(compare:)];
	}
	[self saveAttractionsDictionary];
	//}
}
//the delete Attraction method is not needed at this time
- (void)deleteAttractionAtIndexPath:(NSIndexPath *)indexPath {
	//get the abbrev and attraction array
	NSString *sectionHeader = [self.provincesAbbArray objectAtIndex:indexPath.section];
	NSMutableArray *attractionsForProvince = [self.attractionsDictionary objectForKey:sectionHeader];
	//remove the attraction from the array
	[attractionsForProvince removeObjectAtIndex:indexPath.row];

	// if there is no attraction in the province anymore, remove the province
	if (attractionsForProvince.count == 0) {
		[self.provincesAbbArray removeObject:sectionHeader];
		[self.attractionsDictionary removeObjectForKey:sectionHeader];
		[self.tableView deleteSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationFade];
	}
	else {
		[self.attractionsDictionary setObject:attractionsForProvince forKey:sectionHeader];

		[self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
	}
	[self saveAttractionsDictionary];
	//  [self.tableView reloadData];
}

- (void)updateAttractionObject:(Attraction *)attractionObject atIndexPath:(NSIndexPath *)indexPath {
	/* 1. find the section and row number of the selected row
	   2. determine the header and get the section mutablearray
	   3. remove the olderone and add the updated object.
	   QUESTION: why don't do the update directly? you may do it but the code is a little longer
	 */
    //which section & row is selected? Isn't this the incoming argument, indexPath? yes. it looks like the same
   	NSIndexPath *selectedIndexPath = [self.tableView indexPathForSelectedRow];
	NSString *sectionHeader = [self.provincesAbbArray objectAtIndex:selectedIndexPath.section];
    //if prov changed, simplly remove the old from the section and add the revised as a new record
    if (![attractionObject.abbrev isEqualToString:sectionHeader])
    {
        [self deleteAttractionAtIndexPath:indexPath];
        [self addNewAttraction:attractionObject];
    }
    else //save 2 methods calls. Just do it right here
    {
	NSMutableArray *attractionsForSection = [self.attractionsDictionary objectForKey:sectionHeader];
    [attractionsForSection removeObjectAtIndex:selectedIndexPath.row];
     [attractionsForSection  addObject:attractionObject];
    [attractionsForSection sortUsingSelector:@selector(compare:)];
 
    [self.attractionsDictionary setObject:attractionsForSection forKey:sectionHeader];
	[self saveAttractionsDictionary];
    }
}

- (void)saveAttractionsDictionary {
	NSData *attractionsDictionaryData = [NSKeyedArchiver archivedDataWithRootObject:self.attractionsDictionary];
	[[NSUserDefaults standardUserDefaults] setObject:attractionsDictionaryData forKey:attractionsDictionarytKey];
	//missing the synchronize method here but it's in the example code
    NSLog(@"after saving, dictionary content"); //debug
    [self showDictionaryContent]; //debug
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)loadAttractionsDictionary {
	NSData *attractionsDictionaryData = [[NSUserDefaults standardUserDefaults] objectForKey:attractionsDictionarytKey];
	if (attractionsDictionaryData) {
		self.attractionsDictionary = [NSKeyedUnarchiver unarchiveObjectWithData:attractionsDictionaryData];
		self.provincesAbbArray = [NSMutableArray arrayWithArray:self.attractionsDictionary.allKeys];
		[self.provincesAbbArray sortUsingSelector:@selector(compare:)]; //use NSString compare: ?
	}
	else {
		self.attractionsDictionary = [NSMutableDictionary dictionary];
		self.provincesAbbArray = [NSMutableArray array];
	}

    NSLog(@"after loading, dictionary content");
    [self showDictionaryContent];
}

- (IBAction)addAttractionTouched:(id)sender {
	UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
	self.attractionDetailsViewController = (AttractionDetailsViewController *)[mainStoryboard instantiateViewControllerWithIdentifier:@"AttractionDetails"];

	[self presentViewController:self.attractionDetailsViewController animated:YES completion:nil];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	return [self.provincesAbbArray objectAtIndex:section];
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
	return self.provincesAbbArray;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
	return [self.provincesAbbArray indexOfObject:title];
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
	// Return NO if you do not want the specified item to be editable.
	return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
	if (editingStyle == UITableViewCellEditingStyleDelete) {
		// Delete the row from the data source
		//[tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
		[self deleteAttractionAtIndexPath:indexPath];
	}
	else if (editingStyle == UITableViewCellEditingStyleInsert) {
		// Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
	}
}

// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
		NSIndexPath *selectedIndexPath = self.tableView.indexPathForSelectedRow;
		NSString *sectionHeader = [self.provincesAbbArray objectAtIndex:selectedIndexPath.section];
		NSMutableArray *attractionsForSection = [self.attractionsDictionary objectForKey:sectionHeader];
		Attraction *attractionObject = [attractionsForSection objectAtIndex:selectedIndexPath.row];
        self.attractionDetailsViewController = segue.destinationViewController;
        self.attractionDetailsViewController.abbrev.enabled = FALSE;
        self.attractionDetailsViewController.attractionObject = attractionObject;
}

- (void) showDictionaryContent
{
    NSLog(@"=================================");

    for (NSString* key in  self.attractionsDictionary.allKeys)
    {
        NSMutableArray * arr = [self.attractionsDictionary objectForKey:key];
        for (Attraction * item in arr) {
            NSLog(@"after saving dictionary: %@ %@ %@", key, item.abbrev, item.name);
        }
    }
    
    NSLog(@"=================================");
}
@end
