//
//  dbAppraisals.h
//  Jewelry Appraisal
//
//  Created by Lorne Lantz on 2014-12-07.
//  Copyright (c) 2014 Lorne Lantz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface dbAppraisals : NSObject

-(id)init:(int)type;
@property (nonatomic, strong) NSMutableArray *list;

@end
