class ParticleThing {
  float startx, starty, startRadius;
  float endx, endy, endRadius;
  ArrayList<Repellor> attractors;
  ArrayList<Repellor> repellors;
  ArrayList<Float> alphas;
  float hspeed;
  ArrayList<Particle> particles;
  //Particle object;
  int pMax;
  boolean play;
  boolean mouseRelease;
  PShape gRing,pRing;

  ParticleThing() {
    
    mouseRelease = true;
    play = true;
    out.noStroke();
    endRadius = 50;
    endx = random(0, out.width);
    endy = random(0, out.height);
    startRadius = 20;
    startx = random(0, out.width);
    starty = random(0, out.height);
    attractors = new ArrayList<Repellor>();
    repellors = new ArrayList<Repellor>();
    alphas = new ArrayList<Float>();

    //object = physics.makeParticle();
    particles = new ArrayList<Particle>();
    pMax = 1;  
  }

  void create() {
    //ellipse(endx,endy,endRadius*2,endRadius*2);
    if (particles.size() < pMax && play) {
      for (int i = particles.size(); i < pMax; i++) {
        particles.add(physics.makeParticle(1.0, startx+(sin(map(i, 0, pMax, 0, TWO_PI))*startRadius), starty+(cos(map(i, 0, pMax, 0, TWO_PI))*startRadius), 0));

        alphas.add(i, 100.0);
        if(particles.size() > 1){
          physics.makeAttraction(particles.get(i-1), particles.get(i), -0.01, 1);
        }

      }
      play = false;
    }
  }

  void makeAttractor() {
    if (keyPressed && mousePressed && mouseRelease) {
      mouseRelease = false;
      attractors.add(new Repellor(mouseX, mouseY, color(255),gRing));
      for (int i = 0; i < particles.size(); i++) {
        physics.makeAttraction(attractors.get(attractors.size()-1).p, particles.get(i), 1000, attractors.get(0).size*1.5);
      }
    }
  }

  void attractors() {
    makeAttractor();
    if (attractors.size() > 0) {
      for (int i = 0; i < attractors.size(); i++) {
        attractors.get(i).run();
      }
    }
    
  }

  void destroy(Particle p) {
    physics.removeParticle(p);
    particles.remove(p);
  }

  void particles(Particle p) {
    out.pushStyle();
    out.strokeWeight(3.09);
    out.point(p.position().x(), p.position().y());
    out.popStyle();
  }

  void update() {
  }

  void handleBoundaryCollisions( Particle p )
  {
    if ( p.position().x() < 0 ) {

      p.position().set( out.width, p.position().y(), 0);
    } else if (p.position().x() > out.width) {
      p.position().set( 0, p.position().y(), 0);
    }

    if ( p.position().y() < 0 ) {

      p.position().set( p.position().x(), out.height, 0);
    } else if (p.position().y() > out.height) {
      p.position().set( p.position().x(), 0, 0);
    }

    // p.position().set( constrain( p.position().x(), 0, width ), constrain( p.position().y(), 0, height ), 0 );
  }
  void run() {
    create();
    attractors();

    update();
  }


  
}

void mouseReleased() {
  thing.mouseRelease = true;
}