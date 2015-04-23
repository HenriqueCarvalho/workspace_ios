//
//  BookDetailsViewController.h
//  midterm
//
//  Created by Frank Lu on 2015-01-12.
//  Copyright (c) 2015 Frank Lu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Book.h"

@interface BookDetailsViewController : UIViewController<UITextFieldDelegate, UITextViewDelegate, UIActionSheetDelegate>

@property (strong, nonatomic) Book *bookObject;

//The following properties and IBActions are not assignment to any control on the interface,
//You have to do it by your self.
@property (strong, nonatomic) IBOutlet UITextView *bookTitle;
@property (strong, nonatomic) IBOutlet UITextField *isbn;
@property (strong, nonatomic) IBOutlet UITextField *author;
@property (strong, nonatomic) IBOutlet UITextField *publisher;
@property (strong, nonatomic) IBOutlet UIButton *saveButton;
@property (strong, nonatomic) IBOutlet UIButton *cancelButton;

@property (nonatomic, assign) BOOL saveBook;
@property (nonatomic, assign) BOOL cancelBook;

- (IBAction)saveButtonTouched:(id)sender;
- (IBAction)cancelButtonTouched:(id)sender;

@end

