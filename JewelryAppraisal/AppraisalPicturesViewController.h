//
//  AppraisalPicturesViewController.h
//  JewelryAppraisal
//
//  Created by Lorne Lantz on 2014-08-02.
//  Copyright (c) 2014 Lorne Lantz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EIImagePickerDelegate.h"
#import "AppDelegate.h"

@interface AppraisalPicturesViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate,UIActionSheetDelegate>

@property (strong, nonatomic) IBOutlet UICollectionView *clview;
@property (nonatomic, strong) AppDelegate *appdel;
@property (strong, nonatomic) NSMutableArray *picturesarray;

@property (nonatomic, strong) EIImagePickerDelegate *imagePickerDelegate;

- (IBAction)btnPicture_Clicked:(id)sender;
- (IBAction)btnMenu_Clicked:(id)sender;

@end
