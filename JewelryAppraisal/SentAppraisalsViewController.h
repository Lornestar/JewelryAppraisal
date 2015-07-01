//
//  SentAppraisalsViewController.h
//  Jewelry Appraisal
//
//  Created by Lorne Lantz on 2014-12-06.
//  Copyright (c) 2014 Lorne Lantz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface SentAppraisalsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tblview;
- (IBAction)btnopen_clicked:(id)sender;
- (IBAction)btnMenu_Clicked:(id)sender;

@property (nonatomic, strong) AppDelegate *appdel;

@end
