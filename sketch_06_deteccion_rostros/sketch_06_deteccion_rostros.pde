import gab.opencv.*;
import processing.video.*;
import java.awt.*;

float DETECT_SCALE = 1.2;
int DETECT_MINNEIGHBOURS = 7;
int DETECT_MINSIZE = 0;
int DETECT_MAXSIZE = 0;

OpenCV opencv;
Capture video;
Rectangle[] faces;

void setup() {

  size(640, 480);
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

  image (video, 0, 0);

  opencv.loadImage(video);
  opencv.useColor();
  faces = opencv.detect(DETECT_SCALE, DETECT_MINNEIGHBOURS, 0, DETECT_MINSIZE, DETECT_MAXSIZE);

  //2
  //pushMatrix();
  //scale(1, -1);
  for (int i = 0; i < faces.length; i++) {

    rect(faces[i].x, faces[i].y, faces[i].width, faces[i].height);
    
    //1
    //opencv.setROI(faces[i].x, faces[i].y, faces[i].width, faces[i].height);
    //opencv.blur(35,35);
    //opencv.releaseROI();

    //2
    //PImage face = video.get(faces[i].x, faces[i].y, faces[i].width, faces[i].height+20);
    //image(face, faces[i].x, -faces[i].y-faces[i].height);
    
  }
  //1
  //image(opencv.getSnapshot(),0,0);
  
  //2
  //popMatrix();

}