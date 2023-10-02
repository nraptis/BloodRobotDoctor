//
//  OpenCVWrapper.m
//  BloodRobotDoctor
//
//  Created by Sports Dad on 9/30/23.
//

#import "OpenCVWrapper.hpp"
#import "BloodyMac-Swift.h"
//#import "opencv2/opencv2.h"
//#import "opencv2/opencv.hpp"
#include "OpenCVCPP.hpp"

@implementation OpenCVWrapper

unsigned char *rgbaArrayFromSize(int width, int height) {
    
    if (width <= 0) { return NULL; }
    if (height <= 0) { return NULL; }
    
    unsigned char *result = malloc(width * height * 4 * sizeof(unsigned char));
    
    for (int x=0;x<width;x++) {
        for (int y=0;y<height;y++) {
            int index = (y * width + x) * 4 * sizeof(unsigned char);
            unsigned char red = result[index] = 128;
            unsigned char green = result[index] = 128;
            unsigned char blue = result[index] = 128;
            
            result[index + 0] = red;
            result[index + 1] = green;
            result[index + 2] = blue;
            result[index + 3] = 255;
        }
    }
    return result;
}

RGBImage * rgbImageFromRGBAArray(unsigned char *data, int width, int height) {
    RGBImage *result = [[RGBImage alloc] initWithWidth:width height:height];
    for (int x=0;x<width;x++) {
        for (int y=0;y<height;y++) {
            int index = (y * width + x) * 4 * sizeof(unsigned char);
            unsigned char red = data[index + 0];
            unsigned char green = data[index + 1];
            unsigned char blue = data[index + 2];
            [result setWithX: x y:y red:red green:green blue:blue];
        }
    }
    return result;
}

unsigned char *rgbaArrayFromRGBImage(RGBImage *rgbImage) {
    if (rgbImage == NULL) { return NULL; }
    
    int width = (int)rgbImage.width;
    int height = (int)rgbImage.height;
    
    if (width <= 0) { return NULL; }
    if (height <= 0) { return NULL; }
    
    unsigned char *result = malloc(width * height * 4 * sizeof(unsigned char));
    
    for (int x=0;x<width;x++) {
        for (int y=0;y<height;y++) {
            int index = (y * width + x) * 4 * sizeof(unsigned char);
            unsigned char red = [rgbImage redWithX: x y: y];
            unsigned char green = [rgbImage greenWithX: x y: y];
            unsigned char blue = [rgbImage blueWithX: x y: y];
            
            //NSLog(@"@ [%d %d] (%d %d %d)\n", x, y, red, green, blue);
            
            result[index + 0] = red;
            result[index + 1] = green;
            result[index + 2] = blue;
            result[index + 3] = 255;
        }
    }
    return result;
}


+ (RGBImage *)process:(RGBImage *)rgbImage {
    
    if (rgbImage == NULL) { return NULL; }
    
    int width = (int)rgbImage.width;
    int height = (int)rgbImage.height;
    
    //ANYTHING();
    
    [OpenCVCPP helloDumb];
    
    unsigned char *input = rgbaArrayFromRGBImage(rgbImage);
    unsigned char *output = rgbaArrayFromSize(width, height);
    
    [OpenCVCPP process: input dest: output width: width height: height];
    
    //________process(source, destination, width, height);
    
    //aaa(100);
    
    //opencv::Mat f =
    //auto a = rgbImageToMat(rgbImage);
    
    RGBImage *result = rgbImageFromRGBAArray(output, width, height);
    
    return result;
}

@end

/*
//
//  MatMetalTextuerConverter.m
//  opencv-metal-pipeline
//
//  Created by Bartłomiej Nowak on 25.02.2018.
//  Copyright © 2018 Bartłomiej Nowak. All rights reserved.
//

#import "MatMetalTextureConverter.h"
#import <CoreVideo/CoreVideo.h>

using namespace cv;

@interface MatMetalTextureConverter ()
@property (nonatomic) CVMetalTextureCacheRef cache;
@property (nonatomic, strong) id<MTLDevice> device;
@end

@implementation MatMetalTextureConverter

- (instancetype _Nonnull)initWithProcessor:(ImageProcessor* _Nonnull)processor device:(id<MTLDevice> _Nonnull)device {
    self = [super init];
    if (self) {
        [self setDevice:device];
        
        processor.onMatReady = ^(cv::Mat mat) {
            if ([self onTextureReady]) {
                self.onTextureReady([self textureFromMat:mat]);
            }
        };
    }
    return self;
}

- (id<MTLTexture>)textureFromMat:(cv::Mat)image {

    int imageCols = image.cols;
    int imageRows = image.rows;
    
    UInt8 *convertedRawImage = (UInt8*)calloc(imageRows * image.step * 4, sizeof(UInt8));
    
    int bytesPerPixel = sizeof(UInt8);
    int bytesPerRow = bytesPerPixel * image.step;
    
    UInt8 b, g, r, a;
    
    for (int currRow = 0; currRow < imageRows; currRow++) {
        
        int currRowOffset = (int)image.step.buf[0] * currRow;
        int convertedRowOffset = bytesPerRow * currRow;
        
        UInt8* currRowPtr = (UInt8*)(image.data + currRowOffset);
        
        for (int currCol = 0; currCol < imageCols; currCol++) {
            b = (UInt8)(currRowPtr[4 * currCol]);
            g = (UInt8)(currRowPtr[4 * currCol + 1]);
            r = (UInt8)(currRowPtr[4 * currCol + 2]);
            a = (UInt8)(currRowPtr[4 * currCol + 3]);
            
            convertedRawImage[convertedRowOffset + (4 * currCol)] = b;
            convertedRawImage[convertedRowOffset + (4 * currCol + 1)] = g;
            convertedRawImage[convertedRowOffset + (4 * currCol + 2)] = r;
            convertedRawImage[convertedRowOffset + (4 * currCol + 3)] = a;
        }
    }
    
    id<MTLTexture> texture;
    
    MTLTextureDescriptor *descriptor = [MTLTextureDescriptor texture2DDescriptorWithPixelFormat:MTLPixelFormatBGRA8Unorm
                                                                                          width:imageCols
                                                                                         height:imageRows
                                                                                      mipmapped:NO];
    
    texture = [self.device newTextureWithDescriptor:descriptor];
    
    MTLRegion region = MTLRegionMake2D(0, 0, imageCols, imageRows);
    
    [texture replaceRegion:region mipmapLevel:0 withBytes:convertedRawImage bytesPerRow:bytesPerRow];
    
    free(convertedRawImage);
                                                  
    return texture;
}

@end
*/
