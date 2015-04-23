//
//  AttractionDetailsViewController.m
//  HOC_Assignment3
//
//  Created by Henrique Carvalho on 2015-02-03.
//  Copyright (c) 2015 Student. All rights reserved.
//

#import "AttractionDetailsViewController.h"

static NSString * attractionObjectKey = @"AttractionObjectKey";

// @interface AttractionDetailsViewController ()

// @end

@implementation AttractionDetailsViewController

- (void) viewDidLoad
{
  [super viewDidLoad];
  // Do any additional setup after loading the view.

  NSLog(@"titleLabel.text = %@", self.titleLabel.text);

  if (!self.attractionObject)
  {
    self.attractionObject = [[Attraction alloc] init];
  }

  [self setUserInterfaceValues];
}

- (void) setUserInterfaceValues
{
  self.provinceTextField.delegate = self;
  // self.provinceTextField.text = self.attractionObject.province;
  self.attractionNameTextField.text = self.attractionObject.attractionName;
  self.commentTextView.text = self.attractionObject.comment;
  self.locationTextField.text = self.attractionObject.location;
  self.lastVisitedTextField.text = self.attractionObject.lastVisited;
  self.ratingValueSlider.value = self.ratingValueSlider.value;
  self.commentTextView.text = self.attractionObject.comment;
}

- (void) didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
}

- (IBAction) ratingSliderValueChanged:(id)sender
{
  self.ratingValueSlider.value = self.ratingValueSlider.value;
  self.attractionObject.rating = self.ratingValueSlider.value;
}

- (BOOL) textFieldShouldBeginEditing:(UITextField *)textField
{
  return YES;
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
  self.attractionObject.province = self.provinceTextField.text;
  [self.provinceTextField resignFirstResponder];
  NSLog(@"WORKS!!!!!");
  return YES;
}

- (BOOL) textViewShouldBeginEditing:(UITextView *)textView
{
  self.saveCommentButton.enabled = YES;
  return YES;
}

- (BOOL) textViewShouldEndEditing:(UITextView *)textView
{
  self.attractionObject.comment = self.commentTextView.text;
  [self.commentTextView resignFirstResponder];
  self.saveCommentButton.enabled = NO;
  return YES;
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

- (IBAction) saveCommentButtonTouched:(id)sender
{
  [self textViewShouldEndEditing:self.commentTextView];
}

- (IBAction) saveButtonTouched:(id)sender
{

  // NSLog(@"province: %@", self.provinceTextField.text);
  // NSLog(@"attractionName: %@", self.provinceTextField.text);
  // NSLog(@"attraction object: %@", self.attractionObject.province);

  if (self.attractionObject.province && self.attractionObject.province.length > 0)
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
  else
  {
    UIAlertView * noAttractionProvinceAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please supply a province for the attraction" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [noAttractionProvinceAlertView show];
  }
}

- (IBAction) cancelButtonTouched:(id)sender
{
  UIActionSheet * promptDeleteDataActionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Delete Attraction" otherButtonTitles:nil];

  [promptDeleteDataActionSheet showInView:self.view];
}
@end
