//
//  BookDetailsViewController.m
//
//  Created by Frank Lu on 2015-01-12.
//  Copyright (c) 2015 Frank Lu. All rights reserved.
//

#import "BookDetailsViewController.h"

@interface BookDetailsViewController ()

@end

@implementation BookDetailsViewController

- (void) viewDidLoad
{
  [super viewDidLoad];

  // If the book object doesn't exist, you need to create it
  if (!self.bookObject)
  {
    self.bookObject = [[Book alloc] init];
  }
  [self userInterface];
}

- (void) userInterface
{
  // Complete this method to display the book info from the bookObject to the
  // UI controls
  self.bookTitle.text = self.bookObject.bookTitle;
  self.isbn.text = self.bookObject.bookIsbn;
  self.author.text = self.bookObject.authorName;
  self.publisher.text = self.bookObject.publisher;
    
    if(self.navigationController){
        self.saveButton.hidden = YES;
        self.cancelButton.hidden = YES;
    }
}

- (void) didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}


 #pragma mark - Navigation

- (IBAction) saveButtonTouched:(id)sender
{

  {
    /*if the book title is entered with at least 5 chars,
     * 1. update the bookObject
     * 2. dismiss the view controller
     * if not enough data entered, show a popup message.
     */
    NSLog(@"size title %lu", self.bookTitle.text.length);

    if (self.bookTitle.text && self.bookTitle.text.length > 5)
    {
      self.bookObject.bookTitle = self.bookTitle.text;
      NSLog(@"title %@", self.bookTitle.text);
      self.bookObject.bookIsbn = self.isbn.text;
      self.bookObject.authorName = self.author.text;
      self.bookObject.publisher = self.publisher.text;
      self.saveBook = true;
      if (self.navigationController)
      {
        [self.navigationController popViewControllerAnimated:YES];
      }
      else
      {
        [self dismissViewControllerAnimated:YES completion:nil];
      }
    }
    else
    {
      UIAlertView * bookAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please supply a book title greater than or equals 5" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
      [bookAlertView show];
    }
  }

}

- (BOOL) textFieldShouldBeginEditing:(UITextField *)textField
{
  return YES;
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
  [textField resignFirstResponder];
  return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (IBAction) cancelButtonTouched:(id)sender
{
  // dismiss the view controller
  self.saveBook = FALSE;
  self.cancelBook = TRUE;
  if (self.navigationController)
  {
    [self.navigationController popToRootViewControllerAnimated:YES];
  }
  else
  {
    [self dismissViewControllerAnimated:YES completion:nil];
  }
}

@end
