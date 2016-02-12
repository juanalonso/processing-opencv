import gab.opencv.*;
import processing.video.*;

Capture video;
OpenCV opencv;
PImage decayFrames;

void setup() {

  size(640, 480);
  colorMode(HSB, 1000);
  strokeWeight(2);
  
  decayFrames = new PImage(640, 480, ALPHA);

  video = new Capture(this, 640, 480);
  video.start();

  opencv = new OpenCV(this, 640, 480);
  opencv.startBackgroundSubtraction(5, 3, 0.5);
}



void draw() {

  if (video.available() == true) {
    video.read();
  }  

  opencv.loadImage(video);
  opencv.updateBackground();

  image(video, 0, 0, 640, 480);

  //opencv.dilate();
  //opencv.erode();

  //fill(0,100);
  //noStroke();
  //rect(0,0,640,480);
  //stroke(frameCount % 1000, 1000, 1000);
  
  noFill();
  stroke(0,1000,1000);
  
  for (Contour contour : opencv.findContours (false, true)) {
    contour.draw();
  }
}