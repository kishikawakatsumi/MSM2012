//
//  ViewController.m
//  FilterImage
//
//  Created by kishikawa katsumi on 2012/11/03.
//  Copyright (c) 2012 kishikawa katsumi. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSArray *ciFilters = [CIFilter filterNamesInCategory:kCICategoryBuiltIn];
    for (NSString *filter in ciFilters) {
        NSLog(@"filter name %@", filter);
        NSLog(@"filter %@", [[CIFilter filterWithName:filter] attributes]);
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)sepiaTone:(id)sender
{
    EAGLContext *context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    CIContext *coreImageContext = [CIContext contextWithEAGLContext:context];
    CIImage *image = [CIImage imageWithCGImage:_imageView.image.CGImage];
    
    CIFilter *sepiaFilter = [CIFilter filterWithName:@"CISepiaTone"];
    [sepiaFilter setValue:image forKey:kCIInputImageKey];
    [sepiaFilter setValue:[NSNumber numberWithFloat:1.0] forKey:@"inputIntensity"];
    
    CGImageRef cgImage = [coreImageContext createCGImage:sepiaFilter.outputImage fromRect:[sepiaFilter.outputImage extent]];
    UIImage *uiImage = [UIImage imageWithCGImage:cgImage];
    _imageView.image = uiImage;
    CGImageRelease(cgImage);
}

- (IBAction)xray:(id)sender
{
    EAGLContext *context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    CIContext *coreImageContext = [CIContext contextWithEAGLContext:context];
    CIImage *image = [CIImage imageWithCGImage:_imageView.image.CGImage];
    
    CIFilter *sepiaFilter = [CIFilter filterWithName:@"CIXRay"];
    [sepiaFilter setValue:image forKey:kCIInputImageKey];
    
    CGImageRef cgImage = [coreImageContext createCGImage:sepiaFilter.outputImage fromRect:[sepiaFilter.outputImage extent]];
    UIImage *uiImage = [UIImage imageWithCGImage:cgImage];
    _imageView.image = uiImage;
    CGImageRelease(cgImage);
}

@end
