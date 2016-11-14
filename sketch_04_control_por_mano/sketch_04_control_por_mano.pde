import gab.opencv.*;
import processing.video.*;

import org.opencv.core.Mat;
import org.opencv.core.Core;
import org.opencv.core.Scalar;
import org.opencv.imgproc.Imgproc;

OpenCV opencv;
Capture video;

Mat opencvH, opencvS, opencvV;

ArrayList<Contour> contours;

void setup() {

  size(960, 720);
  background(0);
  
  opencv = new OpenCV(this, 640, 480);

  //String[] cameras = Capture.list();
  //for (int f = 0; f < cameras.length; f++) {
  //    println(f + ": " + cameras[f]);
  //}
    
  video = new Capture(this, 640, 480);
  video.start();

}

void draw() {

  if (video.available() == true) {
    video.read();
  }  
  image(video,0,0,480,360);

  opencv.loadImage(video);
  
  opencv.useColor(HSB);
  opencvH = opencv.getH();  
  opencvS = opencv.getS(); 
  opencvV = opencv.getV();   
 
  Core.inRange(opencvH, new Scalar( 0), new Scalar( 15), opencvH);
  Core.inRange(opencvS, new Scalar(71), new Scalar(131), opencvS);
  Imgproc.erode(opencvH, opencvH, new Mat());
  Imgproc.erode(opencvS, opencvS, new Mat());
  Core.bitwise_and(opencvH, opencvS, opencvV);
 
  image(opencv.getSnapshot(opencv.getH()),  0,360,480,360);
  image(opencv.getSnapshot(opencv.getS()),480,360,480,360);
  image(opencv.getSnapshot(opencv.getV()),480,  0,480,360);
  
  opencv.setGray(opencv.getV());
  contours = opencv.findContours(true, true);

  scale(0.75);
  for (int f=0; f<contours.size(); f++) {
    if (contours.get(f).area() > 8000) {
      contours.get(f).draw();
    }
  }  
  

}