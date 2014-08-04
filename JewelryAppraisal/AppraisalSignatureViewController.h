//
//  AppraisalSignatureViewController.h
//  JewelryAppraisal
//
//  Created by Lorne Lantz on 2014-08-02.
//  Copyright (c) 2014 Lorne Lantz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@class SignatureView;

@interface AppraisalSignatureViewController : UIViewController
- (IBAction)btnClear_Clicked:(id)sender;

- (IBAction)btnMenu_Clicked:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *lblsignature;
@property (strong, nonatomic) IBOutlet UIButton *btnClear;
@property (strong, nonatomic) SignatureView *sigview;
@property (nonatomic, strong) AppDelegate *appdel;

@end
