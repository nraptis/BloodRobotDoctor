//
//  OpenCVWrapper.h
//  BloodRobotDoctor
//
//  Created by Sports Dad on 9/30/23.
//

#import <Foundation/Foundation.h>

@class RGBImage;

@interface OpenCVWrapper : NSObject

+ (RGBImage *)process:(RGBImage *)rgbImage;

@end