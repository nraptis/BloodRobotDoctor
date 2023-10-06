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

void gaussian(unsigned char *input, unsigned char *output, int width, int height, int sizeX, int sizeY, float sigmaX, float sigmaY) {
    
    if (width <= 0 || height <= 0) {
        int area = 4 * width * height;
        memcpy(output, input, area);
        return;
    }
    
    if (sizeX < 0) { sizeX = 0; }
    if (sizeY < 0) { sizeY = 0; }
    
    Mat rgbaInputMat = rgbToMatRGBA(input, width, height);
    
    sizeX = sizeX * 2 + 1;
    sizeY = sizeY * 2 + 1;
    
    Mat rgbaOutputMat;
    GaussianBlur(rgbaInputMat, rgbaOutputMat, Size(sizeX, sizeY), sigmaX, sigmaY);
    rgbaOutputMat = matToRGBA(rgbaOutputMat);
    matRGBAToRGB(rgbaOutputMat, output, width, height);
    
    /*
    if (sizeX <= 0 || sizeY <= 0) {
        int area = 4 * width * height;
        memcpy(output, input, area);
    } else {
        
        Mat rgbaInputMat = rgbToMatRGBA(input, width, height);
        
        sizeX = sizeX * 2 + 1;
        sizeY = sizeY * 2 + 1;
        
        Mat rgbaOutputMat;
        GaussianBlur(rgbaInputMat, rgbaOutputMat, Size(sizeX, sizeY), sigmaX, sigmaY);
        rgbaOutputMat = matToRGBA(rgbaOutputMat);
        matRGBAToRGB(rgbaOutputMat, output, width, height);
    }
    */
}

void gray(unsigned char *input, unsigned char *output, int width, int height) {
    if (width <= 0 || height <= 0) {
        int area = 4 * width * height;
        memcpy(output, input, area);
        return;
    }
    Mat rgbaInputMat = rgbToMatRGBA(input, width, height);
    Mat rgbaOutputMat = matToGrayscale(rgbaInputMat);
    rgbaOutputMat = matToRGBA(rgbaOutputMat);
    matRGBAToRGB(rgbaOutputMat, output, width, height);
}

void erodeOrDilate(unsigned char *input, unsigned char *output, int width, int height, int element, int size, bool isErode) {
    if (width <= 0 || height <= 0 || size <= 0) {
        int area = 4 * width * height;
        memcpy(output, input, area);
        return;
    }
    Mat rgbaInputMat = rgbToMatRGBA(input, width, height);
    //rgbaInputMat = matToGrayscale(rgbaInputMat);
    
    int type = MORPH_RECT;
    if (element == 1) { type = MORPH_CROSS; }
    if (element == 2) { type = MORPH_ELLIPSE; }
    
    Mat structuringElement = getStructuringElement(type,
                                                   Size(2 * size + 1, 2 * size + 1 ),
                                                   Point(size, size));
    
    Mat rgbaOutputMat;
    if (isErode) {
        erode(rgbaInputMat, rgbaOutputMat, structuringElement);
    } else {
        dilate(rgbaInputMat, rgbaOutputMat, structuringElement);
    }
    
    rgbaOutputMat = matToRGBA(rgbaOutputMat);
    matRGBAToRGB(rgbaOutputMat, output, width, height);
    
    rgbaOutputMat = matToRGBA(rgbaOutputMat);
    matRGBAToRGB(rgbaOutputMat, output, width, height);
}

void erode(unsigned char *input, unsigned char *output, int width, int height, int element, int size) {
    erodeOrDilate(input, output, width, height, element, size, true);
}

void dilate(unsigned char *input, unsigned char *output, int width, int height, int element, int size) {
    erodeOrDilate(input, output, width, height, element, size, false);
}
