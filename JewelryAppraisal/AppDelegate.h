//
//  AppDelegate.h
//  JewelryAppraisal
//
//  Created by Lorne Lantz on 2014-08-02.
//  Copyright (c) 2014 Lorne Lantz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Appraisal.h"


@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) Appraisal *currentappraisal;
@property (nonatomic, strong) UIManagedDocument *JewelryAppraisalDatabase;
@property (nonatomic, strong) NSMutableArray *dbappraisals;
@property (assign, nonatomic) CGFloat xcenter;
@property (assign, nonatomic) CGFloat ycenter;

-(void)UserDefaults_UpdateTemplate;
-(void)UserDefaults_GetTemplate;
-(void)InsertAppraisal:(Appraisal*)theappraisal;
-(void)UpdateCurrentAppraisalWithPrevious:(NSUInteger*)index;
-(void)DisplayAlert:(NSString*)themessage;
-(void)TrackEvent:(NSString*)EventName properties:(NSDictionary*)properties;

@end
