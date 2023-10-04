//
//  OpenCVCPP.h
//  BloodRobotDoctor
//
//  Created by Sports Dad on 9/30/23.
//

#ifndef OPEN_CV_CPP
#define OPEN_CV_CPP

#import <Foundation/Foundation.h>

@interface OpenCVCPP : NSObject

+ (void)process:(unsigned char *)input output: (unsigned char *)output width: (int)width height: (int)height;

+ (void)gaussian:(unsigned char *)input output: (unsigned char *)output width: (int)width height: (int)height size: (int)size sigma: (float) sigma;

@end

#endif
