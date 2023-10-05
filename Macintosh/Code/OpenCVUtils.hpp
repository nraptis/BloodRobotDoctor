//
//  OpenCVUtils.hpp
//  BloodRobotDoctor
//
//  Created by Sports Dad on 9/30/23.
//

#ifndef OpenCVUtils_hpp
#define OpenCVUtils_hpp

//void process(unsigned char *input, unsigned char *output, int width, int height);
//void gaussian(unsigned char *input, unsigned char *output, int width, int height, int size, float sigma);

void gaussian(unsigned char *input, unsigned char *output, int width, int height, int sizeX, int sizeY, float sigmaX, float sigmaY);
void gray(unsigned char *input, unsigned char *output, int width, int height);
void erode(unsigned char *input, unsigned char *output, int width, int height, int element, int size);
void dilate(unsigned char *input, unsigned char *output, int width, int height, int element, int size);

#endif
