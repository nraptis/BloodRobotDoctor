//
//  OpenCVUtils.cpp
//  BloodRobotDoctor
//
//  Created by Screwy Uncle Louie on 9/30/23.
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

Mat convertToMat(unsigned char *data, int width, int height) {
    Mat tmp(width, height, CV_8UC1, data);
    /*
    for (int x = 0; x < height; x++) {
        for (int y = 0; y < width; y++) {
            
            int index = (y * width + x) * 4 * sizeof(unsigned char);
            unsigned char red = data[index + 0];
            unsigned char green = data[index + 1];
            unsigned char blue = data[index + 2];
            unsigned char alpha = data[index + 3];
            
            uint32_t rgba = 0;
            rgba |=
            
            tmp.at<uint32_t>()
            printf("@ %d [%d %d %d %d]\n", index, red, green, blue, alpha);
            
            //tmp.at<int32_t>()
            
            //unsigned char  = [rgbImage greenWithX: x y: y];
            //unsigned char  = [rgbImage blueWithX: x y: y];
            
            //int value = (int) buffer[x * width + y];
            //tmp.at<int>(y, x) = value;
        }
    }
    */
    return tmp;
}

void ConvertBaq(Mat m, unsigned char *data, int width, int height) {
    int bytesPerPixel = 4;
    int area = width * height * bytesPerPixel;
    memcpy(data, m.data, area);
}


void hullaDum() {
    
    printf("heya");
    
}

void process(unsigned char *input, unsigned char *output, int width, int height) {
    
    
    Mat matty = convertToMat(input, width, height);
    
    
    //IplImage *aIPLImage = cvCreateImage(cvSize(width, width), 8, 4);
    //IplImageCopy(aIPLImage, input, width, height);
    
    //cv::Mat(1, 1, 0);
    
    //Mat m;
    
    for (int i=0;i<44;i++) {
        output[i] = input[i];
    }
    
    
    // Convert to graycsale

    //Mat img_blur;
    //GaussianBlur(matty, img_blur, Size(3,3), 0);
    //ConvertBaq(img_blur, output, width, height);
    
    
    cv::Mat img2 = cv::Scalar(255, 0, 128) - matty;

    
    //matty = matty.inv();
    
    
    matty.col(3).data[5] = 255;
    matty.col(3).data[6] = 255;
    matty.col(3).data[7] = 255;
    matty.col(3).data[8] = 255;
    matty.col(3).data[9] = 255;
    matty.col(3).data[10] = 255;
    matty.col(3).data[11] = 255;
    matty.col(3).data[12] = 255;
    matty.col(3).data[13] = 255;
    matty.col(3).data[14] = 255;
    
    
    matty.col(32).data[5] = 255;
    matty.col(32).data[6] = 255;
    matty.col(32).data[7] = 255;
    matty.col(32).data[8] = 255;
    matty.col(32).data[9] = 255;
    matty.col(52).data[10] = 255;
    matty.col(52).data[11] = 255;
    matty.col(52).data[12] = 255;
    matty.col(32).data[13] = 255;
    matty.col(32).data[14] = 255;
    matty.col(32).data[15] = 255;
    matty.col(32).data[16] = 255;
    matty.col(32).data[17] = 255;
    matty.col(32).data[18] = 255;
    matty.col(32).data[19] = 255;
    matty.col(32).data[20] = 255;
    matty.col(32).data[21] = 255;
    matty.col(32).data[22] = 255;
    matty.col(32).data[23] = 255;
    matty.col(32).data[24] = 255;
    matty.col(32).data[25] = 255;
    matty.col(32).data[26] = 255;
    matty.col(52).data[27] = 255;
    matty.col(52).data[28] = 255;
    matty.col(52).data[29] = 255;
    
    
    
    
    
    //cv::Mat img3;
    //cv::bitwise_not(matty, img3);
    
    //ConvertBaq(img2, output, width, height);
    ConvertBaq(matty, output, width, height);
    
    
    
    /*
    
    cv::Mat img2 = cv::Scalar(255, 255, 255) - img1;
    cv::imshow("(2)", img2);

    cv::Mat img3;
    cv::bitwise_not(img1, img3);
    cv::imshow("(3)", img3);
    
    */
    
}
