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
    
    int yoffset = 0;
    

    //total width 1700
    int xtitle = [self getxcenter:50 thetext:appdel.currentappraisal.businessname];
    
    //business name
    if (appdel.currentappraisal.businessname)
    {
        [self drawText:appdel.currentappraisal.businessname inFrame:CGRectMake(xtitle, 130+yoffset, 1400, 60) fontsize:50.0f];
    }
    
    //appraisal title
    if (appdel.currentappraisal.title)
    {
        xtitle = [self getxcenter:40 thetext:appdel.currentappraisal.title];
        [self drawText:appdel.currentappraisal.title inFrame:CGRectMake(xtitle, 200, 1000, 45) fontsize:40.0f];
    }
    
    //description
    if (appdel.currentappraisal.description)
    {
        [self drawText:appdel.currentappraisal.description inFrame:CGRectMake(100, 620 + yoffset, 1500, 350) fontsize:30.0f];
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
    int currenty = 740;
    for (UIImage *imgtemp in appdel.currentappraisal.picturesarray)
    {
        //loop through images and draw them on
        [self drawImage:imgtemp inRect:CGRectMake(currentx, currenty, width, height)];
        currentx += width + 20;
    }
    
    //replacement value
    if (appdel.currentappraisal.dollarvalue)
    {
        if (appdel.currentappraisal.dollarvalue.length > 0)
        {
            [self drawText:[NSString stringWithFormat:@"Appraised Value: $%@", appdel.currentappraisal.dollarvalue] inFrame:CGRectMake(100, 1360+yoffset, 1400, 200) fontsize:25.0f];
        }
    }
    
    //terms of service
    NSString *terms = appdel.currentappraisal.terms_default;
    if (appdel.currentappraisal.terms.length > 0)
    {
        terms = appdel.currentappraisal.terms;
    }
    [self drawText:terms inFrame:CGRectMake(100, 1560+yoffset, 1400, 300) fontsize:13.0f];
    
    
    //show signature
    if (appdel.currentappraisal.signature)
    {
        UIImage * PortraitImage = [[UIImage alloc] initWithCGImage: appdel.currentappraisal.signature.image.CGImage
                                                             scale: 1.0
                                                       orientation: UIImageOrientationLeft];
        [self drawImage:PortraitImage inRect:CGRectMake(100, 1490, 500, 250) ];
    }
    
    //show appraiser's name
    if (appdel.currentappraisal.appraisername)
    {
        [self drawText:appdel.currentappraisal.appraisername inFrame:CGRectMake(100, 1920, 1400, 100) fontsize:25.0f];
    }
    
    //show today's date
    NSDate *currDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    
    dateFormatter.dateFormat=@"MMMM";
    NSString *monthString = [[dateFormatter stringFromDate:currDate] capitalizedString];
    
    [dateFormatter setDateFormat:@"dd, YYYY"];
    NSString *dateString = [NSString stringWithFormat:@"%@ %@",monthString, [dateFormatter stringFromDate:currDate]];
    [self drawText:dateString inFrame:CGRectMake(1200, 1920, 400, 100) fontsize:25.0f];
    
    //show appraiser's accolades
    if (appdel.currentappraisal.appraisercertification)
    {
        [self drawText:appdel.currentappraisal.appraisercertification inFrame:CGRectMake(100, 2000, 1400, 150) fontsize:20.0f];
    }
    
    //show website
    if (appdel.currentappraisal.website) {
        [self drawText:appdel.currentappraisal.website inFrame:CGRectMake([self getxcenter:20 thetext:appdel.currentappraisal.website], 2100, 1500, 30) fontsize:20.0f];
    }
    
    //show address
    if (appdel.currentappraisal.address)
    {
        [self drawText:appdel.currentappraisal.address inFrame:CGRectMake([self getxcenter:20 thetext:appdel.currentappraisal.address], 2130, 1500, 30) fontsize:20.0f];
    }
    
    //show phone number
    if (appdel.currentappraisal.phonenumber)
    {
        NSString *tempphone;
        if (appdel.currentappraisal.phonenumber.length>6)
        {
            tempphone = [NSString stringWithFormat:@"%@-%@-%@", [appdel.currentappraisal.phonenumber substringToIndex:3], [appdel.currentappraisal.phonenumber substringWithRange:NSMakeRange(4, 3)], [appdel.currentappraisal.phonenumber substringFromIndex:[appdel.currentappraisal.phonenumber length]-4]];
            
        }
        else{
            tempphone = appdel.currentappraisal.phonenumber;
        }
         [self drawText:tempphone inFrame:CGRectMake([self getxcenter:20 thetext:appdel.currentappraisal.phonenumber], 2160, 1500, 30) fontsize:20.0f];
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
