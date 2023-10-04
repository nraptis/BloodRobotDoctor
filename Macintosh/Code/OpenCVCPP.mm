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

+ (void)process:(unsigned char *)input output: (unsigned char *)output width: (int)width height: (int)height {
    process(input, output, width, height);
}

+ (void)gaussian:(unsigned char *)input output: (unsigned char *)output width: (int)width height: (int)height size: (int)size sigma: (float) sigma {
    gaussian(input, output, width, height, size, sigma);
}

@end
