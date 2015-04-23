//
//  AboutUsViewController.m
//  HOC_project
//
//  Created by Henrique Carvalho on 2015-04-06.
//  Copyright (c) 2015 NIC. All rights reserved.
//

#import "AboutUsViewController.h"

@interface AboutUsViewController ()

@end

@implementation AboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)emailTouched:(id)sender {
    [self emailAttractionInfo];
}

- (IBAction)googlePlusTouched:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"https://plus.google.com/"]];
}

- (IBAction)facebookTouched:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"https://www.facebook.com/stopthejumpersbunnies"]];
}

- (void) emailAttractionInfo
{
    MFMailComposeViewController * mail = [[MFMailComposeViewController alloc] init];
    
    mail.mailComposeDelegate = self;
    
    [mail setToRecipients:@[@"henrique.o.carvalho@hotmail.com.br"]];
    [mail setSubject:@""];
    [mail setMessageBody:@"" isHTML:NO];
 
    [self presentViewController:mail animated:YES completion:nil];
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

@end
