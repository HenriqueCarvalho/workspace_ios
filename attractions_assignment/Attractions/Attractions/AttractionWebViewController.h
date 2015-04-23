//
//  AttractionWebViewController.h
//  Attractions
//
//  Created by Henrique Carvalho on 2015-03-23.
//  Copyright (c) 2015 NIC. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    AWebViewActionSheetButtonIndexOpenInSafari,
} AWebViewActionSheetButtonIndex;

@interface AttractionWebViewController : UIViewController <UIWebViewDelegate, UIActionSheetDelegate>

@property (nonatomic, weak) IBOutlet UIWebView *webView;
@property (nonatomic, strong) NSString *attractionWebsite;
@property (nonatomic, assign) int webViewLoadCount;

@property (nonatomic, weak) IBOutlet UIToolbar *toolbar;
@property (nonatomic, weak) IBOutlet UIBarButtonItem *backButton;
@property (nonatomic, weak) IBOutlet UIBarButtonItem *stopButton;
@property (nonatomic, weak) IBOutlet UIBarButtonItem *refreshButton;
@property (nonatomic, weak) IBOutlet UIBarButtonItem *forwardButton;

- (void)webViewLoadComplete;
- (void)setToolbarButtons;

- (IBAction)backButtonTouched:(id)sender;
- (IBAction)stopButtonTouched:(id)sender;
- (IBAction)refreshButtonTouched:(id)sender;
- (IBAction)forwardButtonTouched:(id)sender;
- (IBAction)webViewActionButtonTouched:(id)sender;

@end
