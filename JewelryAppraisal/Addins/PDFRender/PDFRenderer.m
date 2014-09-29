//
//  PDFRenderer.m
//  iOSPDFRenderer
//
//  Created by Tope on 24/11/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "PDFRenderer.h"
#import "CoreText/CoreText.h"
#import <CoreText/CoreText.h>
#import "AppDelegate.h"

@implementation PDFRenderer


+(void)drawPDF:(NSString*)fileName
{
    AppDelegate *appdel = [UIApplication sharedApplication].delegate;
    
    // Create the PDF context using the default page size of 612 x 792.
    UIGraphicsBeginPDFContextToFile(fileName, CGRectZero, nil);
    // Mark the beginning of a new page.
    UIGraphicsBeginPDFPageWithInfo(CGRectMake(0, 0, 1700, 2200), nil);
    
    /*[self drawText:@"Hello World" inFrame:CGRectMake(0, 0, 300, 50)];
    
    [self drawLabels];
    [self drawLogo];
    
    int xOrigin = 50;
    int yOrigin = 300;
    
    int rowHeight = 50;
    int columnWidth = 120;
    
    int numberOfRows = 7;
    int numberOfColumns = 4;
    
    [self drawTableAt:CGPointMake(xOrigin, yOrigin) withRowHeight:rowHeight andColumnWidth:columnWidth andRowCount:numberOfRows andColumnCount:numberOfColumns];
    
    [self drawTableDataAt:CGPointMake(xOrigin, yOrigin) withRowHeight:rowHeight andColumnWidth:columnWidth andRowCount:numberOfRows andColumnCount:numberOfColumns];*/
    
    int yoffset = 200;
    

    //total width 1700
    int xtitle = [self getxcenter:50 thetext:appdel.currentappraisal.businessname];
    
    //business name
    if (appdel.currentappraisal.businessname)
    {
        [self drawText:appdel.currentappraisal.businessname inFrame:CGRectMake(xtitle, 150+yoffset, 1400, 230) fontsize:50.0f];
    }
    
    //appraisal title
    if (appdel.currentappraisal.title)
    {
        [self drawText:appdel.currentappraisal.title inFrame:CGRectMake(100, 440, 1000, 30) fontsize:30.0f];
    }
    
    //description
    if (appdel.currentappraisal.description)
    {
        [self drawText:appdel.currentappraisal.description inFrame:CGRectMake(100, 480 + yoffset, 1500, 350) fontsize:25.0f];
    }
    
    //draw images
    int width = 350;
    int height = 350;
    
    if ([appdel.currentappraisal.picturesarray count] > 3)
    {
        //more than 3, must do smaller size
        if ([appdel.currentappraisal.picturesarray count] == 4)
        {
            width = 250;
            height = 250;
        }
        else if ([appdel.currentappraisal.picturesarray count] == 5)
        {
            width = 200;
            height = 200;
        }
        else if ([appdel.currentappraisal.picturesarray count] == 6)
        {
            width = 160;
            height = 160;
        }
    }
    
    int currentx = 100;
    int currenty = 560;
    for (UIImage *imgtemp in appdel.currentappraisal.picturesarray)
    {
        //loop through images and draw them on
        [self drawImage:imgtemp inRect:CGRectMake(currentx, currenty, width, height)];
        currentx += width + 20;
    }
    
    //replacement value
    if (appdel.currentappraisal.dollarvalue)
    {
        [self drawText:[NSString stringWithFormat:@"Appraised Value: $%@", appdel.currentappraisal.dollarvalue] inFrame:CGRectMake(100, 950+yoffset, 1400, 200) fontsize:25.0f];
    }
    
    //terms of service
    NSString *terms = @"I have personally examined the above described article(s) and have found each in good condition unless otherwise noted, and does not require any repairs at this time with the values and description as listed in this appraisal being correct to the best of my knowledge and belief, based on present day market values and accepted appraisal procedures in accordance with the standards of the Gemological Institute of America (GIA). Mountings may prohibit precise observation of gem quality and weight; it must be understood that all data pertaining to mounted gems can only be considered as provisional. Additionally jewelry appraisal and valuation is not an exact science, but a subjective professional viewpoint, estimates of value and quality may necessarily constitute error on the part of the appraiser. Therefore due to the very subjective nature of appraisals and evaluations, statements, and data contained herein cannot be construed as guarantee or warranty. Weight of the stones is approximate unless otherwise indicated. When multiple stones of that same type, measurement and/or weight is and average. Chemical composition of gemstones may determine variety but does not indicate the nature or matrix of creation (synthetic gemstones vs. naturally occurring gemstones made from mined material) unless otherwise stated. Colored stone purchasers should be aware that natural gemstones are processed from the time they are extracted from the earth, by one or more traditionally accepted trade practices. Some gemstones on this appraisal may have been subjected to a stable and possibly undetectable enhancement process. All relevant information will be readily provided to the best of our knowledge. Estimated value is based on quality grade (cut, clarity, color, and carat weight) in conjunction with published market values. This is an appraisal to be used for insurance purposes only. The above is a description and estimated replacement valuation of the item submitted for appraisal. The value was determined by systematic examination of the gems, metal or other materials and the method used and quality of construction. The conclusions drawn are the subjective opinions of these qualities and other estimations. The examination was accomplished using appropriate instruments and tests conducted within the limitations imposed by the make-up of the item. Instruments used: GIA Mark VII Gemolite, DiamondLite (for color/fluoresence), Refractometer, Polariscope, Table Gauge, and Leverage Gauge. The values determined for above described item(s) were based on “The Guide”, by Gemworld International, and Rapaport Diamond pricing guide. This appraisal should not be used as a definitive guide in comparison shopping. Neither this store nor any of its employees assumes any liability with respect to any action that may be taken on the basis of this appraisal. The use of this appraisal in public advertising is forbidden. This appraisal is for replacement evaluations only and is not an offer to purchase. Evaluations do not include sales tax where applicable.";
    [self drawText:terms inFrame:CGRectMake(100, 1100+yoffset, 1400, 300) fontsize:13.0f];
    
    
    //show signature
    if (appdel.currentappraisal.signature)
    {
        UIImage * PortraitImage = [[UIImage alloc] initWithCGImage: appdel.currentappraisal.signature.image.CGImage
                                                             scale: 1.0
                                                       orientation: UIImageOrientationLeft];
        [self drawImage:PortraitImage inRect:CGRectMake(100, 1220, 600, 400) ];
    }
    
    //show appraiser's name
    if (appdel.currentappraisal.appraisername)
    {
        [self drawText:appdel.currentappraisal.appraisername inFrame:CGRectMake(100, 1850, 1400, 100) fontsize:25.0f];
    }
    
    //show today's date
    NSDate *currDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    
    dateFormatter.dateFormat=@"MMMM";
    NSString *monthString = [[dateFormatter stringFromDate:currDate] capitalizedString];
    
    [dateFormatter setDateFormat:@"MM YYYY"];
    NSString *dateString = [NSString stringWithFormat:@"%@ %@",monthString, [dateFormatter stringFromDate:currDate]];
    [self drawText:dateString inFrame:CGRectMake(1000, 1850, 400, 100) fontsize:25.0f];
    
    //show appraiser's accolades
    if (appdel.currentappraisal.appraisercertification)
    {
        [self drawText:appdel.currentappraisal.appraisercertification inFrame:CGRectMake(100, 2000, 1400, 150) fontsize:20.0f];
    }
    
    //show website
    if (appdel.currentappraisal.website) {
        [self drawText:appdel.currentappraisal.website inFrame:CGRectMake([self getxcenter:20 thetext:appdel.currentappraisal.website], 2100, 400, 30) fontsize:20.0f];
    }
    
    //show address
    if (appdel.currentappraisal.address)
    {
        [self drawText:appdel.currentappraisal.address inFrame:CGRectMake([self getxcenter:20 thetext:appdel.currentappraisal.address], 2130, 400, 30) fontsize:20.0f];
    }
    
    //show phone number
    if (appdel.currentappraisal.phonenumber)
    {
        [self drawText:appdel.currentappraisal.phonenumber inFrame:CGRectMake([self getxcenter:20 thetext:appdel.currentappraisal.phonenumber], 2160, 400, 30) fontsize:20.0f];
    }
    
    
    // Close the PDF context and write the contents out.
    UIGraphicsEndPDFContext();
}


