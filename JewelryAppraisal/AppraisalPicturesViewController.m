//
//  AppraisalPicturesViewController.m
//  JewelryAppraisal
//
//  Created by Lorne Lantz on 2014-08-02.
//  Copyright (c) 2014 Lorne Lantz. All rights reserved.
//

#import "AppraisalPicturesViewController.h"
#import "ECSlidingViewController.h"
#import "MenuViewController.h"

@interface AppraisalPicturesViewController ()

@end

@implementation AppraisalPicturesViewController
@synthesize picturesarray,clview,imagePickerDelegate,appdel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    appdel = [UIApplication sharedApplication].delegate;
    // Do any additional setup after loading the view.
    
    //add menubtn & slidemenu
    self.view.layer.shadowOpacity = 0.75f;
    self.view.layer.shadowRadius = 10.0f;
    self.view.layer.shadowColor = [UIColor blackColor].CGColor;
    
    
    if (![self.slidingViewController.underLeftViewController isKindOfClass:[MenuViewController class]]) {
        self.slidingViewController.underLeftViewController  = [self.storyboard instantiateViewControllerWithIdentifier:@"Menu"];
    }
    
    
    [self.view addGestureRecognizer:self.slidingViewController.panGesture];
    
    if (appdel.currentappraisal.picturesarray)
    {
        picturesarray = (NSMutableArray*)appdel.currentappraisal.picturesarray;
    }
    else{
        picturesarray = [[NSMutableArray alloc] init];
    }
}

-(void)viewDidAppear:(BOOL)animated
{

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - collection view data source

- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [picturesarray count] + 1;
}

- (UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    UIButton *btnpic = (UIButton *)[cell viewWithTag:100];
    
    if (indexPath.row == [picturesarray count] )
    {
        //add picture
        
        [btnpic setImage:nil forState:UIControlStateNormal];
        btnpic.titleLabel.text = @"Add Picture";
    }
    else
    {
        UIImage *currentimage = [picturesarray objectAtIndex:indexPath.row];
        [btnpic setImage:currentimage forState:UIControlStateNormal];
    }
    
    return cell;
}



#pragma mark - collection view delegate

-(void)UpdatePictureArray
{
    appdel.currentappraisal.picturesarray = picturesarray;
    [clview reloadData];
}

- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}


- (IBAction)btnPicture_Clicked:(UIButton*)sender {
    UICollectionViewCell *buttonCell = (UICollectionViewCell *)[[sender superview] superview];
    UICollectionView *collectionview = (UICollectionView*)[buttonCell superview];
    NSIndexPath *indexpath = [collectionview indexPathForCell:buttonCell];
    
    if (indexpath.row == [picturesarray count] )
    {
        [self GetPicture];
        //add from camera
        //[self selectImageFromCamera:self];
    }
    else
    {
        //show photo options
        [self PhotoOptions:indexpath.row];
    }
}

- (IBAction)btnMenu_Clicked:(id)sender {
    [self.slidingViewController anchorTopViewTo:ECRight];
}

#pragma mark - Image Methods


-(void)GetPicture
{
    if (!imagePickerDelegate) {
        self.imagePickerDelegate = [[EIImagePickerDelegate alloc] init];
        
        __weak AppraisalPicturesViewController *weakController = self;
        [imagePickerDelegate setImagePickerCompletionBlock:^(UIImage *pickerImage) {
            
            
            //add image to picturearray
            [picturesarray addObject:pickerImage];
            [self UpdatePictureArray];
            
            
            //__strong AppraisalPicturesViewController *strongController = weakController;
            
            //NSLog(@"logical size is %f:%f scale %f", pickerImage.size.width, pickerImage.size.height, pickerImage.scale);
            
            // Use display size to constrain resizing
            // 120 is the logical display size
           /* UIImage *resizedImage = [pickerImage resizedImageWithContentMode:UIViewContentModeScaleAspectFill bounds:CGSizeMake(180, 180) interpolationQuality:kCGInterpolationDefault];
            
            // Use uncompressed size to constrain resizing
            //            UIImage *resizedImage = [pickerImage resizedImageWithUncompressedSizeInMB:1.0 interpolationQuality:kCGInterpolationDefault];
            
            NSLog(@"logical size is %f:%f scale %f", resizedImage.size.width, resizedImage.size.height, resizedImage.scale);
            
            [strongController setOriginalImage:pickerImage resizedImage:resizedImage];
            
            // remove the image if previously saved
            if ([[NSUserDefaults standardUserDefaults] objectForKey:@"savedImage"]) {
                NSString *cachedFilePath = [[NSUserDefaults standardUserDefaults] objectForKey:@"savedImage"];
                [[NSFileManager defaultManager] removeItemAtURL:[NSURL URLWithString:cachedFilePath] error:NULL];
            }
            
            NSString *assetName = [NSString stringWithFormat:@"%@.png", [[NSProcessInfo processInfo]     globallyUniqueString]];
            assetName = [assetName stringByAppendingScaleSuffix]; // add scale suffix to extension
            NSString *assetPath     = [[[NSFileManager defaultManager] cacheDataPath] stringByAppendingPathComponent:assetName];
            
            // saving synchronously
            //            [UIImagePNGRepresentation(resizedImage) writeToFile:assetPath atomically:NO];
            //            [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%@", assetName] forKey:@"savedImage"];
            
            [[EIOperationManager defaultManager] saveImage:resizedImage toPath:assetPath withBlock:^(BOOL success) {
                [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%@", assetName] forKey:@"savedImage"];
            }];*/
            
        }];
    }
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Photo Library", @"Camera", nil];
        actionSheet.tag = -1;
        [actionSheet showInView:self.view];
        
    } else {
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Photo Library", nil];
        actionSheet.tag = -1;
        [actionSheet showInView:self.view];
    }
}

-(void)PhotoOptions:(int)index
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Delete Photo", nil];
    actionSheet.tag = index;
    [actionSheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (actionSheet.tag == -1)
    {
        switch (buttonIndex) {
            case 0:
                [imagePickerDelegate presentFromController:self withSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
                break;
            case 1:
                if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                    [imagePickerDelegate presentFromController:self withSourceType:UIImagePickerControllerSourceTypeCamera];
                }
                break;
            default:
                break;
        }
    }
    else
    {
        //delete photo
        if (buttonIndex == 0)
        {
            [picturesarray removeObjectAtIndex:actionSheet.tag];
            [self UpdatePictureArray];
        }
        
    }
}


@end
