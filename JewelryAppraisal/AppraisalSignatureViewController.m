//
//  AppraisalSignatureViewController.m
//  JewelryAppraisal
//
//  Created by Lorne Lantz on 2014-08-02.
//  Copyright (c) 2014 Lorne Lantz. All rights reserved.
//

#import "AppraisalSignatureViewController.h"
#import "SignatureView.h"
#import "ECSlidingViewController.h"
#import "MenuViewController.h"
#import "AppraisalViewController.h"

@interface AppraisalSignatureViewController ()

@end

@implementation AppraisalSignatureViewController
@synthesize lblsignature,btnClear,sigview,appdel;


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
    
    
    appdel = [UIApplication sharedApplication].delegate;
    
    
   lblsignature.transform = CGAffineTransformMakeRotation(3.14/2);
    btnClear.transform =CGAffineTransformMakeRotation(3.14/2);
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    CGRect frame = CGRectMake(20, 63, 255, 442);
    //if signature available
    if (appdel.currentappraisal.signature)
    {
        sigview = appdel.currentappraisal.signature;
    }
    else
    {
        sigview = [[SignatureView alloc] initWithFrame:frame];
        [sigview setBackgroundColor:[UIColor whiteColor]];
    }    
    [self.view addSubview:sigview];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    //disable the gestures in the tabbar
    AppraisalViewController *apvc = (AppraisalViewController*)self.parentViewController;
    while ([apvc view].gestureRecognizers.count) {
        [[apvc view] removeGestureRecognizer:[[apvc view].gestureRecognizers objectAtIndex:0]];
    }
}

-(void)viewWillDisappear:(BOOL)animated
{
    appdel.currentappraisal.signature = sigview;
    
    AppraisalViewController *apvc = (AppraisalViewController*)self.parentViewController;
    [apvc.view addGestureRecognizer:self.slidingViewController.panGesture];
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

- (IBAction)btnClear_Clicked:(id)sender {
    [sigview clear];    
}

- (IBAction)btnMenu_Clicked:(id)sender {
    [self.slidingViewController anchorTopViewTo:ECRight];
}

@end
