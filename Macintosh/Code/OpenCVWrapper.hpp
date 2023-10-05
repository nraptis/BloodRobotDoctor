//
//  OpenCVWrapper.h
//  BloodRobotDoctor
//
//  Created by Sports Dad on 9/30/23.
//

#import <Foundation/Foundation.h>

@class RGBImage;

@interface OpenCVWrapper : NSObject

+ (RGBImage *)gaussian:(RGBImage *)rgbImage sizeX: (int) sizeX sizeY: (int) sizeY sigmaX: (float) sigmaX sigmaY: (float) sigmaY;
+ (RGBImage *)gray:(RGBImage *)rgbImage;

+ (RGBImage *)erode:(RGBImage *)rgbImage element: (int)element size: (int) size;
+ (RGBImage *)dilate:(RGBImage *)rgbImage element: (int)element size: (int) size;




/*
if( erosion_elem == 0 ){ erosion_type = MORPH_RECT; }
else if( erosion_elem == 1 ){ erosion_type = MORPH_CROSS; }
else if( erosion_elem == 2) { erosion_type = MORPH_ELLIPSE; }
*/


@end
