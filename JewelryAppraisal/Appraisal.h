//
//  Appraisal.h
//  JewelryAppraisal
//
//  Created by Lorne Lantz on 2014-08-03.
//  Copyright (c) 2014 Lorne Lantz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SignatureView.h"

@interface Appraisal : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *dollarvalue;
@property (nonatomic, strong) NSString *description;
@property (nonatomic, strong) NSString *description2;
@property (nonatomic, strong) NSArray *picturesarray;
@property (nonatomic, strong) NSString *businessname;
@property (nonatomic, strong) NSString *appraisername;
@property (nonatomic, strong) NSString *appraisercertification;
@property (nonatomic, strong) NSString *website;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *phonenumber;
@property (nonatomic, strong) SignatureView *signature;
@property (nonatomic, strong) NSString *terms;
@property (nonatomic, strong) NSString *terms_default;
@property (nonatomic, strong) NSNumber *appraisal_key;
@property (nonatomic, strong) NSData *signaturedata;
@property (nonatomic, strong) NSDate *datesaved;

@end
