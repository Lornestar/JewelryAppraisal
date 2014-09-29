//
//  AppraisalDetailsViewController.m
//  JewelryAppraisal
//
//  Created by Lorne Lantz on 2014-08-02.
//  Copyright (c) 2014 Lorne Lantz. All rights reserved.
//

#import "AppraisalDetailsViewController.h"
#import "ECSlidingViewController.h"
#import "MenuViewController.h"

@interface AppraisalDetailsViewController ()

#define txtdescriptionstatic @"Description"

@end

@implementation AppraisalDetailsViewController
@synthesize txtDescription,txtDollarValue,txtTitle,appdel;

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
    appdel = [UIApplication sharedApplication].delegate;
    // Do any additional setup after loading the view.
    
    
    
    
    
    //init text values
    if (appdel.currentappraisal.title.length > 0)
    {
        txtTitle.text =appdel.currentappraisal.title;
    }
    
    if (appdel.currentappraisal.dollarvalue.length > 0)
    {
        txtDollarValue.text = appdel.currentappraisal.dollarvalue;
    }
    
    if (appdel.currentappraisal.description.length > 0)
    {
        txtDescription.text = appdel.currentappraisal.description;
    }
    else
    {
        txtDescription.text = txtdescriptionstatic;
        txtDescription.textColor = [UIColor lightGrayColor];
    }
    
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

- (IBAction)txtTitle_Done:(id)sender {
    [txtTitle resignFirstResponder];
    appdel.currentappraisal.title = txtTitle.text;
}

- (IBAction)txtDollarValue_Done:(id)sender {
    [txtDollarValue resignFirstResponder];
    appdel.currentappraisal.dollarvalue = txtDollarValue.text;
}

- (IBAction)btnCloseKeyboard_Clicked:(id)sender {
    [txtDescription resignFirstResponder];
    [txtDollarValue resignFirstResponder];
    [txtTitle resignFirstResponder];
    
    if ([txtDescription.text isEqualToString:@""]) {
        txtDescription.text = txtdescriptionstatic;
        txtDescription.textColor = [UIColor lightGrayColor]; //optional
    }
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:txtdescriptionstatic]) {
        textView.text = @"";
        textView.textColor = [UIColor blackColor]; //optional
    }
    [textView becomeFirstResponder];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@""]) {
        textView.text = txtdescriptionstatic;
        textView.textColor = [UIColor lightGrayColor]; //optional
    }
    [txtDescription resignFirstResponder];
    appdel.currentappraisal.description = txtDescription.text;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range
 replacementText:(NSString *)text
{
    // Any new character added is passed in as the "text" parameter
    if ([text isEqualToString:@"\n"]) {
        // Be sure to test for equality using the "isEqualToString" message
        [textView resignFirstResponder];
        
        // Return FALSE so that the final '\n' character doesn't get added
        return FALSE;
    }
    // For any other character return TRUE so that the text gets added to the view
    return TRUE;
}


@end
