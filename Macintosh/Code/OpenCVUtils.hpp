//
//  OpenCVUtils.hpp
//  BloodRobotDoctor
//
//  Created by Sports Dad on 9/30/23.
//

#ifndef OpenCVUtils_hpp
#define OpenCVUtils_hpp

void process(unsigned char *input, unsigned char *output, int width, int height);

void gaussian(unsigned char *input, unsigned char *output, int width, int height, int size, float sigma);


#endif 
