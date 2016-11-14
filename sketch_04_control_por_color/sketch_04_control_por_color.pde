import gab.opencv.*;
import processing.video.*;

Capture video;
OpenCV opencv;
ArrayList<Contour> contours;


void setup() {

  size(960, 360);
  stroke(255, 255, 255); 
  strokeWeight(5); 
  noFill();

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
  image(video, 0, 0, 480, 360);

  opencv.loadImage(video);
  opencv.useColor(HSB);
  opencv.setGray(opencv.getH());

  opencv.inRange(142, 164);

  //opencv.erode();
  //opencv.erode();
  //opencv.erode();
  //opencv.erode();

  image(opencv.getSnapshot(), 480, 0, 480, 360);

  //contours = opencv.findContours(true, true);

  //scale(0.75);
  //for (int f=0; f<contours.size(); f++) {
  //  if (contours.get(f).area() > 9000) {
  //    contours.get(f).draw();
  //  }
  //  if (contours.get(f).containsPoint(int(240/0.75), int(180/0.75))) {
  //    int r = (frameCount % 100) * (100 - (frameCount % 100)) / 50;
  //    ellipse(240/0.75, 180/0.75, r, r);
  //  }
  //}

}