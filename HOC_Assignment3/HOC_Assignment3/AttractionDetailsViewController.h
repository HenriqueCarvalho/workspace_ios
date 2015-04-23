//
//  AttractionDetailsViewController.h
//  HOC_Assignment3
//
//  Created by Henrique Carvalho on 2015-02-03.
//  Copyright (c) 2015 Student. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Attraction.h"

@interface AttractionDetailsViewController : UIViewController <UITextFieldDelegate, UITextViewDelegate, UIActionSheetDelegate>

@property (nonatomic, strong) Attraction * attractionObject;
@property (nonatomic, assign) BOOL saveAttraction;

@property (weak, nonatomic) IBOutlet UILabel * titleLabel;
@property (weak, nonatomic) IBOutlet UITextField * provinceTextField;
@property (weak, nonatomic) IBOutlet UITextField * attractionNameTextField;
@property (weak, nonatomic) IBOutlet UITextView * commentTextView;
@property (weak, nonatomic) IBOutlet UIButton * saveCommentButton;
@property (weak, nonatomic) IBOutlet UITextField * locationTextField;
@property (weak, nonatomic) IBOutlet UITextField * lastVisitedTextField;
@property (weak, nonatomic) IBOutlet UISlider * ratingValueSlider;
@property (weak, nonatomic) IBOutlet UIButton * saveButton;
@property (weak, nonatomic) IBOutlet UIButton * cancelButton;

- (IBAction) saveCommentButtonTouched:(id)sender;
- (IBAction) ratingSliderValueChanged:(id)sender;
- (IBAction) cancelButtonTouched:(id)sender;
- (IBAction) saveButtonTouched:(id)sender;

- (void) setUserInterfaceValues;
@end
