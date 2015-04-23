//
//  AttractionDetailsViewController.m
//  Attractions
//
//  Created by Henrique Carvalho on 2015-03-07.
//  Copyright (c) 2015 NIC. All rights reserved.
//

#import "AttractionDetailsViewController.h"
#import "AttractionWebViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>

@interface AttractionDetailsViewController ()

@end

@implementation AttractionDetailsViewController

- (void) viewDidLoad
{
  [super viewDidLoad];

  // Do any additional setup after loading the view.
  if (!self.attractionObject)
  {
    self.attractionObject = [[Attraction alloc] init];
  }

  [self userInterface];
}

- (void) userInterface
{
  self.province.text = self.attractionObject.province;
  self.name.text = self.attractionObject.name;
  self.location.text = self.attractionObject.location;
  // self.rating.value = self.attractionObject.rating;
  [self.rating setValue:self.attractionObject.rating animated:YES];
  self.webSite.text = self.attractionObject.webSite;
  self.lastVisited.text = self.attractionObject.lastVisit;
  self.comment.text = self.attractionObject.comment;

  if (self.navigationController)
  {
    self.saveButton.hidden = YES;
    self.cancelButton.hidden = YES;
  }

  if (self.attractionObject.image)
  {
    self.attractionImageView.image = self.attractionObject.image;
    self.addPhotoLabel.hidden = YES;
  }
}

- (void) didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
}

- (IBAction) saveButtonTouched:(id)sender
{

  if (self.province.text && self.province.text.length > 0)
  {
    self.attractionObject.province = [self.province.text uppercaseString];
    self.attractionObject.name = self.name.text;
    self.attractionObject.location = self.location.text;
    self.attractionObject.rating = self.rating.value;
    self.attractionObject.lastVisit = self.lastVisited.text;
    self.attractionObject.webSite = self.webSite.text;
    self.attractionObject.comment = self.comment.text;
    self.saveAttraction = true;
    if (self.navigationController)     // from segue? if yes, the VC is on the stack
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
    UIAlertView * noProvinceAbbAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please enter an abbreviation for the province" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];

    [noProvinceAbbAlertView show ];
  }
  // self.saveAttraction = TRUE;
}
- (IBAction) cancelButtonTouched:(id)sender
{

  self.saveAttraction = FALSE;
  self.cancelAttraction = TRUE;

  if (self.navigationController)   // from segue? if yes, the VC is on the stack
  {
    [self.navigationController popViewControllerAnimated:YES];
  }
  else
  {
    [self dismissViewControllerAnimated:YES completion:nil];
  }
}

- (IBAction) attractionImageViewTapDetected:(id)sender
{

  NSLog(@"attraction tap image detected");

  if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
  {
    UIActionSheet * chooseCameraActionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Take with Camera", @"Choose from photo library", nil];
    chooseCameraActionSheet.tag = AttractionDetailsActionSheetTagChooseImagePickerSource;
    [chooseCameraActionSheet showInView:self.view];
  }
  else if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
  {
    NSLog(@"Image View Tap detected");
    [self presentPhotoLibraryImagePicker];
  }
  else
  {
    UIAlertView * photoLibraryErrorAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"No photo Library" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [photoLibraryErrorAlert show];
  }
}

- (IBAction) attractionImageViewSwipeDetected:(id)sender
{

  NSLog(@"Attraction Swipe image detected");

  if (self.attractionObject.image)
  {
    UIActionSheet * deleteAttractionImageActionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Delete Picture" otherButtonTitles:nil];
    deleteAttractionImageActionSheet.tag = AttractionDetailsActionSheetTagDeleteAttractionImage;
    [deleteAttractionImageActionSheet showInView:self.view];
  }

}

- (IBAction) activityButtonTouched:(id)sender
{
  UIActionSheet * activityActionSheet = nil;

  activityActionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Email", @"Share", @"Search the Web", nil];

  activityActionSheet.tag = AttractionDetailsActionSheetTagActivity;
  [activityActionSheet showInView:self.view];

}

- (void) emailAttractionInfo
{
  MFMailComposeViewController * mailComposeViewController = [[MFMailComposeViewController alloc] init];

  mailComposeViewController.mailComposeDelegate = self;

  [mailComposeViewController setSubject:self.attractionObject.province];
  [mailComposeViewController setMessageBody:[self.attractionObject stringForMessaging] isHTML:NO];

  if (self.attractionObject.image)
  {
    [mailComposeViewController addAttachmentData:UIImagePNGRepresentation(self.attractionObject.image) mimeType:@"image/png" fileName:@"attractionImage"];
  }

  [self presentViewController:mailComposeViewController animated:YES completion:nil];
}