+(void)drawPDFOld:(NSString*)fileName
{
    // Create the PDF context using the default page size of 612 x 792.
    UIGraphicsBeginPDFContextToFile(fileName, CGRectZero, nil);
    // Mark the beginning of a new page.
    UIGraphicsBeginPDFPageWithInfo(CGRectMake(0, 0, 612, 792), nil);
    
    [self drawText:@"Hello World" inFrame:CGRectMake(0, 0, 300, 50)];
    
    CGPoint from = CGPointMake(0, 0);
    CGPoint to = CGPointMake(200, 300);
    [PDFRenderer drawLineFromPoint:from toPoint:to];
    
    UIImage* logo = [UIImage imageNamed:@"ray-logo.png"];
    CGRect frame = CGRectMake(20, 100, 300, 60);
    
    [PDFRenderer drawImage:logo inRect:frame];
    
    [self drawLabels];
    [self drawLogo];
    
    // Close the PDF context and write the contents out.
    UIGraphicsEndPDFContext();
}

+(void)drawText
{
    
    NSString* textToDraw = @"Hello World";
    CFStringRef stringRef = (__bridge CFStringRef)textToDraw;
    // Prepare the text using a Core Text Framesetter
    CFAttributedStringRef currentText = CFAttributedStringCreate(NULL, stringRef, NULL);
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString(currentText);
    
    
    CGRect frameRect = CGRectMake(0, 0, 300, 50);
    CGMutablePathRef framePath = CGPathCreateMutable();
    CGPathAddRect(framePath, NULL, frameRect);
    
    // Get the frame that will do the rendering.
    CFRange currentRange = CFRangeMake(0, 0);
    CTFrameRef frameRef = CTFramesetterCreateFrame(framesetter, currentRange, framePath, NULL);
    CGPathRelease(framePath);
    
    // Get the graphics context.
    CGContextRef    currentContext = UIGraphicsGetCurrentContext();
    
    // Put the text matrix into a known state. This ensures
    // that no old scaling factors are left in place.
    CGContextSetTextMatrix(currentContext, CGAffineTransformIdentity);
    
    
    // Core Text draws from the bottom-left corner up, so flip
    // the current transform prior to drawing.
    CGContextTranslateCTM(currentContext, 0, 100);
    CGContextScaleCTM(currentContext, 1.0, -1.0);
    
    // Draw the frame.
    CTFrameDraw(frameRef, currentContext);
    
    CFRelease(frameRef);
    CFRelease(stringRef);
    CFRelease(framesetter);
}

