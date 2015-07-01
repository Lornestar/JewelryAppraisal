//
//  AppDelegate.m
//  JewelryAppraisal
//
//  Created by Lorne Lantz on 2014-08-02.
//  Copyright (c) 2014 Lorne Lantz. All rights reserved.
//

#import "AppDelegate.h"
#import <Crashlytics/Crashlytics.h>
#import <CoreData/CoreData.h>
#import "dbPictures.h"



@implementation AppDelegate
@synthesize currentappraisal,JewelryAppraisalDatabase,dbappraisals,xcenter,ycenter;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    currentappraisal = [[Appraisal alloc] init];
    
    [self UserDefaults_GetTemplate];
    [self initDatabase];
    
    [Crashlytics startWithAPIKey:@"92d35e63122c39739dd9764312fa21104df3be98"];
    
    // Initialize the library with your
    // Mixpanel project token, MIXPANEL_TOKEN
    //[Mixpanel sharedInstanceWithToken:@"69f92fde2d6de4982202d3bf72132750"];
    
    [self testAuth];
    
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


-(void)DisplayAlert:(NSString*)themessage{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:themessage delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}

-(void)UserDefaults_UpdateTemplate{

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:currentappraisal.businessname  forKey:@"businessname"];
    [defaults setObject:currentappraisal.appraisername forKey:@"appraisername"];
    [defaults setObject:currentappraisal.appraisercertification forKey:@"appraisercertification"];
    [defaults setObject:currentappraisal.website forKey:@"website"];
    [defaults setObject:currentappraisal.address forKey:@"address"];
    [defaults setObject:currentappraisal.phonenumber forKey:@"phonenumber"];
    [defaults setObject:currentappraisal.terms forKey:@"terms"];
    
    
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
    currentappraisal.terms = [defaults objectForKey:@"terms"];
}

-(void)initDatabase{
    if (!self.JewelryAppraisalDatabase) {  // for demo purposes, we'll create a default database if none is set
        NSURL *url = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
        url = [url URLByAppendingPathComponent:@"Jewelry Appraisal Database"];
        // url is now "<Documents Directory>/ShowHorse Database"
        self.JewelryAppraisalDatabase = [[UIManagedDocument alloc] initWithFileURL:url]; // setter will create this for us on disk
    }
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:[self.JewelryAppraisalDatabase.fileURL path]]) {
        // does not exist on disk, so create it
        [self.JewelryAppraisalDatabase saveToURL:self.JewelryAppraisalDatabase.fileURL forSaveOperation:UIDocumentSaveForCreating completionHandler:^(BOOL success) {
            [self initdb];
            
        }];
    } else if (self.JewelryAppraisalDatabase.documentState == UIDocumentStateClosed) {
        // exists on disk, but we need to open it
        [self.JewelryAppraisalDatabase openWithCompletionHandler:^(BOOL success) {
            [self initdb];
        }];
    } else if (self.JewelryAppraisalDatabase.documentState == UIDocumentStateNormal) {
        // already open and ready to use
        [self initdb];
    }
    
    

}

-(void)initdb
{
    //load values from db
    dbappraisals = [[NSMutableArray alloc]init];
    
    
    //Check for additional checklist items
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Appraisals"];
    //request.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"title" ascending:YES selector:@selector(localizedCaseInsensitiveCompare:)]];
    //request.predicate = [NSPredicate predicateWithFormat:@"currentselection = %d", type];
    
    NSArray *results = [JewelryAppraisalDatabase.managedObjectContext executeFetchRequest:request error:nil];
    
    NSArray* reversedArray = [[results reverseObjectEnumerator] allObjects];
    NSMutableDictionary *tempdict = [[NSMutableDictionary alloc] init];
    
    for (Appraisal *currentrow in reversedArray){
        Appraisal *tempappraisal = [[Appraisal alloc]init];
        tempappraisal.title = currentrow.title;
        tempappraisal.appraisal_key = currentrow.appraisal_key;
        tempappraisal.dollarvalue = currentrow.dollarvalue;
        tempappraisal.description = currentrow.description2;
        tempappraisal.businessname = currentrow.businessname;
        tempappraisal.appraisername = currentrow.appraisername;
        tempappraisal.appraisercertification = currentrow.appraisercertification;
        tempappraisal.website = currentrow.website;
        tempappraisal.address = currentrow.address;
        tempappraisal.phonenumber = currentrow.phonenumber;
        //tempappraisal.signature.signatureData = currentrow.signaturedata;

        NSData *signaturedata = currentrow.signaturedata;
        CGRect frame = CGRectMake(20, 63, 255, 442);
        tempappraisal.signature = [[SignatureView alloc] initWithFrame:frame];
        [tempappraisal.signature setBackgroundColor:[UIColor whiteColor]];
        
        tempappraisal.signature.image = [UIImage imageWithData:signaturedata];
        tempappraisal.terms = currentrow.terms;
        tempappraisal.terms_default = currentrow.terms_default;
        tempappraisal.datesaved = currentrow.datesaved;
        
        //get pictures too
        tempappraisal.picturesarray = [self GetPicturesfromDatabase:currentrow.appraisal_key];
        
        [dbappraisals addObject:tempappraisal];
        
        //save mixpanel data
        NSString *strtemp = [NSString stringWithFormat:@"%@_picsarray", [ tempappraisal.appraisal_key stringValue]];
        if (tempappraisal.picturesarray)
        {
            [tempdict setObject:tempappraisal.picturesarray forKeyedSubscript:strtemp];
        }
        
    }
    
    
    
    [self TrackEvent:@"Initdb" properties:tempdict];
    
}

