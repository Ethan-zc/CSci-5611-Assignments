class ParticleBubble {
  PVector velocity, acceleration, location;
  float lifespan, lifeRate;
  float size;
  PShape drop;
  //PImage water_texture = loadImage("water_texture.jpg");
  
  
  ParticleBubble() {
    

    float x = 620.0;
    float z = 0.0;
    float y = -175.0;
    
    
    

    location = new PVector(x+random(-250,300), y+random(-30,30), z+random(-40,40));
    acceleration = new PVector(0, 10, 0);
    velocity = new PVector(195, random(-5,0), random(-2,2));

    size = 8;
    lifeRate = 10;
    lifespan = 500; 
    
    drop = createShape();
    drop.beginShape(QUADS);

    drop.noStroke();
    drop.texture(water_drop);  
    drop.vertex(location.x-size/2, location.y-size/2, location.z,0,0);
    drop.vertex(location.x+size/2, location.y-size/2, location.z,water_drop.width,0);
    drop.vertex(location.x+size/2, location.y+size/2, location.z,water_drop.width, water_drop.height);
    drop.vertex(location.x-size/2, location.y+size/2, location.z,0,water_drop.height);
    drop.endShape();
    drop.setTint(color(0, 191, 255, 100));
    
    
  }

  boolean dead() {
    if (lifespan < 0){
      return true;
    } else {
      return false;
    }
  }

  void update() {
    lifespan -= lifeRate;
    //PVector original_location = location;
    velocity.add(acceleration);
    location.add(velocity);
    PVector movement = new PVector(0,0,0);
    if (location.x > 1500) {
      location.x = 1500;
      velocity.x = -70;
      velocity.z = random(-10,10);
    } 
    if (location.y > 600) {
      location.y =  600;
      velocity.y *= -0.6;
      velocity.x += 20;
    } else {
      movement = velocity;
    }
    
    //PVector movement = PVector.sub(location, original_location);
    drop.translate(movement.x, movement.y, movement.z);
    
  }
  
  void display() {
    pushMatrix();
    translate(location.x, location.y, location.z);
    noStroke();
    sphere (size);
    popMatrix();

  }
}
