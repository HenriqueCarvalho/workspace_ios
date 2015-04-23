//
//  AttractionWebViewController.m
//  Attractions
//
//  Created by Henrique Carvalho on 2015-03-23.
//  Copyright (c) 2015 NIC. All rights reserved.
//

#import "AttractionWebViewController.h"

@interface AttractionWebViewController ()

@end

@implementation AttractionWebViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.webViewLoadCount = 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    self.webViewLoadCount++;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [self setToolbarButtons];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    self.webViewLoadCount--;
    
    if(self.webViewLoadCount == 0)
        [self webViewLoadComplete];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    self.webViewLoadCount--;
    
    if(self.webViewLoadCount == 0)
        [self webViewLoadComplete];
}

- (void)webViewLoadComplete
{
    NSLog(@"webViewLoadComplete");
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [self setToolbarButtons];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    NSString *urlEncodedAttractionWebsite = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL,(CFStringRef)self.attractionWebsite, NULL, (CFStringRef)@"!*'();:@&=+$,/?%#[]", kCFStringEncodingUTF8 ));
    NSString *yahooSearchString = [NSString stringWithFormat:@"http://search.yahoo.com/search?p=%@", urlEncodedAttractionWebsite];
    NSURL *yahooSearchUrl = [NSURL URLWithString:yahooSearchString];
    NSURLRequest *yahooSearchUrlRequest = [NSURLRequest requestWithURL:yahooSearchUrl];
    
    [self.webView loadRequest:yahooSearchUrlRequest];
}

- (void)setToolbarButtons
{
    self.backButton.enabled = self.webView.canGoBack;
    self.forwardButton.enabled = self.webView.canGoForward;
    self.stopButton.enabled = self.webView.isLoading;
    self.refreshButton.enabled = !self.webView.isLoading;
    NSLog(@"Set Tool Bar Buttons");
}

- (IBAction)backButtonTouched:(id)sender
{
    NSLog(@"backButtonTouched");
    [self.webView goBack];
}

- (IBAction)stopButtonTouched:(id)sender
{
    NSLog(@"stopButtonTouched");
    [self.webView stopLoading];
    self.webViewLoadCount = 0;
    [self webViewLoadComplete];
}

- (IBAction)refreshButtonTouched:(id)sender
{
    NSLog(@"refreshButtonTouched");
    [self.webView loadRequest:self.webView.request];
}

- (IBAction)forwardButtonTouched:(id)sender
{
    NSLog(@"forwardButtonTouched");
    [self.webView goForward];
}

- (IBAction)webViewActionButtonTouched:(id)sender
{
    UIActionSheet *webViewActionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Open in Safari", nil];
    [webViewActionSheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == AWebViewActionSheetButtonIndexOpenInSafari)
    {
        [[UIApplication sharedApplication] openURL:self.webView.request.mainDocumentURL];
    }
}

@end
