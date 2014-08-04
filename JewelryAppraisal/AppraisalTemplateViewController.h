//
//  AppraisalTemplateViewController.h
//  JewelryAppraisal
//
//  Created by Lorne Lantz on 2014-08-03.
//  Copyright (c) 2014 Lorne Lantz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface AppraisalTemplateViewController : UIViewController <UITextFieldDelegate,UITextViewDelegate>

@property (nonatomic, strong) AppDelegate *appdel;
@property (strong, nonatomic) IBOutlet UITextView *txtAppraiserCertification;
@property (strong, nonatomic) IBOutlet UITextField *txtBusinessName;
@property (strong, nonatomic) IBOutlet UITextField *txtAppraisersName;
@property (strong, nonatomic) IBOutlet UITextField *txtWebsite;
@property (strong, nonatomic) IBOutlet UITextField *txtPhone;
@property (strong, nonatomic) IBOutlet UIView *vwTextfields;
@property (strong, nonatomic) IBOutlet UITextField *txtAddress;

- (IBAction)txtBusinessName_Done:(id)sender;
- (IBAction)txtAppraisersName_Done:(id)sender;
- (IBAction)txtWebsite_Done:(id)sender;
- (IBAction)txtPhoneNumber_Done:(id)sender;
- (IBAction)btnMenu_Clicked:(id)sender;

@end
