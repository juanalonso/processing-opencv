import gab.opencv.*;

import org.opencv.core.Core;
import org.opencv.core.CvType;
import org.opencv.core.Mat;
import org.opencv.imgproc.Imgproc;

PImage img;
OpenCV opencv;
Mat opencvR, opencvG, opencvB, opencvA;

void setup() {

  size(640, 480);
  img = loadImage("test.jpg");
  opencv = new OpenCV(this, img, true);  
  
}

void draw() {

  opencv.loadImage(img);

  opencvR = opencv.getR();  
  opencvG = opencv.getG(); 
  opencvB = opencv.getB(); 
  opencvA = opencv.getA(); 
  
  Imgproc.threshold(opencvR, opencvR, map(noise( 0 + frameCount/200.0),0,1,0,255), 255, Imgproc.THRESH_BINARY); 
  Imgproc.threshold(opencvG, opencvG, map(noise(10 + frameCount/200.0),0,1,0,255), 255, Imgproc.THRESH_BINARY); 
  Imgproc.threshold(opencvB, opencvB, map(noise(25 + frameCount/200.0),0,1,0,255), 255, Imgproc.THRESH_BINARY); 
    
  ArrayList<Mat> reordered = new ArrayList<Mat>();
  Mat bgra = new Mat(640, 480, CvType.CV_8UC4);
  
  reordered.add(opencvB);
  reordered.add(opencvG);
  reordered.add(opencvR);
  reordered.add(opencvA);
  Core.merge(reordered, bgra); 
  
  opencv.setColor(bgra);
  
  
  
  image(opencv.getSnapshot(), 0, 0);
    
  image(opencv.getSnapshot(opencvB), 630 - 64 * 1     , 470 - 48, 64, 48);
  image(opencv.getSnapshot(opencvG), 630 - 64 * 2 - 10, 470 - 48, 64, 48);
  image(opencv.getSnapshot(opencvR), 630 - 64 * 3 - 20, 470 - 48, 64, 48);
  
}