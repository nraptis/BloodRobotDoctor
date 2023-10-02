//
//  OpenCVCPP.m
//  BloodRobotDoctor
//
//  Created by Screwy Uncle Louie on 9/30/23.
//

#import <Foundation/Foundation.h>
#import "OpenCVCPP.hpp"
#import "OpenCVUtils.hpp"

@implementation OpenCVCPP

+ (void)process:(unsigned char *)input dest: (unsigned char *)output width: (int)width height: (int)height {
    process(input, output, width, height);
}

@end
