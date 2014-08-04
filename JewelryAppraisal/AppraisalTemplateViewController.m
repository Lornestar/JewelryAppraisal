//
//  AppraisalTemplateViewController.m
//  JewelryAppraisal
//
//  Created by Lorne Lantz on 2014-08-03.
//  Copyright (c) 2014 Lorne Lantz. All rights reserved.
//

#import "AppraisalTemplateViewController.h"
#import "ECSlidingViewController.h"
#import "MenuViewController.h"

@interface AppraisalTemplateViewController ()

#define txtAppraiserCertificationstatic @"Appraiser's Certification"
#define txtAddressstatic @"Address, City, State, Zip Code"

@end

@implementation AppraisalTemplateViewController
@synthesize txtAddress,txtAppraiserCertification,appdel,txtAppraisersName,txtBusinessName,txtWebsite,txtPhone,vwTextfields;

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
    
    if (appdel.currentappraisal.businessname.length > 0)
    {
        txtBusinessName.text = appdel.currentappraisal.businessname;
    }
    if (appdel.currentappraisal.appraisername.length > 0)
    {
        txtAppraisersName.text = appdel.currentappraisal.appraisername;
    }
    
    if (appdel.currentappraisal.appraisercertification.length > 0)
    {
        txtAppraiserCertification.text = appdel.currentappraisal.appraisercertification;
    }
    else
    {
        txtAppraiserCertification.text = txtAppraiserCertificationstatic;
        txtAppraiserCertification.textColor = [UIColor lightGrayColor];
    }
    
    if (appdel.currentappraisal.website.length > 0)
    {
        txtWebsite.text = appdel.currentappraisal.website;
    }
    if (appdel.currentappraisal.address.length > 0)
    {
        txtAddress.text = appdel.currentappraisal.address;
    }
    else
    {
        txtAddress.text = txtAddressstatic;
        txtAddress.textColor = [UIColor lightGrayColor];
    }
    
    if (appdel.currentappraisal.phonenumber.length > 0)
    {
        txtPhone.text = appdel.currentappraisal.phonenumber;
    }
    
        
}

-(void)viewWillDisappear:(BOOL)animated
{
    appdel.currentappraisal.businessname = txtBusinessName.text;
    appdel.currentappraisal.appraisername = txtAppraisersName.text;
    appdel.currentappraisal.appraisercertification = txtAppraiserCertification.text;
    appdel.currentappraisal.website = txtWebsite.text;
    appdel.currentappraisal.address = txtAddress.text;
    appdel.currentappraisal.phonenumber = txtPhone.text;
    
    [appdel UserDefaults_UpdateTemplate];
}

-(void)ResetTextFields:(int)index
{
    //x,y = 20,67
    
    int x = 160;
    int y = 240;
    
    switch(index)
    {
        case 3:
            y -= 50;
            break;
        case 4:
            y -= 120;
            break;
        case 5:
            y -= 160;
            break;
    }
    vwTextfields.center = CGPointMake(x, y);
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

- (IBAction)txtBusinessName_Done:(id)sender {
}

- (IBAction)txtAppraisersName_Done:(id)sender {
}

- (IBAction)txtWebsite_Done:(id)sender {
}

- (IBAction)txtPhoneNumber_Done:(id)sender {
}

- (IBAction)btnSave_Clicked:(id)sender {
    
}

- (IBAction)btnMenu_Clicked:(id)sender {
    [self.slidingViewController anchorTopViewTo:ECRight];
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    [self ResetTextFields:0];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if ((textField.tag == 100) || (textField.tag == 101))
    {
        [self ResetTextFields:0];
    }
    else if (textField.tag == 103)
    {
        [self ResetTextFields:3];
    }
    else if (textField.tag == 105)
    {
        [self ResetTextFields:5];
    }
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    
    if (textView.tag == 102)
    {
        if ([textView.text isEqualToString:txtAppraiserCertificationstatic]) {
            textView.text = @"";
            textView.textColor = [UIColor blackColor]; //optional
        }
        [textView becomeFirstResponder];
        [self ResetTextFields:2];
    }
    else if (textView.tag == 104)
    {
        if ([textView.text isEqualToString:txtAddressstatic]) {
            textView.text = @"";
            textView.textColor = [UIColor blackColor]; //optional
        }
        [textView becomeFirstResponder];
        [self ResetTextFields:4];
    }
    
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@""]) {
        if (textView.tag == 102)
        {
            txtAppraiserCertification.text = txtAppraiserCertificationstatic;
        }
        else if (textView.tag == 104)
        {
            txtAddress.text = txtAddressstatic;
        }
        textView.textColor = [UIColor lightGrayColor]; //optional
    }
    
    [txtAppraiserCertification resignFirstResponder];
    [txtAddress resignFirstResponder];
    [self ResetTextFields:0];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range
 replacementText:(NSString *)text
{
    // Any new character added is passed in as the "text" parameter
    if ([text isEqualToString:@"\n"]) {
        // Be sure to test for equality using the "isEqualToString" message
        [textView resignFirstResponder];
        [self ResetTextFields:0];
        
        // Return FALSE so that the final '\n' character doesn't get added
        return FALSE;
    }
    // For any other character return TRUE so that the text gets added to the view
    return TRUE;
}

@end
