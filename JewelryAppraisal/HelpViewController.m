//
//  HelpViewController.m
//  Jewelry Appraisal
//
//  Created by Lorne Lantz on 2014-12-31.
//  Copyright (c) 2014 Lorne Lantz. All rights reserved.
//

#import "HelpViewController.h"
#import "ECSlidingViewController.h"
#import "MenuViewController.h"

@interface HelpViewController ()

@end

@implementation HelpViewController
@synthesize lblhelp,helptype,btnClose;

- (void)viewDidLoad {
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
    
    
          lblhelp.text =  @"Edit Appraisal: Use this screen to enter details a specific Appraisal. You can enter a description, dollar value, pictures and your signature.\n\nAppraisal Template: Use this screen to enter information about your business that are shown in every appraisal.  For example, your business name, your name, your website, your address etc.\n\nEmail Appraisal: This screen will let you email your customer their custom made appraisal which is attached and in pdf format.\n\nPreview PDF: This screen allows you to see a preview of the generated pdf appraisal.\n\nSent Appraisals: This screen allows you to open appraisals you had previously emailed through the app.\n\nIn the 'Edit Appraisal' screen, the description field can hold additional titles and up to five items.  For the description of each jewelry item you should include: the type of metal, example 14 karat yellow or white gold, the gram or penny weight of the item, the identification of all stones in the item and their approximate carat sizes, clarity and color.  List how those stones are set, for example, prong set, bezel set, channel set.  Try to list visible features of the item.\n\nExample of the description field: \n\n One ladies diamond and 14kt white gold solitaire style engagement ring weighing 2.2 grams.  One (1) prong set, GIA CERTIFIED round brilliant cut diamond weighing 1.00 ct with a clarity of VS2 and a color of G, GIA REPORT #12345678.  The center diamond is set in a four prong head, with a high polish finish on shank.";
    
    
    [lblhelp sizeToFit];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (IBAction)btnMenu:(id)sender {
    [self.slidingViewController anchorTopViewTo:ECRight];
}
@end
