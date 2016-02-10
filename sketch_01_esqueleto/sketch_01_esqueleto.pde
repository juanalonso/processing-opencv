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
  
  //MAGIC
  
  image(opencv.getSnapshot(),480,0,480,360);
  
}