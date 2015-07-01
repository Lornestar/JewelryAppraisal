//
//  SentAppraisalsViewController.m
//  Jewelry Appraisal
//
//  Created by Lorne Lantz on 2014-12-06.
//  Copyright (c) 2014 Lorne Lantz. All rights reserved.
//

#import "SentAppraisalsViewController.h"
#import "ECSlidingViewController.h"
#import "MenuViewController.h"

@interface SentAppraisalsViewController ()

@end

@implementation SentAppraisalsViewController
@synthesize tblview,appdel;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.layer.shadowOpacity = 0.75f;
    self.view.layer.shadowRadius = 10.0f;
    self.view.layer.shadowColor = [UIColor blackColor].CGColor;
    
    
    if (![self.slidingViewController.underLeftViewController isKindOfClass:[MenuViewController class]]) {
        self.slidingViewController.underLeftViewController  = [self.storyboard instantiateViewControllerWithIdentifier:@"Menu"];
    }
    
    
    [self.view addGestureRecognizer:self.slidingViewController.panGesture];

    
    appdel = [UIApplication sharedApplication].delegate;
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

#pragma UITableview

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [appdel.dbappraisals count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
    Appraisal *tempappraisal = (Appraisal*)[appdel.dbappraisals objectAtIndex:indexPath.row];
    
    UILabel *lbltitle = (UILabel *)[cell viewWithTag:100];
    UILabel *lbldate = (UILabel *)[cell viewWithTag:101];
    //UIImageView *imgprofile = (UIImageView*)[cell viewWithTag:103];
    
    lbltitle.text = tempappraisal.title;
    NSString *dateString = [NSDateFormatter localizedStringFromDate:tempappraisal.datesaved
                                                          dateStyle:NSDateFormatterShortStyle
                                                          timeStyle:NSDateFormatterShortStyle];
    lbldate.text = dateString;
    
    return cell;
}

- (IBAction)btnMenu_Clicked:(id)sender {
    [self.slidingViewController anchorTopViewTo:ECRight];
}

- (IBAction)btnopen_clicked:(UIButton*)sender {
    NSIndexPath *indexpath = nil;
    indexpath = [tblview indexPathForRowAtPoint:[tblview convertPoint:sender.center fromView:sender.superview]];
    
    [appdel UpdateCurrentAppraisalWithPrevious:indexpath.row];
    
    [self dismissViewControllerAnimated:YES completion:NULL];
    //[self.slidingViewController anchorTopViewTo:ECRight];
    [(MenuViewController*)self.slidingViewController.underLeftViewController GotoViewController:@"Appraisal"];
}


@end
