class ParticleSystemBubble {
  final int MAX_CNT = 30000;
  int particle_num = 0;
  ArrayList<ParticleBubble> particles;
  PShape groundShape;
  float thetaX, thetaY;
  ParticleSystemBubble() {
    particles = new ArrayList();
  }

// Timing of draw the shape need to be improved. 
// where to draw the shape? every time after new particle is added . 



  void run() {
    for (int i = 0; i < 250; i++) {
      addParticle();
      //shape(groundShape);
    }
    update();
    display();
  }

  void addParticle() {
    
    if (particle_num < 1) {
      
      groundShape =  createShape(PShape.GROUP);
    }
    
    
    if (particles.size() >= MAX_CNT)
      return;
    //for (int i = 0; i < 100; i++) {
      ParticleBubble p = new ParticleBubble();
      particles.add(p);
      particle_num += 1;
      groundShape.addChild(p.drop);
      //shape(groundShape);
    //}
  }

  void update() {
    for (int i = particles.size() - 1; i >= 0; i--) {
      ParticleBubble p = particles.get(i);
      if (p.dead()) {
        particles.remove(p);
        groundShape.removeChild(i);
        continue;
      }
      p.update();
    }

  }

  void display() {
    shape(groundShape);
  }
}