- (void) messageAttractionInfo
{
  MFMessageComposeViewController * messageComposeViewController = [[MFMessageComposeViewController alloc]init];

  messageComposeViewController.messageComposeDelegate = self;

  [messageComposeViewController setSubject:self.attractionObject.province];
  [messageComposeViewController setBody:[self.attractionObject stringForMessaging]];

  if (self.attractionObject.image)
  {
    [messageComposeViewController addAttachmentData:UIImagePNGRepresentation(self.attractionObject.image) typeIdentifier:(NSString *) kUTTypePNG filename:@"attractionImage.png"];
  }

  [self presentViewController:messageComposeViewController animated:YES completion:nil];
}

- (void) shareAttractionInfo
{
  NSArray * activityItems = [NSArray arrayWithObjects:[self.attractionObject stringForMessaging], self.attractionObject.image, nil];

  UIActivityViewController * activityViewController = [[UIActivityViewController alloc]initWithActivityItems:activityItems applicationActivities:nil];

  [activityViewController setValue:self.attractionObject.name forKey:@"subject"];

  NSArray * excludedActivityOptions = [NSArray arrayWithObjects:UIActivityTypeAssignToContact, nil];
  [activityViewController setExcludedActivityTypes:excludedActivityOptions];

  [self presentViewController:activityViewController animated:YES completion:nil];
}

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
  [controller dismissViewControllerAnimated:YES completion:nil];
  if (error)
  {
    UIAlertView * emailErrorAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:error.localizedDescription delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [emailErrorAlertView show];
  }
}

- (void) messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
  [controller dismissViewControllerAnimated:YES completion:nil];
  if (result == MessageComposeResultFailed)
  {
    UIAlertView * emailErrorAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"The message failed to send" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [emailErrorAlertView show];
  }
}

- (void) presentPhotoLibraryImagePicker
{
  UIImagePickerController * imagePickerController = [[UIImagePickerController alloc] init];

  imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
  imagePickerController.delegate = self;
  imagePickerController.allowsEditing = YES;

  [self presentViewController:imagePickerController animated:YES completion:nil];
}

- (void) presentCameraImagePicker
{
  UIImagePickerController * imagePickerController = [[UIImagePickerController alloc] init];

  imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
  imagePickerController.delegate = self;
  imagePickerController.allowsEditing = YES;

  [self presentViewController:imagePickerController animated:YES completion:nil];
}

- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
  UIImage * selectedImage = [info objectForKey:UIImagePickerControllerEditedImage];

  if (selectedImage == NULL)
  {
    selectedImage = [info objectForKey:UIImagePickerControllerOriginalImage];
  }

  self.attractionImageView.image = selectedImage;
  self.attractionObject.image = selectedImage;
  self.addPhotoLabel.hidden = YES;

  [picker dismissViewControllerAnimated:YES completion:nil];
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

- (BOOL) textFieldShouldEndEditing:(UITextField *)textField
{
  [textField resignFirstResponder];
  return YES;
}

// Hiding the Keyboard when the User Taps the Background
- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
  [self.view endEditing:YES];
}

- (void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
  NSLog(@"%ld", (long) buttonIndex);
  if (actionSheet.tag == AttractionDetailsActionSheetTagActivity)
  {

    NSLog(@"Action Sheet");
    if (buttonIndex == AttractionDetailsActivityButtonIndexEmail)
    {
      NSLog(@"Email button index");
      [self emailAttractionInfo];
    }
    else if (buttonIndex == AttractionDetailsActivityButtonIndexShare)
    {
      NSLog(@"Share button index");
      [self shareAttractionInfo];
    }
    else if (buttonIndex == AttractionDetailsActivityButtonIndexWebSearch)
    {
        [self performSegueWithIdentifier:@"webViewSegue" sender:nil];
        NSLog(@"Web View");
    }
  }
  if (actionSheet.tag == AttractionDetailsActionSheetTagChooseImagePickerSource)
  {
    if (buttonIndex == AttractionDetailsImagePickerSourceCamera)
    {
      [self presentCameraImagePicker];
    }
    else if (buttonIndex == AttractionDetailsImagePickerSourcePhotoLibrary)
    {
      [self presentPhotoLibraryImagePicker];
    }
  }
  else if (actionSheet.tag == AttractionDetailsActionSheetTagDeleteAttractionImage)
  {
    if (buttonIndex  == actionSheet.destructiveButtonIndex)
    {
      self.attractionObject.image = nil;
      self.attractionImageView.image = nil;
      self.addPhotoLabel.hidden = NO;
    }
  }
  else if (actionSheet.tag == AttractionDetailsActionSheetTagDeleteAttraction)
  {
    if (actionSheet.destructiveButtonIndex == buttonIndex)
    {
      self.attractionObject = nil;
      self.saveAttraction = NO;
      if (self.navigationController)
      {
        [self.navigationController popViewControllerAnimated:YES];  // from clicking on a table row
      }
      else
      {
        [self dismissViewControllerAnimated:YES completion:nil]; // from click on the + button
      }
    }
  }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.destinationViewController class] == [AttractionWebViewController class])
    {
        AttractionWebViewController *webViewController = segue.destinationViewController;
        webViewController.attractionWebsite = self.attractionObject.webSite;
    }
}

@end