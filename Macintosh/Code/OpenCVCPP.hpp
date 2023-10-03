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

+ (void)process:(unsigned char *)input dest: (unsigned char *)output width: (int)width height: (int)height;

@end

#endif
