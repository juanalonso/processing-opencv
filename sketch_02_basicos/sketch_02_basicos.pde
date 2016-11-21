import gab.opencv.*;
import processing.video.*;

OpenCV opencv;
Capture video;

void setup() {

  size(960, 360);
  
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
  
  //opencv.flip(OpenCV.VERTICAL);
  //opencv.invert();
  //opencv.brightness(128);
  //opencv.brightness((int)map(mouseX,0,width,-255,255));
  //opencv.contrast(5);
  //opencv.contrast(map(mouseX,0,width,0,255));
  //opencv.threshold(127);
  //opencv.threshold((int)map(mouseX,0,width,0,255));
  //opencv.inRange(122,132);
  //opencv.inRange((int)map(mouseX,0,width,0,240),(int)map(mouseX,0,width,25,255));
  //opencv.blur((int)map(mouseX,0,width,1,50),(int)map(mouseY,0,height,1,50));
  
  image(opencv.getSnapshot(),480,0,480,360);
  
}