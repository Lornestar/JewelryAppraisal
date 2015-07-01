//
//  EmailAppraisalViewController.m
//  JewelryAppraisal
//
//  Created by Lorne Lantz on 2014-08-03.
//  Copyright (c) 2014 Lorne Lantz. All rights reserved.
//

#import "EmailAppraisalViewController.h"
#import "ECSlidingViewController.h"
#import "MenuViewController.h"
#import "PDFRenderer.h"
#import <MessageUI/MessageUI.h>

@interface EmailAppraisalViewController ()<MFMailComposeViewControllerDelegate>

@end

@implementation EmailAppraisalViewController
@synthesize appdel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //add menubtn & slidemenu
    self.view.layer.shadowOpacity = 0.75f;
    self.view.layer.shadowRadius = 10.0f;
    self.view.layer.shadowColor = [UIColor blackColor].CGColor;
    
    
    if (![self.slidingViewController.underLeftViewController isKindOfClass:[MenuViewController class]]) {
        self.slidingViewController.underLeftViewController  = [self.storyboard instantiateViewControllerWithIdentifier:@"Menu"];
    }
    
    
    [self.view addGestureRecognizer:self.slidingViewController.panGesture];
    
    appdel = [UIApplication sharedApplication].delegate;
    
    [PDFRenderer drawPDF:[self getPDFFileName]];
    
    
   
    
/*    UIWebView* webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    
    NSURL *url = [NSURL fileURLWithPath:[self getPDFFileName]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView setScalesPageToFit:YES];
    [webView loadRequest:request];
    
    
    [self.view addSubview:webView];*/
    
    [self showEmail:[self getPDFFileName]];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)btnMenu_Clicked:(id)sender {
    [self.slidingViewController anchorTopViewTo:ECRight];
}

-(NSString*)getPDFFileName
{
    NSString* fileName = @"JewelryAppraisal.pdf";
    
    NSArray *arrayPaths =
    NSSearchPathForDirectoriesInDomains(
                                        NSDocumentDirectory,
                                        NSUserDomainMask,
                                        YES);
    NSString *path = [arrayPaths objectAtIndex:0];
    NSString* pdfFileName = [path stringByAppendingPathComponent:fileName];
    
    return pdfFileName;
    
}

- (void)showEmail:(NSString*)file {
    
    NSString *emailTitle = appdel.currentappraisal.title;
    NSString *messageBody = @"";
    
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    mc.mailComposeDelegate = self;
    [mc setSubject:emailTitle];
    [mc setMessageBody:messageBody isHTML:NO];
//    [mc setToRecipients:toRecipents];
    
    // Determine the file name and extension
    NSArray *filepart = [file componentsSeparatedByString:@"."];
    NSString *filename = [filepart objectAtIndex:0];
    NSString *extension = [filepart objectAtIndex:1];
    
    // Get the resource path and read the file using NSData
    NSString *filePath = [[NSBundle mainBundle] pathForResource:filename ofType:extension];
    NSData *fileData = [NSData dataWithContentsOfFile:file];
    
    // Determine the MIME type
    NSString *mimeType = @"application/pdf";
    /*
    if ([extension isEqualToString:@"jpg"]) {
        mimeType = @"image/jpeg";
    } else if ([extension isEqualToString:@"png"]) {
        mimeType = @"image/png";
    } else if ([extension isEqualToString:@"doc"]) {
        mimeType = @"application/msword";
    } else if ([extension isEqualToString:@"ppt"]) {
        mimeType = @"application/vnd.ms-powerpoint";
    } else if ([extension isEqualToString:@"html"]) {
        mimeType = @"text/html";
    } else if ([extension isEqualToString:@"pdf"]) {
        mimeType = @"application/pdf";
    }*/
    
    if (mc)
    {
        // Add attachment
        [mc addAttachmentData:fileData mimeType:mimeType fileName:@"JewelryAppraisal.pdf"];
        
        // Present mail view controller on screen
        [self presentViewController:mc animated:YES completion:NULL];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                        message:@"This device cannot send emails"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
}

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            
            //add to saved list of appraisals
            [appdel InsertAppraisal:appdel.currentappraisal];
            [appdel DisplayAlert:@"Email Sent"];
            [appdel TrackEvent:@"Email Sent" properties:NULL];
            
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
    //[self.slidingViewController anchorTopViewTo:ECRight];
    [(MenuViewController*)self.slidingViewController.underLeftViewController GotoViewController:@"Appraisal"];
}

@end
