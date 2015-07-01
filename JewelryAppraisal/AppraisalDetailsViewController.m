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
#import "HelpViewController.h"

@interface AppraisalDetailsViewController ()

#define txtdescriptionstatic @"Description"

@end

@implementation AppraisalDetailsViewController
@synthesize txtDescription,txtDollarValue,txtTitle,appdel,vwControls;

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
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    appdel.xcenter = *(&screenWidth)/2;
    appdel.ycenter = *(&screenHeight)/2;
    
    
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
    
    UITapGestureRecognizer *taprecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [self.view addGestureRecognizer:taprecognizer];
    
    
}

-(void)tap:(UIGestureRecognizer*)gr
{
    
    [txtDollarValue resignFirstResponder];
    appdel.currentappraisal.dollarvalue = txtDollarValue.text;
    [txtTitle resignFirstResponder];
    appdel.currentappraisal.title = txtTitle.text;
    [self txtdescriptiondone];
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

- (IBAction)btnClear_Appraisal:(id)sender {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Are you sure you want to clear the details, pictures and signature for this appraisal?" delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"Cancel", nil]; [alert show];
}

- (IBAction)btnhelp_Clicked:(id)sender {
    
    HelpViewController *helpoverlayvc = [self.storyboard instantiateViewControllerWithIdentifier:@"help"];
    helpoverlayvc.helptype = [NSNumber numberWithInt:1];
    
    helpoverlayvc.view.layer.position = CGPointMake(appdel.xcenter, appdel.ycenter);
    [self.view addSubview:helpoverlayvc.view];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) { // Set buttonIndex == 0 to handel "Ok"/"Yes" button response
        // Cancel button response
    }
    else{
        appdel.currentappraisal.title = @"";
        appdel.currentappraisal.dollarvalue = @"";
        appdel.currentappraisal.description = @"";
        appdel.currentappraisal.picturesarray = nil;
        appdel.currentappraisal.signature = nil;
        appdel.currentappraisal.appraisal_key = 0;
        
        [(MenuViewController*)self.slidingViewController.underLeftViewController GotoViewController:@"Appraisal"];
    }
    
    
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
    [self ResetTextFields:1];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    // Any new character added is passed in as the "text" parameter
    if ([text isEqualToString:@"\n"]) {
        // Be sure to test for equality using the "isEqualToString" message
        //[textView resignFirstResponder];
        
        if ([txtDescription.text isEqualToString:@""]) {
            [self txtdescriptiondone];
        }
        else
        {
            int location = txtDescription.selectedRange.location;
            NSString *firsthalf = [txtDescription.text substringToIndex:location];
            NSString *secondhalf = [txtDescription.text substringFromIndex:location];
            
            txtDescription.text = [NSString stringWithFormat:@"%@\n%@", firsthalf, secondhalf];
            [txtDescription becomeFirstResponder];
            txtDescription.selectedRange = NSMakeRange(location + 1, 0);
            
        }
        
        // Return FALSE so that the final '\n' character doesn't get added
        return FALSE;
    }
    // For any other character return TRUE so that the text gets added to the view
    return TRUE;
}

-(void)textViewDidChangeSelection:(UITextView *)textView
{
    
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    
    
}

-(void)txtdescriptiondone
{
    if ([txtDescription.text isEqualToString:@""]) {
        txtDescription.text = txtdescriptionstatic;
        txtDescription.textColor = [UIColor lightGrayColor]; //optional
        
    }
    appdel.currentappraisal.description = txtDescription.text;
    [self ResetTextFields:0];
    [txtDescription resignFirstResponder];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void)ResetTextFields:(int)index
{
    //x,y = 20,61
    
    int x = 160;
    int y = 247;
    
    switch(index)
    {
        case 1:
            y -= 130;
            break;
    }
    vwControls.center = CGPointMake(x, y);
}

/*
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
 
 
*/

@end
