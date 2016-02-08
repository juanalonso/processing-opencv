class ParticleSystem {
  ArrayList<Particle> particles;

  PShape particleShape;
  private int currentColor = 0;

  ParticleSystem(int n) {
    particles = new ArrayList<Particle>();
    particleShape = createShape(PShape.GROUP);

    for (int i = 0; i < n; i++) {
      Particle p = new Particle();
      particles.add(p);
      particleShape.addChild(p.getShape());
    }
  }

  void update() {
    for (Particle p : particles) {
      p.update();
    }
  }

  void setEmitter(float x, float y) {
    for (Particle p : particles) {
      if (p.isDead()) {
        p.rebirth(x, y, getNextColor());
      }
    }
  }

  void display() {
    shape(particleShape);
  }

  int getNextColor() {
    if(random(1)>0.3) {
    currentColor++;
    }
    if (currentColor > 255) {
      currentColor = 0;
    }
    return currentColor;
  }
}