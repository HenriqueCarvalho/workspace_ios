//  BooksViewController.m
//  midterm
//  Created by Frank Lu on 2015-01-12.
//  Copyright (c) 2015 Frank Lu. All rights reserved.
//
#import "BooksViewController.h"

@interface BooksViewController ()

@end

@implementation BooksViewController

static NSString * booksArrayKey = @"BKArrayKey";


- (void) viewDidLoad
{
  [super viewDidLoad];
  self.clearsSelectionOnViewWillAppear = NO;
  /*
     set navigationItem's right button to edit;
     load Books Array
     If there is no book to display, show a popup message
   */
  [self loadBooksArray];
  self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void) viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];

  // if it's back from the details VC and no row was selected, add a new record
  if (self.bookDetailsViewController)
  {
      NSIndexPath *selectedIndexPath = [self.tableView indexPathForSelectedRow];
      if(self.bookDetailsViewController.saveBook) {
          if(selectedIndexPath) {
              //[self updateBookObject:self.bookDetailsViewController.bookObject atIndexPath:selectedIndexPath];
              [self.tableView deselectRowAtIndexPath:selectedIndexPath animated:YES];
          }
          else
              [self addNewBook:self.bookDetailsViewController.bookObject];
          [self.tableView reloadData];
      }
      else if (selectedIndexPath) {
          [self deletebookAtIndexPath:selectedIndexPath];
      }
      self.bookDetailsViewController = nil;
  }
}

- (void) didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
  // there is only one table section for this project
  return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  // modify the line below to return the number of books
  return self.booksArray.count;
}

// you need to implement the method below to make the table display information of all books
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    Book *bookObject = [self.booksArray objectAtIndex:indexPath.row];
    
    cell.textLabel.text = bookObject.bookTitle;
    cell.detailTextLabel.text = bookObject.bookIsbn;
    
    return cell;
}

// You may need to complete this method to save a book object to the persistent storage
- (void)addNewBook:(Book *)bookObject {
  // NSString *bookTitleList = bookObject.bookTitle;
   [self.booksArray addObject: bookObject];
   [self saveBooksArray];
}

// no need to make any change to this method
- (void) deletebookAtIndexPath:(NSIndexPath *)indexPath
{
  [self.booksArray removeObjectAtIndex:indexPath.row];
  [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
  [self saveBooksArray];
}

// no need to make any change to this method
- (void) saveBooksArray
{
  NSData * booksArrayData = [NSKeyedArchiver archivedDataWithRootObject:self.booksArray];

  [[NSUserDefaults standardUserDefaults] setObject:booksArrayData forKey:booksArrayKey];
  NSLog(@"after saving, array content");
  [[NSUserDefaults standardUserDefaults] synchronize];
}

// no need to make any change to this method
- (void) loadBooksArray
{
  NSData * booksArrayData = [[NSUserDefaults standardUserDefaults] objectForKey:booksArrayKey];

  if (booksArrayData)
  {
    self.booksArray = [NSKeyedUnarchiver unarchiveObjectWithData:booksArrayData];
    [self.booksArray sortUsingSelector:@selector(compare:)];             // use NSString compare: ?
  }
  else
  {
    self.booksArray = [NSMutableArray array];
  }
}

// You need to complete the method below to complete the task specified in step 4.c
- (IBAction) addBookButtonTouched:(id)sender
{
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    self.bookDetailsViewController = (BookDetailsViewController *) [mainStoryboard instantiateViewControllerWithIdentifier:@"bookDetails"];
    [self presentViewController:self.bookDetailsViewController animated:YES completion:nil];
}

// No need to make any change to the methdo below
- (BOOL) tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
  return YES;
}

// No need to make any change to the methdo below
- (void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
  if (editingStyle == UITableViewCellEditingStyleDelete)
  {
    [self deletebookAtIndexPath:indexPath];
  }
}

#pragma mark - Navigation
// You need to complete the method below to show the book details
- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *selectedIndexPath = [self.tableView indexPathForSelectedRow];
    //NSString *sectionHeader = [self.booksArray objectAtIndex:selectedIndexPath.section];
    //NSMutableArray *bandsForSection = [self.bandsDictionary objectForKey:sectionHeader];
    
    Book *bookObject = [self.booksArray objectAtIndex:selectedIndexPath.row];
    
    self.bookDetailsViewController = segue.destinationViewController;
    self.bookDetailsViewController.bookObject = bookObject;
    self.bookDetailsViewController.saveBook = YES;
}

/*-(void) showArray
{
    for (Book * book in self.booksArray) {
        NSlog(@"%@", book.bookTitle);
    }
}*/
@end
