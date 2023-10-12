//
//  OpenCVCPP.m
//  BloodRobotDoctor
//
//  Created by Sports Dad on 9/30/23.
//

#import <Foundation/Foundation.h>
#import "OpenCVCPP.hpp"
#import "OpenCVUtils.hpp"

@implementation OpenCVCPP

+ (void)gaussian:(unsigned char *)input output: (unsigned char *)output width: (int)width height: (int)height sizeX: (int) sizeX sizeY: (int) sizeY sigmaX: (float) sigmaX sigmaY: (float) sigmaY {
    gaussian(input, output, width, height, sizeX, sizeY, sigmaX, sigmaY);
}

+ (void)gray:(unsigned char *)input output: (unsigned char *)output width: (int)width height: (int)height {
    gray(input, output, width, height);
}

+ (void)erode:(unsigned char *)input output: (unsigned char *)output width: (int)width height: (int)height element: (int)element size: (int) size {
    erode(input, output, width, height, element, size);
}

+ (void)dilate:(unsigned char *)input output: (unsigned char *)output width: (int)width height: (int)height element: (int)element size: (int) size {
    dilate(input, output, width, height, element, size);
}

@end
