//
//  WebPImage.m
//  WebP
//
//  Created by Dmitry Chestnykh on 5/3/11.
//  Copyright 2011 Coding Robots. All rights reserved.
//

#import "WebPImage.h"
#import "webp/decode.h"

CGImageRef GetImageForURL(CFURLRef url)
{
	NSData *fileData = [[NSData alloc] initWithContentsOfURL:(NSURL*)url];
	int width, height;
  uint8_t *buf = WebPDecodeRGBA([fileData bytes], [fileData length], &width, &height);
	if (buf == NULL) {
		NSLog(@"cannot get WebP image data for %@", url);
		return NULL;
	}
  NSData *imageData = [NSData dataWithBytesNoCopy:buf length:width*height*4];
  
  CGColorSpaceRef colorSpace = CGColorSpaceCreateWithName(kCGColorSpaceGenericRGB);
  CGContextRef bitmapContext = CGBitmapContextCreate(
                                                     (void*)[imageData bytes],
                                                     width,
                                                     height,
                                                     8, // bitsPerComponent
                                                     4*width, // bytesPerRow
                                                     colorSpace,
                                                     kCGImageAlphaNoneSkipLast); //kCGImageAlphaLast is not supported
  CGColorSpaceRelease(colorSpace);
  return CGBitmapContextCreateImage(bitmapContext);
}