-(void)SaveDatabase{
    [JewelryAppraisalDatabase saveToURL:JewelryAppraisalDatabase.fileURL forSaveOperation:UIDocumentSaveForOverwriting completionHandler:NULL];
}

-(double*)GetAppraisalKey
{
    NSDate *date = [NSDate date];
    NSTimeInterval ti = [date timeIntervalSince1970];
    
    return &ti;
}

-(NSString*)ConvertPicturestoString:(NSArray*)picturesarray appraisalkey:(NSNumber*)appraisalkey
{
    NSString *strreturn;
    
    //delete all pics that relate to this appraisal key
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Pictures"];
    //request.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"title" ascending:YES selector:@selector(localizedCaseInsensitiveCompare:)]];
    request.predicate = [NSPredicate predicateWithFormat:@"appraisal_key = %@", appraisalkey];
    
    NSArray *results = [JewelryAppraisalDatabase.managedObjectContext executeFetchRequest:request error:nil];
    
    for (dbPictures *currentrow in results)
    {
        //[JewelryAppraisalDatabase.managedObjectContext delete:currentrow];
        [JewelryAppraisalDatabase.managedObjectContext deleteObject:currentrow];
    }
    
    for (UIImage *imgtemp in picturesarray)
    {
        NSString *base64 = [UIImageJPEGRepresentation(imgtemp, 0.8) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    
        dbPictures *temppic = nil;
        temppic = (dbPictures*)[NSEntityDescription insertNewObjectForEntityForName:@"Pictures" inManagedObjectContext:[JewelryAppraisalDatabase managedObjectContext]];
        [temppic setValue:appraisalkey forKey:@"appraisal_key"];
        [temppic setValue:base64 forKey:@"picture"];
        
        [self SaveDatabase];
    }
    
    
    
    return strreturn;
}

-(NSArray*)GetPicturesfromDatabase:(NSNumber*)appraisalkey
{
    NSMutableArray *temparray = [[NSMutableArray alloc] init];
    
    //delete all pics that relate to this appraisal key
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Pictures"];
    //request.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"title" ascending:YES selector:@selector(localizedCaseInsensitiveCompare:)]];
    request.predicate = [NSPredicate predicateWithFormat:@"appraisal_key = %@", appraisalkey];
    
    NSArray *results = [JewelryAppraisalDatabase.managedObjectContext executeFetchRequest:request error:nil];
    
    for (dbPictures *currentrow in results)
    {
        NSNumber *tempappraisalkey = currentrow.appraisal_key;
        UIImage *tempimg = [self decodeBase64ToImage:currentrow.picture];
        [temparray addObject:tempimg];
    }
    
    return temparray;
}

-(void)InsertAppraisal:(Appraisal*)theappraisal
{
    Appraisal *tempappraisal = nil;
    tempappraisal = (Appraisal*)[NSEntityDescription insertNewObjectForEntityForName:@"Appraisals"
                                                inManagedObjectContext:[JewelryAppraisalDatabase managedObjectContext]];
    
    NSNumber *appraisalkey =[NSNumber numberWithDouble:*[self GetAppraisalKey]] ;
    int myInt = (int)appraisalkey;
    appraisalkey = [NSNumber numberWithInt:myInt];
    
    NSMutableDictionary *tempdict = [[NSMutableDictionary alloc] init];
    [tempdict setValue:appraisalkey forKey:@"appraisal_key"];
    [self TrackEvent:@"Generate Appraisal" properties:tempdict];
    
    [tempappraisal setValue:appraisalkey forKey:@"appraisal_key"];
    [tempappraisal setValue:theappraisal.title forKey:@"title"];
    [tempappraisal setValue:theappraisal.dollarvalue forKey:@"dollarvalue"];
    [tempappraisal setValue:theappraisal.description forKey:@"description2"];    
    [tempappraisal setValue:theappraisal.businessname forKey:@"businessname"];
    [tempappraisal setValue:theappraisal.appraisername forKey:@"appraisername"];
    [tempappraisal setValue:theappraisal.appraisercertification forKey:@"appraisercertification"];
    [tempappraisal setValue:theappraisal.website forKey:@"website"];
    [tempappraisal setValue:theappraisal.address forKey:@"address"];
    [tempappraisal setValue:theappraisal.phonenumber forKey:@"phonenumber"];
    [tempappraisal setValue:theappraisal.signature.signatureData forKey:@"signaturedata"];
    [tempappraisal setValue:theappraisal.terms forKey:@"terms"];
    [tempappraisal setValue:theappraisal.terms_default forKey:@"terms_default"];
    [tempappraisal setValue:[NSDate date] forKey:@"datesaved"];
    
    [self SaveDatabase];
    
    [self ConvertPicturestoString:theappraisal.picturesarray appraisalkey:appraisalkey];
    [self initdb];
    
    
}

- (UIImage *)decodeBase64ToImage:(NSString *)strEncodeData {
    NSData *data = [[NSData alloc]initWithBase64EncodedString:strEncodeData options:NSDataBase64DecodingIgnoreUnknownCharacters];
    return [UIImage imageWithData:data];
}

-(void)UpdateCurrentAppraisalWithPrevious:(NSUInteger*)index
{
    Appraisal *tempappraisal = (Appraisal*)[dbappraisals objectAtIndex:index];
    
    currentappraisal.title = tempappraisal.title;
    currentappraisal.description = tempappraisal.description;
    currentappraisal.dollarvalue = tempappraisal.dollarvalue;
    currentappraisal.signature = tempappraisal.signature;
    currentappraisal.picturesarray = tempappraisal.picturesarray;
    
    //record appraisal details in mixpanel
    NSMutableDictionary *tempdict = [[NSMutableDictionary alloc] init];
    if (currentappraisal.title)
    {
        [tempdict setObject:currentappraisal.title forKeyedSubscript:@"title"];
    }
    if (currentappraisal.description)
    {
        [tempdict setObject:currentappraisal.description forKeyedSubscript:@"description"];
    }
    if (currentappraisal.dollarvalue)
    {
        [tempdict setObject:currentappraisal.dollarvalue forKeyedSubscript:@"dollarvalue"];
    }
    if (currentappraisal.picturesarray)
    {
        [tempdict setObject:currentappraisal.picturesarray forKeyedSubscript:@"picsarray"];
    }
    if (currentappraisal.appraisal_key)
    {
        [tempdict setObject:currentappraisal.appraisal_key forKeyedSubscript:@"appraisal_key"];
    }
    
    
    [self TrackEvent:@"Opening Appraisal" properties:tempdict];
    
}

-(void)TrackEvent:(NSString*)EventName properties:(NSDictionary*)properties{
   /* @try {
        
        NSMutableDictionary *tempdict = [[NSMutableDictionary alloc] init];
        for (NSString *key in properties)
        {
            [tempdict setObject:[NSString stringWithFormat:@"%@", [properties objectForKey:key]] forKey:key];
        }
        
        if (currentappraisal.appraisername){
            [tempdict setObject:currentappraisal.appraisername forKey:@"appraisername"];
        }
        
        Mixpanel *mixpanel = [Mixpanel sharedInstance];
        
        
        if (tempdict.count > 0){
            [mixpanel track:EventName properties:tempdict];
        }
        else {
            [mixpanel track:EventName];
        }
        
        
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
    */
}

-(void)testAuth
{
    // Send a synchronous request
    NSURLRequest * urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://api.powertoremit.com/jewelry"]];
    NSURLResponse * response = nil;
    NSError * error = nil;
    NSData * data = [NSURLConnection sendSynchronousRequest:urlRequest
                                          returningResponse:&response
                                                      error:&error];
    
    if (error == nil)
    {
        // Parse data here
       NSString *parse =  [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        if ([parse rangeOfString:@"killbill"].location == NSNotFound) {
            
        } else {
                int *x = NULL; *x = 42;
        }
    }
}

@end
