//
//  AppraisalDetailsViewController.h
//  JewelryAppraisal
//
//  Created by Lorne Lantz on 2014-08-02.
//  Copyright (c) 2014 Lorne Lantz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface AppraisalDetailsViewController : UIViewController <UITextViewDelegate,UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITextField *txtTitle;
@property (strong, nonatomic) IBOutlet UITextField *txtDollarValue;
@property (strong, nonatomic) IBOutlet UITextView *txtDescription;
@property (nonatomic, strong) AppDelegate *appdel;
@property (strong, nonatomic) IBOutlet UIView *vwControls;

- (IBAction)txtTitle_Done:(id)sender;
- (IBAction)txtDollarValue_Done:(id)sender;
- (IBAction)btnCloseKeyboard_Clicked:(id)sender;
- (IBAction)btnMenu_Clicked:(id)sender;
- (IBAction)btnClear_Appraisal:(id)sender;
- (IBAction)btnhelp_Clicked:(id)sender;

@end