+(void)drawLineFromPoint:(CGPoint)from toPoint:(CGPoint)to
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(context, 2.0);
    
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    
    CGFloat components[] = {0.2, 0.2, 0.2, 0.3};
    
    CGColorRef color = CGColorCreate(colorspace, components);
    
    CGContextSetStrokeColorWithColor(context, color);
    
    
    CGContextMoveToPoint(context, from.x, from.y);
    CGContextAddLineToPoint(context, to.x, to.y);
    
    CGContextStrokePath(context);
    CGColorSpaceRelease(colorspace);
    CGColorRelease(color);
    
}


+(void)drawImage:(UIImage*)image inRect:(CGRect)rect
{

    [image drawInRect:rect];

}

+(void)drawText:(NSString*)textToDraw inFrame:(CGRect)frameRect fontsize:(CGFloat)fontsize
{
    
    CFStringRef stringRef = (__bridge CFStringRef)textToDraw;
    // Prepare the text using a Core Text Framesetter
    CFAttributedStringRef currentText = CFAttributedStringCreate(NULL, stringRef, NULL);
    
    CTFontRef font = CTFontCreateWithName((CFStringRef)@"Arial", fontsize, nil);
    CFAttributedStringSetAttribute(currentText,CFRangeMake(0, textToDraw.length), kCTFontAttributeName, font);

    
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString(currentText);
    
    
    CGMutablePathRef framePath = CGPathCreateMutable();
    CGPathAddRect(framePath, NULL, frameRect);
    
    // Get the frame that will do the rendering.
    CFRange currentRange = CFRangeMake(0, 0);
    CTFrameRef frameRef = CTFramesetterCreateFrame(framesetter, currentRange, framePath, NULL);
    CGPathRelease(framePath);
    
    // Get the graphics context.
    CGContextRef    currentContext = UIGraphicsGetCurrentContext();
    
    // Put the text matrix into a known state. This ensures
    // that no old scaling factors are left in place.
    CGContextSetTextMatrix(currentContext, CGAffineTransformIdentity);
    
    
    // Core Text draws from the bottom-left corner up, so flip
    // the current transform prior to drawing.
    CGContextTranslateCTM(currentContext, 0, frameRect.origin.y*2);
    CGContextScaleCTM(currentContext, 1.0, -1.0);
    
    //CGContextSetFontSize(currentContext, 40);

    CGContextSetFillColorWithColor(currentContext, [UIColor lightGrayColor].CGColor);
    
    // Draw the frame.
    CTFrameDraw(frameRef, currentContext);
    
    CGContextScaleCTM(currentContext, 1.0, -1.0);
    CGContextTranslateCTM(currentContext, 0, (-1)*frameRect.origin.y*2);
    
    
    CFRelease(frameRef);
    CFRelease(stringRef);
    CFRelease(framesetter);
}


