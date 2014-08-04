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

-(void)UserDefaults_UpdateTemplate;
-(void)UserDefaults_GetTemplate;

@end
