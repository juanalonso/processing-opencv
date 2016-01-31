import gab.opencv.*;
import org.opencv.core.Core;
import org.opencv.core.CvType;
import org.opencv.core.Mat;
import org.opencv.core.Size;
import org.opencv.imgproc.Imgproc;

import processing.video.*;

//PImage img;
Capture video;

OpenCV opencv;
Mat opencvH, opencvS, opencvV;

void setup() {

  size(640, 480);
  //img = loadImage("test.jpg");
  opencv = new OpenCV(this, 640, 480); 

  video = new Capture(this, 640, 480);
  video.start();
}

void draw() {

  if (video.available() == true) {
    video.read();
  }  

  opencv.loadImage(video);
  opencv.useColor(HSB);

  opencvH = opencv.getH();  
  opencvS = opencv.getS(); 
  opencvV = opencv.getV(); 

  float hBlur = map(noise( 0 + frameCount/30.0), 0, 1, 50, 200);
  float sBlur = map(noise(40 + frameCount/10.0), 0, 1, 10, 75);
  float vBlur = map(noise(50 + frameCount/100.0), 0, 1, 1, 75);

  //Imgproc.blur(opencvH, opencvH, new Size(hBlur, hBlur)); 
  //Imgproc.blur(opencvS, opencvS, new Size(sBlur, sBlur)); 
  //Imgproc.blur(opencvV, opencvV, new Size(vBlur,vBlur)); 

  //Imgproc.threshold(opencvH, opencvH, map(noise( 0 + frameCount/100.0), 0, 1, 0, 255), 255, Imgproc.THRESH_BINARY); 
  //Imgproc.threshold(opencvS, opencvS, map(noise(10 + frameCount/100.0), 0, 1, 0, 255), 255, Imgproc.THRESH_BINARY); 
  //Imgproc.threshold(opencvV, opencvV, map(noise(25 + frameCount/100.0), 0, 1, 0, 255), 255, Imgproc.THRESH_BINARY); 


  Imgproc.blur(opencvH, opencvH, new Size(hBlur, hBlur)); 
  Imgproc.blur(opencvS, opencvS, new Size(sBlur, sBlur)); 
  Imgproc.threshold(opencvS, opencvS, map(noise(10 + frameCount/100.0), 0, 1, 0, 255), 255, Imgproc.THRESH_BINARY); 


  /*
  Imgproc.threshold(opencvS, opencvS, map(noise(10 + frameCount/100.0), 0, 1, 0, 255), 255, Imgproc.THRESH_BINARY); 
   Imgproc.threshold(opencvV, opencvV, map(noise(25 + frameCount/100.0), 0, 1, 0, 255), 255, Imgproc.THRESH_BINARY); 
   Imgproc.blur(opencvH, opencvH, new Size(hBlur,hBlur)); 
   */


  ArrayList<Mat> reordered = new ArrayList<Mat>();
  reordered.add(opencvH);
  reordered.add(opencvS);
  reordered.add(opencvV);

  Mat hsv = new Mat(640, 480, CvType.CV_8UC4);
  Core.merge(reordered, hsv); 

  Mat grba = new Mat(640, 480, CvType.CV_8UC3);
  Imgproc.cvtColor(hsv, grba, Imgproc.COLOR_HSV2BGR, 4);

  opencv.useColor(RGB);
  opencv.setColor(grba);

  image(opencv.getSnapshot(), 0, 0);

  image(opencv.getSnapshot(opencvH), 630 - 64 * 3 - 20, 470 - 48, 64, 48);
  image(opencv.getSnapshot(opencvS), 630 - 64 * 2 - 10, 470 - 48, 64, 48);
  image(opencv.getSnapshot(opencvV), 630 - 64 * 1, 470 - 48, 64, 48);
}