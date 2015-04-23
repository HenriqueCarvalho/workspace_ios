//
//  AttractionDetailsViewController.m
//  HOC_Assignment4
//
//  Created by Henrique Carvalho on 2015-02-08.
//  Copyright (c) 2015 Student. All rights reserved.
//

#import "AttractionDetailsViewController.h"

@interface AttractionDetailsViewController ()

@end

static NSString * attractionObjectKey = @"AttractionObjectKey";
@implementation AttractionDetailsViewController

- (void) viewDidLoad
{
  [super viewDidLoad];

  [self loadAttractionObject];

  if (!self.attractionObject)
  {
    self.attractionObject = [[Attraction alloc] init];
  }

  [self setUserInterface];
  //self.saveNotesButton.enabled = NO;
}

- (void) didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
}

- (void) saveAttractionObject
{
  NSData * attractionObjectDate = [NSKeyedArchiver archivedDataWithRootObject:self.attractionObject];

  [[NSUserDefaults standardUserDefaults] setObject:attractionObjectDate forKey:attractionObjectKey];
}

- (void) loadAttractionObject
{
  NSData * attractionObjectData = [[NSUserDefaults standardUserDefaults] objectForKey:attractionObjectKey];

  if (attractionObjectData)
  {
    self.attractionObject = [NSKeyedUnarchiver unarchiveObjectWithData:attractionObjectData];
  }
}

- (void) setUserInterface
{
  //self.provinceTextField.delegate = self;
  self.provinceTextField.text = self.attractionObject.province;
  self.attractionNameTextField.text = self.attractionObject.attractionName;
  self.notesTextView.text = self.attractionObject.notes;
  self.attractionNameTextField.text = self.attractionObject.attractionName;
  self.locationTextField.text = self.attractionObject.location;
  self.lastVisitedTextField.text = self.attractionObject.lastVisited;
  self.ratingValueSlider.value = self.ratingValueSlider.value;
    
}

#pragma mark UITextFieldDelegate Methods
- (BOOL) textFieldShouldBeginEditing:(UITextField *)textField
{
  self.saveNotesButton.enabled = YES;
  return YES;
}

- (BOOL) textViewShouldEndEditing:(UITextView *)textView
{
  self.attractionObject.notes = self.notesTextView.text;
  [self.notesTextView resignFirstResponder];
  self.saveNotesButton.enabled = NO;
  return YES;
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
  self.attractionObject.province = self.provinceTextField.text;
  [self.provinceTextField resignFirstResponder];
  NSLog(@"WORKS!!!!!");
  [self saveAttractionObject];
  return YES;
}

#pragma mark UITextViewDelegate Methods
- (BOOL) textViewShouldBeginEditing:(UITextView *)textView
{
  self.saveNotesButton.enabled = YES;
  return YES;
}

- (IBAction) saveNotesButtonTouched:(id)sender
{
  [self textViewShouldEndEditing:self.notesTextView];
}

- (IBAction) saveButtonTouched:(id)sender
{
  if (!self.attractionObject.province || self.attractionObject.province.length == 0)
  {
    UIAlertView * noAttractionProvinceAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please supply a name for the attraction" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [noAttractionProvinceAlertView show];
  }
  else
  {
    self.saveAttraction = YES;

    if (self.navigationController)
    {
      [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
      [self dismissViewControllerAnimated:YES completion:nil];
    }
  }
}

- (IBAction) ratingSliderValueChanged:(id)sender
{
}

- (IBAction) cancelButtonTouched:(id)sender
{
  UIActionSheet * promptDeleteDataActionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Delete Attraction" otherButtonTitles:nil];

  [promptDeleteDataActionSheet showInView:self.view];
}

- (void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
  if (actionSheet.destructiveButtonIndex == buttonIndex)
  {
    self.attractionObject = nil;
    self.saveAttraction = NO;

    if (self.navigationController)
    {
      [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
      [self dismissViewControllerAnimated:YES completion:nil];
    }
  }
}
@end
