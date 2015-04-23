//
//  AttractionDetailsViewController.h
//  Attractions
//
//  Created by Henrique Carvalho on 2015-03-07.
//  Copyright (c) 2015 NIC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Attraction.h"
#import <MessageUI/MFMailComposeViewController.h>
#import <MessageUI/MFMessageComposeViewController.h>

typedef enum
{
  AttractionDetailsActionSheetTagDeleteAttraction,
  AttractionDetailsActionSheetTagDeleteAttractionImage,
  AttractionDetailsActionSheetTagChooseImagePickerSource,
  AttractionDetailsActionSheetTagActivity,
} AttractionDetailsActionSheetTag;

typedef enum
{
  AttractionDetailsImagePickerSourceCamera,
  AttractionDetailsImagePickerSourcePhotoLibrary,
}AttractionDetailsImagePickerSource;

typedef enum
{
  AttractionDetailsActivityButtonIndexEmail,
  AttractionDetailsActivityButtonIndexShare,
  AttractionDetailsActivityButtonIndexWebSearch,
} AttractionDetailsActivityButtonIndex;

@interface AttractionDetailsViewController : UIViewController <UITextFieldDelegate, UITextViewDelegate, UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, MFMailComposeViewControllerDelegate, MFMessageComposeViewControllerDelegate>

@property (strong, nonatomic) Attraction * attractionObject;

@property (strong, nonatomic) IBOutlet UITextField * province;
@property (strong, nonatomic) IBOutlet UITextField * name;
@property (strong, nonatomic) IBOutlet UIImageView * pic;
@property (strong, nonatomic) IBOutlet UITextField * location;
@property (strong, nonatomic) IBOutlet UITextField * lastVisited;
@property (weak, nonatomic)   IBOutlet UITextField * webSite;
@property (strong, nonatomic) IBOutlet UISlider * rating;
@property (strong, nonatomic) IBOutlet UITextView * comment;
@property (strong, nonatomic) IBOutlet UIBarButtonItem * saveBarButton;
@property (strong, nonatomic) IBOutlet UIBarButtonItem * cancelBarButton;
@property (strong, nonatomic) IBOutlet UILabel * addPhotoLabel;
@property (strong, nonatomic) IBOutlet UIImageView * attractionImageView;
@property (strong, nonatomic) IBOutlet UIButton * saveButton;
@property (strong, nonatomic) IBOutlet UIButton * cancelButton;

@property (nonatomic, assign) BOOL saveAttraction;
@property (nonatomic, assign) BOOL cancelAttraction;

- (IBAction) saveButtonTouched:(id)sender;
- (IBAction) cancelButtonTouched:(id)sender;
- (IBAction) attractionImageViewTapDetected:(id)sender;
- (IBAction) attractionImageViewSwipeDetected:(id)sender;
- (IBAction) activityButtonTouched:(id)sender;

- (void) presentPhotoLibraryImagePicker;
- (void) presentCameraImagePicker;

- (void) emailAttractionInfo;
- (void) messageAttractionInfo;
- (void) shareAttractionInfo;

@end
