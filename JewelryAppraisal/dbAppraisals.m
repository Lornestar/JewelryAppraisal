//
//  dbAppraisals.m
//  Jewelry Appraisal
//
//  Created by Lorne Lantz on 2014-12-07.
//  Copyright (c) 2014 Lorne Lantz. All rights reserved.
//

#import "dbAppraisals.h"
#import "AppDelegate.h"
#import <CoreData/CoreData.h>

@implementation dbAppraisals
@synthesize list;

-(id)init:(int)type{
    list = [[NSMutableArray alloc]init];
    
    
    //Check for additional checklist items
    AppDelegate *appdel = [UIApplication sharedApplication].delegate;
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"DB_Appraisals"];
    //request.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"title" ascending:YES selector:@selector(localizedCaseInsensitiveCompare:)]];
    //request.predicate = [NSPredicate predicateWithFormat:@"currentselection = %d", type];
    
    NSArray *results = [appdel.JewelryAppraisalDatabase.managedObjectContext executeFetchRequest:request error:nil];
    
    for (Appraisal *currentrow in results){
        Appraisal *tempappraisal = [[Appraisal alloc]init];
        tempappraisal.title = currentrow.title;
        
        [list addObject:tempappraisal];
    }
    
    
    return self;
}

@end
