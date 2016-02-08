import gab.opencv.*;
import processing.video.*;

OpenCV opencv;
Capture video;

void setup() {

  size(640, 480);
  noStroke();
  textSize(28);
  
  opencv = new OpenCV(this, 640, 480);
  opencv.useColor();
    
  video = new Capture(this, 640, 480);
  video.start();

}

void draw() {

  if (video.available() == true) {
    video.read();
  }  

  opencv.loadImage(video);
  //opencv.blur(30);
  image(opencv.getSnapshot(),0,0);
  
  fill(0,180);
  rect(0,0,640,48);
  fill(255);
  text("FPS: " + frameRate, 10, 34);

}