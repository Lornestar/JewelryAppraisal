//
//  Appraisal.m
//  JewelryAppraisal
//
//  Created by Lorne Lantz on 2014-08-03.
//  Copyright (c) 2014 Lorne Lantz. All rights reserved.
//

#import "Appraisal.h"

@implementation Appraisal

@synthesize title, dollarvalue, description, picturesarray, signature, businessname, appraisercertification, appraisername, website, address, phonenumber, terms, terms_default, appraisal_key, description2, signaturedata, datesaved;

-(id)init{
    //temp
    terms_default = @"I have personally examined the above described article(s) and have found each in good condition unless otherwise noted, and does not require any repairs at this time with the values and description as listed in this appraisal being correct to the best of my knowledge and belief, based on present day market values and accepted appraisal procedures in accordance with the standards of the Gemological Institute of America (GIA). Mountings may prohibit precise observation of gem quality and weight; it must be understood that all data pertaining to mounted gems can only be considered as provisional. Additionally jewelry appraisal and valuation is not an exact science, but a subjective professional viewpoint, estimates of value and quality may necessarily constitute error on the part of the appraiser. Therefore due to the very subjective nature of appraisals and evaluations, statements, and data contained herein cannot be construed as guarantee or warranty. Weight of the stones is approximate unless otherwise indicated. When multiple stones of that same type, measurement and/or weight is and average. Chemical composition of gemstones may determine variety but does not indicate the nature or matrix of creation (synthetic gemstones vs. naturally occurring gemstones made from mined material) unless otherwise stated. Colored stone purchasers should be aware that natural gemstones are processed from the time they are extracted from the earth, by one or more traditionally accepted trade practices. Some gemstones on this appraisal may have been subjected to a stable and possibly undetectable enhancement process. All relevant information will be readily provided to the best of our knowledge. Estimated value is based on quality grade (cut, clarity, color, and carat weight) in conjunction with published market values. This is an appraisal to be used for insurance purposes only. The above is a description and estimated replacement valuation of the item submitted for appraisal. The value was determined by systematic examination of the gems, metal or other materials and the method used and quality of construction. The conclusions drawn are the subjective opinions of these qualities and other estimations. The examination was accomplished using appropriate instruments and tests conducted within the limitations imposed by the make-up of the item. Instruments used: GIA Mark VII Gemolite, DiamondLite (for color/fluoresence), Refractometer, Polariscope, Table Gauge, and Leverage Gauge. The values determined for above described item(s) were based on “The Guide”, by Gemworld International, and Rapaport Diamond pricing guide. This appraisal should not be used as a definitive guide in comparison shopping. Neither this store nor any of its employees assumes any liability with respect to any action that may be taken on the basis of this appraisal. The use of this appraisal in public advertising is forbidden. This appraisal is for replacement evaluations only and is not an offer to purchase. Evaluations do not include sales tax where applicable.";
    return  self;
}

@end
