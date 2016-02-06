import gab.opencv.*;
import processing.video.*;
import java.awt.*;

float DETECT_SCALE = 1.1;
int DETECT_MINNEIGHBOURS = 7;
int DETECT_MINSIZE = 0;
int DETECT_MAXSIZE = 0;

OpenCV opencv;
Capture video;
Rectangle[] faces;

void setup() {

  size(512, 512);
  frameRate(30);
  noFill();
  strokeWeight(2);
  stroke(255, 0, 0);
  background(0);

  opencv = new OpenCV(this, 640, 480); 
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);

  video = new Capture(this, 640, 480);
  video.start();
}

void draw() {

  if (video.available() == true) {
    video.read();
  }  

  opencv.loadImage(video);
  faces = opencv.detect(DETECT_SCALE, DETECT_MINNEIGHBOURS, 0, DETECT_MINSIZE, DETECT_MAXSIZE);

  for (int i = 0; i < faces.length; i++) {
    PImage ojo = video.get(faces[i].x, faces[i].y, faces[i].width, faces[i].height);
    int scale = 16 << (int)random(4);
    image(ojo, ((int)random(512/scale)) * scale, ((int)random(512/scale)) * scale, scale, scale);
  }
  
  println(frameRate);

}