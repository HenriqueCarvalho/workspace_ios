//
//  ViewController.m
//  assn4
//
//  Created by Frank Lu on 2015-01-12.
//  Copyright (c) 2015 Frank Lu. All rights reserved.
//

#import "AttractionDetailsViewController.h"

@interface AttractionDetailsViewController ()

@end

@implementation AttractionDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (!self.attractionObject) {
        self.attractionObject = [[Attraction alloc] init];
    }
    [self userInterface];
}

- (void) userInterface
{
    self.abbrev.text = self.attractionObject.abbrev;
    self.name.text = self.attractionObject.name;
    self.location.text = self.attractionObject.location;
    //self.rating.value = self.attractionObject.rating;
    [self.rating setValue:self.attractionObject.rating animated:YES];
    NSLog(@"UIrating value%f obj.rating%f", self.rating.value,self.attractionObject.rating);

    self.lastVisited.text = self.attractionObject.lastVisit ;
    self.comment.text = self.attractionObject.comment ;

     if (self.navigationController)
    {
        self.saveButton.hidden = YES;
        self.cancelButton.hidden = YES;
        //self.abbrev.enabled = FALSE;
    }
    
    if (self.attractionObject.image)
    {
        self.attractionImageView.image = self.attractionObject.image;
        self.addPhotoLabel.hidden = YES;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)saveButtonTouched:(id)sender {

        if (self.abbrev.text && self.abbrev.text.length > 0)
        {
            self.attractionObject.abbrev = [self.abbrev.text uppercaseString];
            self.attractionObject.name = self.name.text;
            self.attractionObject.location= self.location.text;
            self.attractionObject.rating = self.rating.value;
             self.attractionObject.lastVisit= self.lastVisited.text;
            self.attractionObject.comment = self.comment.text;
            self.saveAttraction = true;
            if (self.navigationController) //from segue? if yes, the VC is on the stack
            {
                [self.navigationController popViewControllerAnimated:YES];
            }
            else
                [self dismissViewControllerAnimated:YES completion:nil];

        }
        else
        {
            UIAlertView *noProvinceAbbAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please enter an abbreviation for the province" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            
            [noProvinceAbbAlertView show ];
        }
    //self.saveAttraction = TRUE;
}
- (IBAction)cancelButtonTouched:(id)sender {
    self.saveAttraction = FALSE;
    self.cancelAttraction = TRUE;
    if (self.navigationController) //from segue? if yes, the VC is on the stack
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
        [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)attractionImageViewTapDetected:(id)sender {
    
    NSLog(@"attraction tap image detected");
    
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        UIActionSheet *chooseCameraActionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Take with Camera", @"Choose from photo library", nil];
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
        UIAlertView *photoLibraryErrorAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"No photo Library" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [photoLibraryErrorAlert show];
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

- (void)presentCameraImagePicker
{
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    
    imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    imagePickerController.delegate = self;
    imagePickerController.allowsEditing = YES ;
    [self presentViewController:imagePickerController animated:YES completion:nil];
}

-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *selectedImage = [info objectForKey:UIImagePickerControllerEditedImage];
    
    if(selectedImage == NULL)
        selectedImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    self.attractionImageView.image = selectedImage;
    self.attractionObject.image = selectedImage;
    //self.addPhotoLabel.hidden = YES;
    
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

/*- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    return YES;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    [textView resignFirstResponder];
    return YES;
}*/

- (void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
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
                [self.navigationController popViewControllerAnimated:YES];     // from clicking on a table row
            }
            else
            {
                [self dismissViewControllerAnimated:YES completion:nil];     // from click on the + button
            }
        }
    }
}

@end
