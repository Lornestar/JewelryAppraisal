//
//  AppDelegate.m
//  JewelryAppraisal
//
//  Created by Lorne Lantz on 2014-08-02.
//  Copyright (c) 2014 Lorne Lantz. All rights reserved.
//

#import "AppDelegate.h"


@implementation AppDelegate
@synthesize currentappraisal;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    currentappraisal = [[Appraisal alloc] init];
    
    [self UserDefaults_GetTemplate];
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


-(void)UserDefaults_UpdateTemplate{

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:currentappraisal.businessname  forKey:@"businessname"];
    [defaults setObject:currentappraisal.appraisername forKey:@"appraisername"];
    [defaults setObject:currentappraisal.appraisercertification forKey:@"appraisercertification"];
    [defaults setObject:currentappraisal.website forKey:@"website"];
    [defaults setObject:currentappraisal.address forKey:@"address"];
    [defaults setObject:currentappraisal.phonenumber forKey:@"phonenumber"];
    
    
    [defaults synchronize];
}


-(void)UserDefaults_GetTemplate{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    currentappraisal.businessname = [defaults objectForKey:@"businessname"];
    currentappraisal.appraisername = [defaults objectForKey:@"appraisername"];
    currentappraisal.appraisercertification = [defaults objectForKey:@"appraisercertification"];
    currentappraisal.website = [defaults objectForKey:@"website"];
    currentappraisal.address = [defaults objectForKey:@"address"];
    currentappraisal.phonenumber = [defaults objectForKey:@"phonenumber"];
    
}

@end
