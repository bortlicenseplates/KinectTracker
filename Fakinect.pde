class Fakinect{
  float xPos, yPos, eW, eH, depth, count, cSpeed;
  Fakinect(){
    update();
  }
  
  void update(){
    xPos = map(mouseX,0,width,0,input.width);
    yPos = map(mouseY,0,height,0,input.height);
    eW = 100;
    eH = 100;
    cSpeed = 0.7;
  }
  
  void depthSim(){
    depth = (125 * sin(radians(count))) + 125;
    if (count < 360){
      count += cSpeed;
    }else{
      count = 0;
    }
  }
  
  void create(){
    input.beginDraw();
    input.background(255);
    input.noStroke();
    input.fill(depth);
    //input.fill(0);
    input.ellipse(xPos, yPos, eW, eH);
    
    input.endDraw();
  }
  
  void run(){
    depthSim();
    update();
    create();
  }
}