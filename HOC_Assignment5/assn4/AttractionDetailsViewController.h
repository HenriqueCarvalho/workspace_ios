//
//  ViewController.h
//  assn4
//
//  Created by Frank Lu on 2015-01-12.
//  Copyright (c) 2015 Frank Lu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Attraction.h"

typedef enum {
    AttractionDetailsActionSheetTagDeleteAttraction,
    AttractionDetailsActionSheetTagDeleteAttractionImage,
    AttractionDetailsActionSheetTagChooseImagePickerSource,
} AttractionDetailsActionSheetTag;

typedef enum{
    AttractionDetailsImagePickerSourceCamera,
    AttractionDetailsImagePickerSourcePhotoLibrary,
}AttractionDetailsImagePickerSource;

@interface AttractionDetailsViewController : UIViewController <UITextFieldDelegate, UITextViewDelegate, UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (strong, nonatomic) Attraction *attractionObject;

@property (strong, nonatomic) IBOutlet UITextField *abbrev;
@property (strong, nonatomic) IBOutlet UITextField *name;
@property (strong, nonatomic) IBOutlet UIImageView *pic;
@property (strong, nonatomic) IBOutlet UITextField *location;
@property (strong, nonatomic) IBOutlet UITextField *lastVisited;
@property (strong, nonatomic) IBOutlet UISlider *rating;
@property (strong, nonatomic) IBOutlet UITextView *comment;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *saveBarButton;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *cancelBarButton;
@property (strong, nonatomic) IBOutlet UIButton *saveButton;
@property (strong, nonatomic) IBOutlet UIButton *cancelButton;
@property (strong, nonatomic) IBOutlet UILabel *addPhotoLabel;
@property (strong, nonatomic) IBOutlet UIImageView *attractionImageView;

@property (nonatomic, assign) BOOL saveAttraction;
@property (nonatomic, assign) BOOL cancelAttraction;

- (IBAction)saveButtonTouched:(id)sender;
- (IBAction)cancelButtonTouched:(id)sender;
- (IBAction)attractionImageViewTapDetected:(id)sender;

- (void)presentPhotoLibraryImagePicker;
- (void)presentCameraImagePicker;

@end

