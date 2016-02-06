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
  frameRate(30);

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

  float hBlur = map(noise( 0 + frameCount/100.0), 0, 1, 25, 100);
  Imgproc.blur(opencvH, opencvH, new Size(hBlur, hBlur)); 

  Imgproc.blur(opencvS, opencvS, new Size(15,15));

  Imgproc.Canny(opencvV, opencvV, 25, 300);
  Core.bitwise_not(opencvV,opencvV);

  Mat grba = mergeChannels();

  opencv.useColor(RGB);
  opencv.setColor(grba);

  image(opencv.getSnapshot(), 0, 0);
  //saveFrame("frames/#####.tiff");

  //image(opencv.getSnapshot(opencvH), 630 - 64 * 6 - 20, 470 - 48 * 2, 64 * 2, 48 * 2);
  //image(opencv.getSnapshot(opencvS), 630 - 64 * 4 - 10, 470 - 48 * 2, 64 * 2, 48 * 2);
  //image(opencv.getSnapshot(opencvV), 630 - 64 * 2,      470 - 48 * 2, 64 * 2, 48 * 2);
}

Mat mergeChannels() {
  ArrayList<Mat> reordered = new ArrayList<Mat>();
  reordered.add(opencvH);
  reordered.add(opencvS);
  reordered.add(opencvV);

  Mat hsv = new Mat(640, 480, CvType.CV_8UC4);
  Core.merge(reordered, hsv); 

  Mat grba = new Mat(640, 480, CvType.CV_8UC3);
  Imgproc.cvtColor(hsv, grba, Imgproc.COLOR_HSV2BGR, 4);

  return grba;
}
