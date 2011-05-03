#import <Foundation/Foundation.h>
#include <CoreFoundation/CoreFoundation.h>
#include <CoreServices/CoreServices.h>
#include <QuickLook/QuickLook.h>
#import "WebPImage.h"

/* -----------------------------------------------------------------------------
   Generate a preview for file

   This function's job is to create preview for designated file
   ----------------------------------------------------------------------------- */

OSStatus GeneratePreviewForURL(void *thisInterface, QLPreviewRequestRef preview, CFURLRef url, CFStringRef contentTypeUTI, CFDictionaryRef options)
{
  CGImageRef image = GetImageForURL(url);
  if (image == NULL) {
    return -1;
  }  
	CGFloat width = CGImageGetWidth(image);
	CGFloat height = CGImageGetHeight(image);
  NSDictionary *newOpt = [NSDictionary dictionaryWithObjectsAndKeys:(NSString *)[(NSDictionary *)options objectForKey:(NSString *)kQLPreviewPropertyDisplayNameKey], kQLPreviewPropertyDisplayNameKey, [NSNumber numberWithFloat:width], kQLPreviewPropertyWidthKey, [NSNumber numberWithFloat:height], kQLPreviewPropertyHeightKey, nil];
	CGContextRef ctx = QLPreviewRequestCreateContext(preview, CGSizeMake(width, height), YES, (CFDictionaryRef)newOpt);
  CGContextDrawImage(ctx, CGRectMake(0,0,width,height), image);
  QLPreviewRequestFlushContext(preview, ctx);
  CGImageRelease(image);
	CGContextRelease(ctx);
	return noErr;
}

void CancelPreviewGeneration(void* thisInterface, QLPreviewRequestRef preview)
{
    // implement only if supported
}
