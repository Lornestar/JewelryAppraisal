//
//  HelpViewController.h
//  Jewelry Appraisal
//
//  Created by Lorne Lantz on 2014-12-31.
//  Copyright (c) 2014 Lorne Lantz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HelpViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIButton *btnClose;
@property (strong, nonatomic) IBOutlet UILabel *lblhelp;

- (IBAction)btnMenu:(id)sender;

@property (strong, nonatomic) NSNumber *helptype;
@end
