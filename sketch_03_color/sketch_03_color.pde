import gab.opencv.*;
import processing.video.*;

OpenCV opencv;
Capture video;

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
  image(video,320,0,320,240);

  opencv.loadImage(video);

  opencv.useColor(RGB);
  //tint(255,0,0);
  image(opencv.getSnapshot(opencv.getR()),0,240,320,240);
  //tint(0,255,0);
  image(opencv.getSnapshot(opencv.getG()),320,240,320,240);
  //tint(0,0,255);
  image(opencv.getSnapshot(opencv.getB()),640,240,320,240);
  noTint();
  
  opencv.useColor(HSB);
  image(opencv.getSnapshot(opencv.getH()),  0,480,320,240);
  image(opencv.getSnapshot(opencv.getS()),320,480,320,240);
  image(opencv.getSnapshot(opencv.getV()),640,480,320,240);

}