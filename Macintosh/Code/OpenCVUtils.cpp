//
//  OpenCVUtils.cpp
//  BloodRobotDoctor
//
//  Created by Sports Dad on 9/30/23.
//

#include "OpenCVUtils.hpp"
#include "opencv2/opencv.hpp"
#include <opencv2/core/core_c.h>
#include <opencv2/core/core.hpp>

using namespace cv;

/*



#include <opencv2/imgproc/imgproc_c.h>
#include <opencv2/calib3d/calib3d.hpp>
//#include <opencv2/legacy/compat.hpp>
#include <opencv2/features2d/features2d.hpp>
#include <opencv2/imgproc/imgproc_c.h>
#include <opencv2/calib3d/calib3d.hpp>
#include <opencv2/video/tracking.hpp>

void IplImageCopy(IplImage *pIPLImage, unsigned char *pDestination, int pWidth, int pHeight) {
    
    //let bytesPerPixel = 4
    //let bytesPerRow = width * bytesPerPixel
    
    int bytesPerPixel = 4;
    int aArea = pWidth * pHeight * bytesPerPixel;
    
    unsigned char *aSource = pDestination;
    unsigned char *aDest = (unsigned char *)(pIPLImage->imageData);
    
    for (int i=0;i<aArea;i++) {
        *aDest = *aSource;
        aDest++;
        aSource++;
    }
}
*/

/*
cv::Mat a(int width, int height) {
    cv::Mat result(width, height, CV_8UC1);
    
    
    
    return result;
}
*/


Mat rgbToMatRGBA(unsigned char *data, int width, int height) {
    Mat tmp(width, height, CV_8UC4, data);
    return tmp;
}

void matRGBAToRGB(Mat m, unsigned char *data, int width, int height) {
    int bytesPerPixel = 4;
    int area = width * height * bytesPerPixel;
    memcpy(data, m.data, area);
}

Mat matToGrayscale(Mat mat) {
    Mat result;
    cvtColor(mat, result, COLOR_BGR2GRAY);
    return result;
}

Mat matToRGBA(Mat mat) {
    Mat result;
    cvtColor(mat, result, COLOR_BGR2RGBA);
    return result;
}

void process(unsigned char *input, unsigned char *output, int width, int height) {
    
    
    Mat matty = rgbToMatRGBA(input, width, height);

    
    // Convert to graycsale

    //Mat img_blur;
    //GaussianBlur(matty, img_blur, Size(3,3), 0);
    //ConvertBaq(img_blur, output, width, height);
    
    //Mat odm = convertMatToGrayscale(matty);
    
    
    //Mat gray;
    //cvtColor(matty, gray, COLOR_BGR2GRAY);
    
    matty = matToGrayscale(matty);
    
    cv::Mat contours;
    
    if (rand() % 2 == 0) {
        
        Mat contours;
        //Canny(matty,contours,10,350);
        Canny(matty,contours,6,100);
        
        matty = contours;
    }
    //cv::Canny(matty,contours,10,350);
    
    //matty = matToRGBA(contours);
    
    
    matty = matToRGBA(matty);
    
    
    matRGBAToRGB(matty, output, width, height);
}