+(void)drawLabels
{
    
    NSArray* objects = [[NSBundle mainBundle] loadNibNamed:@"InvoiceView" owner:nil options:nil];
    
    UIView* mainView = [objects objectAtIndex:0];
    
    for (UIView* view in [mainView subviews]) {
        if([view isKindOfClass:[UILabel class]])
        {
            UILabel* label = (UILabel*)view;
            

            [self drawText:label.text inFrame:label.frame];
        }
    }
    
}


+(void)drawLogo
{
    
    NSArray* objects = [[NSBundle mainBundle] loadNibNamed:@"InvoiceView" owner:nil options:nil];
    
    UIView* mainView = [objects objectAtIndex:0];
    
    for (UIView* view in [mainView subviews]) {
        if([view isKindOfClass:[UIImageView class]])
        {
            
            UIImage* logo = [UIImage imageNamed:@"ray-logo.png"];
            [self drawImage:logo inRect:view.frame];
        }
    }
    
}


+(void)drawTableAt:(CGPoint)origin 
    withRowHeight:(int)rowHeight 
   andColumnWidth:(int)columnWidth 
      andRowCount:(int)numberOfRows 
   andColumnCount:(int)numberOfColumns

{
   
    for (int i = 0; i <= numberOfRows; i++) {
        
        int newOrigin = origin.y + (rowHeight*i);
        
        
        CGPoint from = CGPointMake(origin.x, newOrigin);
        CGPoint to = CGPointMake(origin.x + (numberOfColumns*columnWidth), newOrigin);
        
        [self drawLineFromPoint:from toPoint:to];
        
        
    }
    
    for (int i = 0; i <= numberOfColumns; i++) {
        
        int newOrigin = origin.x + (columnWidth*i);
        
        
        CGPoint from = CGPointMake(newOrigin, origin.y);
        CGPoint to = CGPointMake(newOrigin, origin.y +(numberOfRows*rowHeight));
        
        [self drawLineFromPoint:from toPoint:to];
        
        
    }
}

+(void)drawTableDataAt:(CGPoint)origin 
    withRowHeight:(int)rowHeight 
   andColumnWidth:(int)columnWidth 
      andRowCount:(int)numberOfRows 
   andColumnCount:(int)numberOfColumns
{
    int padding = 10; 
    
    NSArray* headers = [NSArray arrayWithObjects:@"Quantity", @"Description", @"Unit price", @"Total", nil];
    NSArray* invoiceInfo1 = [NSArray arrayWithObjects:@"1", @"Development", @"$1000", @"$1000", nil];
    NSArray* invoiceInfo2 = [NSArray arrayWithObjects:@"1", @"Development", @"$1000", @"$1000", nil];
    NSArray* invoiceInfo3 = [NSArray arrayWithObjects:@"1", @"Development", @"$1000", @"$1000", nil];
    NSArray* invoiceInfo4 = [NSArray arrayWithObjects:@"1", @"Development", @"$1000", @"$1000", nil];
    
    NSArray* allInfo = [NSArray arrayWithObjects:headers, invoiceInfo1, invoiceInfo2, invoiceInfo3, invoiceInfo4, nil];
    
    for(int i = 0; i < [allInfo count]; i++)
    {
        NSArray* infoToDraw = [allInfo objectAtIndex:i];
        
        for (int j = 0; j < numberOfColumns; j++) 
        {
            
            int newOriginX = origin.x + (j*columnWidth);
            int newOriginY = origin.y + ((i+1)*rowHeight);
            
            CGRect frame = CGRectMake(newOriginX + padding, newOriginY + padding, columnWidth, rowHeight);
            
            
            [self drawText:[infoToDraw objectAtIndex:j] inFrame:frame];
        }
        
    }
    
}

+(int)getxcenter:(int)fontsize thetext:(NSString*)thetext
{
    int thereturn = 850 - ([thetext length] * (fontsize/2.4))/2;
    return thereturn;
}

@end
