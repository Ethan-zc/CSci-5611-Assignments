class ParticleSystemSnow {
  final int MAX_CNT = 100000;
  int particle_num = 0;
  ArrayList<ParticleSnow> particles;
  PShape groundShape;
  float thetaX, thetaY;
  ParticleSystemSnow() {
    particles = new ArrayList();
  }

  void run() {
    for (int i = 0; i < 400; i++) {
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
    
    
    //if (particles.size() >= MAX_CNT)
    //  return;
    //for (int i = 0; i < 100; i++) {
      ParticleSnow p = new ParticleSnow();
      particles.add(p);
      particle_num += 1;
      groundShape.addChild(p.part);
      //shape(groundShape);
    //}
  }

  void update() {
    for (int i = particles.size() - 1; i >= 0; i--) {
      ParticleSnow p = particles.get(i);
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
