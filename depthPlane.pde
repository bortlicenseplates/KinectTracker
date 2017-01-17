class DepthPlane {
  int skip;
  float x, y, z, lLim, uLim, count, depth, depthEnd, cSpeed, scanLength;
  boolean lP, lM, uP, uM;
  PVector t;
  float L = 0.65, U = 0.65, upDown, leftRight;
  PGraphics m;
  DepthPlane() {
    skip = 1;
    lLim = 10;
    uLim = 100;
    lP = false;
    lM = false;
    uP = false;
    uM = false;
    cSpeed = 00;
  }

  float depthSim(float offset) {
    float val = (125 * sin(radians(count))) + 125;
    if (count < 360) {
      count += cSpeed;
    } else {
      count = 0;
    }
    return val + offset;
  }

  void create() {
    input.beginDraw();
    stroke(255);
    fill(255);
    ArrayList<PVector> c = new ArrayList<PVector>();
    for (int i = 0; i < input.width; i += skip) {
      for ( int j = 0; j < input.height; j+= skip) {
        //stroke(brightness(input.pixels[i+(j*input.width)]));
        float eSize = map(input.brightness(input.pixels[i+(j*input.width)]), 255, 0, 0, skip*0.75);
        z = map(input.brightness(input.pixels[i+(j*input.width)]), 0, 255, -1000, 1000);
        if (input.brightness(input.pixels[i+(j*input.width)]) < uLim && brightness(input.pixels[i+(j*input.width)]) > lLim) {
          x = map(i, 0, input.width, 0, out.width);
          y = map(j, 0, input.height, 0, out.height); 
          //point(x, y, z);
          c.add(new PVector(((x-out.width/2)*L) + out.width/2, ((y-out.height/2)*U  ) + out.height/2));
        }
      }
    }
    if (c.size() > 0) {
      t = slapper(c);
    }
    //fill(255,255,255);
    //ellipse(t.x,t.y,50,50);
    //fill(0);
    //ellipse(t.x,t.y,40,40);
    input.endDraw();
  }

  PVector slapper(ArrayList<PVector> c) {
    PVector n = new PVector();
    for (PVector u : c) {
      n = PVector.add(n, u);
    }
    return PVector.div(n, c.size());
  }

  void controls() {
    if (keyPressed) {
      switch(key) {
      case '1':
        if (lLim > 0) {
          lLim --;
        }
        break;
      case '2':
        if (lLim < uLim) {
          lLim++;
        }
        break;
      case '-':
        if (uLim > lLim) {
          uLim --;
        }
        break;
      case '=':
        if (uLim < 255) {
          uLim++;
        }
        break;


      case 'w':
        U+=0.001;

        break;
      case 'a':
        L-=0.001;
        break;
      case 'q':
        U-=0.001;
        break;
      case 's':
        L+=0.001;
        break;
      
      case 'i':
        upDown+=1;
        break;
      case 'k':
        upDown-=1;
        break;
      case 'j':
        leftRight-=1;
        break;
      case 'l':
        leftRight+=1;
        break;
      }
    }
  }


  void run() {
    create();
    controls();
  }
}