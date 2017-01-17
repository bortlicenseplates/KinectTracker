
class Repellor {
  Particle p;
  float xPos, yPos;
  float size;
  float alphaval;
  float time;
  boolean alive;
  float count;
  float div1, div2, m1, m2;
  color colour;
  PShape ring;
  
  PImage[] video;
  PImage disk;
  PVector prevPos;
  float diff;

  Repellor(float xPos, float yPos, color colour, PShape ring) {
    this.ring = ring;
    prevPos = new PVector(0,0);
    out.shapeMode(CENTER);
    count = random(0, 360);
    div1 = random(5, 2);
    div2 = random(5, 2);
    m1 = random(0.1, 0.5);
    m2 = random(0.1, 0.5);
    alive = true;
    alphaval = 255;
    time = 0.5;
    size = 200;
    this.xPos = xPos;
    this.yPos = yPos;
    this.colour = colour;
    p = physics.makeParticle(1, xPos, yPos, size+10);
    p.makeFixed();
    
    disk = loadImage("Disk.png");
    video = new PImage[450];
    for (int i = 0; i < video.length; i ++){
      video[i] = loadImage("LineLoop/" + i + ".png");
    }
  }
  void create() {
    out.pushMatrix();
    out.pushStyle();
    out.noFill();
    out.strokeWeight(10);
    out.stroke(255);
    
    mandala(p.position().x(), p.position().y(), size*2);
    out.popStyle();
    out.popMatrix();
  }
  
  void mandala(float x, float y, float radius){
    //DEBUG
    stroke(255);
    text(abs(map(prevPos.x, 0, out.width, 0, video.length)), 10, 10);
    text(abs(map(x, 0, out.width, 0, video.length)), 10, 25);
    
    //END DEBUG
    out.pushMatrix();
    
    if(abs(map(prevPos.x, 0, out.width, 0, video.length)) > (abs(map(x, 0, out.width, 0, video.length))) + 15 || abs(map(prevPos.x, 0, out.width, 0, video.length)) < (abs(map(x, 0, out.width, 0, video.length))) - 15){
      
      out.image(video[(int)map(x, 0, out.width, 0, video.length) % video.length],0,0,out.width, out.height);
      prevPos = new PVector(x,y);
    } else {
      out.image(video[(int)map(prevPos.x, 0, out.width, 0, video.length) % video.length],0,0,out.width, out.height);
    }
    //out.blendMode(MULTIPLY);
    out.popMatrix();
    
    
    
  }
  
  //void mandala(float x, float y, float radius, float wiggle, int pNum){
  //  out.pushMatrix();
  //  out.translate(x,y);
    
  //  out.rotate(frameCount*0.01);
  //  for (int i = 0; i < pNum; i ++){
  //    out.stroke(map(i,0,pNum,200,150),255,255,255);
  //    //rotate(frameCount*0.01);
  //    out.point(sin((TWO_PI/pNum)*i) * (radius + (cos((TWO_PI/pNum/2)*frameCount*0.1))* wiggle), 
  //          cos((TWO_PI/pNum)*i) * (radius + (cos((TWO_PI/pNum/2)*frameCount*0.1))* wiggle));
  //  }
  //  out.rotate(HALF_PI+(frameCount*0.001));
  //  for (int i = 0; i < pNum; i ++){
  //    out.stroke(map(i,0,pNum,150,200),255,255,255);
      
  //    out.point((sin((TWO_PI/pNum)*i) * (radius + (sin((TWO_PI/pNum/2)*((frameCount*0.12)))* wiggle))), 
  //          (cos((TWO_PI/pNum)*i) * (radius + (sin((TWO_PI/pNum/2)*((frameCount*0.12)))* wiggle))));
  //  }
  //  out.popMatrix();
  //}
  
  
  void update() {
    if (alphaval > 0) {
      alphaval -= time;
    } else {
      //physics.removeParticle(p);
      alive = false;
    }
    //p.position().setX(p.position().x()+(sin(radians(count * m1)) /div1) );
    //p.position().setY(p.position().y()+(cos(radians(count * m2)) /div2) );
    p.position().setX(lerp (p.position().x(), depthPlane.t.x + depthPlane.leftRight, 0.1));
    p.position().setY(lerp (p.position().y(), depthPlane.t.y + depthPlane.upDown,    0.1));
    //count += 0.00000000000000001;
  }

  void run() {
    create();
    update();
  }

  void dashedCircle(float radius, int dashWidth, int dashSpacing) {
    int steps = 200;
    int dashPeriod = dashWidth + dashSpacing;
    boolean lastDashed = false;
    for (int i = 0; i < steps; i++) {
      boolean curDashed = (i % dashPeriod) < dashWidth;
      if (curDashed && !lastDashed) {
        out.beginShape();
      }
      if (!curDashed && lastDashed) {
        out.endShape();
      }
      if (curDashed) {
        float theta = map(i, 0, steps, 0, TWO_PI);
        out.vertex(cos(theta) * radius, sin(theta) * radius);
      }
      lastDashed = curDashed;
    }
    if (lastDashed) {
      out.endShape();
    }
  }
  
  float getDistanceSq(float x1, float x2, float y1, float y2) {
    return sq(x2-x1) + sq(y2-y1);
  }
}