import codeanticode.syphon.*;
SyphonServer serveThis;

//import processing.video.*;

import java.util.Collections;

import traer.physics.*;
ParticleSystem gen;

import org.openkinect.freenect.*;
import org.openkinect.freenect2.*;
import org.openkinect.processing.*;
import org.openkinect.tests.*;

Kinect2 kinect;

ParticleSystem physics;

ParticleThing thing;

Fakinect fakinect;
DepthPlane depthPlane;

PGraphics input;

PGraphics out;

//Movie depthVideo;
PImage depthImage;

void settings() {
  size(400,400, P3D);
  PJOGL.profile=1;
}


void setup() {
  frameRate(30);
  out = createGraphics(1024, 848);
  out.colorMode(HSB);
  gen = new ParticleSystem();
  physics = new ParticleSystem();
  
  depthImage = loadImage("data/depth.png");
  //depthVideo = new Movie(this, "depth.mp4");
  kinect = new Kinect2(this);

  kinect.initDepth();
  kinect.initIR();
  kinect.initVideo();
  kinect.initDevice();

  input = createGraphics(kinect.depthWidth, kinect.depthHeight);

  fakinect = new Fakinect();
  depthPlane = new DepthPlane();
  //depthVideo.loop();
  //depthVideo.volume(0);
  
  thing = new ParticleThing();
  serveThis = new SyphonServer(this, "Processing Syphon");
}

void draw() {
  background(0);
  
  //camera((mouseX - (width/2))*5, (mouseY - (height/2))*5, 1100, width/2, height/2, 0, 0.0, 1.0, 0.0);
  //fakinect.run();
  depthImage = kinect.getDepthImage();
  input.beginDraw();
  input.image(depthImage, 0, 0, input.width, input.height);
  input.endDraw();
  out.beginDraw();
  //out.blendMode(MULTIPLY);
  out.background(0);
  out.pushMatrix();
  out.translate(out.width/2, out.height/2);
  out.popMatrix();
  depthPlane.run();
  thing.run();
  //physics.tick();
  out.endDraw();
  image(input, 0, 0, width, height);
  serveThis.sendImage(out);
}

//void movieEvent(Movie m){
//  m.read();
//}