import gab.opencv.*;
import processing.video.*;
import java.awt.*;

float DETECT_SCALE = 1.2;
int DETECT_MINNEIGHBOURS = 6;
int DETECT_MINSIZE = 0;
int DETECT_MAXSIZE = 0;

OpenCV opencv;
Capture video;
Rectangle[] eyes;

ParticleSystem ps;
PImage sprite;  
PImage footer;  


void setup() {

  size(640, 480, P2D);
  frameRate(30);
  noFill();
  strokeWeight(2);
  stroke(255, 255, 0);
  hint(DISABLE_DEPTH_MASK);

  footer = loadImage("footer.png");
  sprite = loadImage("sprite.png");
  ps = new ParticleSystem(5000);

  opencv = new OpenCV(this, 640, 480); 
  opencv.loadCascade(OpenCV.CASCADE_EYE);

  video = new Capture(this, 640, 480);
  video.start();
}

void draw() {

  if (video.available() == true) {
    video.read();
  } 
  
  opencv.loadImage(video);
  opencv.useColor();
  image(opencv.getSnapshot(), 0, 0);
  opencv.useGray();
  
  eyes = opencv.detect(DETECT_SCALE, DETECT_MINNEIGHBOURS, 0, DETECT_MINSIZE, DETECT_MAXSIZE);
  
  if (eyes.length>0) {
    
    int i = (int)random(0,eyes.length);
    ps.setEmitter(eyes[i].x+eyes[i].width/2, eyes[i].y+eyes[i].height/2);
    
    //for (i=0; i<eyes.length; i++) {
      //ellipse(eyes[i].x+eyes[i].width/2, eyes[i].y+eyes[i].height/2, 10, 10);
    //}
  
}

  ps.update();
  ps.display();
  
  image(footer, 0, 0);
    
}