//
//  AttractionDetailsViewController.h
//  HOC_Assignment4
//
//  Created by Henrique Carvalho on 2015-02-08.
//  Copyright (c) 2015 Student. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Attraction.h"

@interface AttractionDetailsViewController : UIViewController <UITextFieldDelegate, UITextViewDelegate, UIActionSheetDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) Attraction * attractionObject;
@property (nonatomic, assign) BOOL saveAttraction;

@property (weak, nonatomic) IBOutlet UITextField * provinceTextField;
@property (weak, nonatomic) IBOutlet UITextField * attractionNameTextField;
@property (weak, nonatomic) IBOutlet UITextView * notesTextView;
@property (weak, nonatomic) IBOutlet UIButton * saveButton;
@property (weak, nonatomic) IBOutlet UIButton * cancelButton;
@property (weak, nonatomic) IBOutlet UITextField * locationTextField;
@property (weak, nonatomic) IBOutlet UISlider * ratingValueSlider;
@property (weak, nonatomic) IBOutlet UITextField * lastVisitedTextField;
@property (weak, nonatomic) IBOutlet UIButton * saveNotesButton;

- (IBAction) ratingSliderValueChanged:(id)sender;
- (IBAction) cancelButtonTouched:(id)sender;
- (IBAction) saveButtonTouched:(id)sender;
- (IBAction) saveNotesButtonTouched:(id)sender;

- (void) setUserInterface;
@end
