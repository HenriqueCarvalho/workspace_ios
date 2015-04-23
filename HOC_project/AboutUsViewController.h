//
//  AboutUsViewController.h
//  HOC_project
//
//  Created by Henrique Carvalho on 2015-04-06.
//  Copyright (c) 2015 NIC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface AboutUsViewController : UIViewController <MFMailComposeViewControllerDelegate, UIWebViewDelegate>

- (IBAction)emailTouched:(id)sender;
- (IBAction)googlePlusTouched:(id)sender;
- (IBAction)facebookTouched:(id)sender;

@end
