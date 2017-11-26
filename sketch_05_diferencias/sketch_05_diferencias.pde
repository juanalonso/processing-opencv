import gab.opencv.*;
import processing.video.*;

Capture video;
OpenCV opencv;

void setup() {

  size(640, 480);
  colorMode(HSB, 1000);
  strokeWeight(2);
  background(0);

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

  //Aumenta las zonas negras
  //opencv.erode();

  //Aumenta las zonas blancas
  //opencv.dilate();

  //fill(0,0,0,100);
  //noStroke();
  //rect(0,0,640,480);
  //noFill();

  stroke(0,1000,1000);
  //stroke(frameCount % 1000, 1000, 1000);

  for (Contour contour : opencv.findContours (false, true)) {
    contour.draw();
  }
}