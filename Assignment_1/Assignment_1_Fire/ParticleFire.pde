class ParticleFire {
  MyVector velocity, acceleration, location;
  float lifespan, lifeRate;
  float size;
  PShape part;
  PImage texture;
  //PImage water_texture = loadImage("water_texture.jpg");
  
  
  ParticleFire() {
    

    float x = 0.0;
    float z = 0.0;
    float y = 0.0;
    float radius = 170.0;
    
    float r = radius * sqrt(random(0,1));
    float theta = 2 * PI * random(0,1);
    
    x = r * sin(theta);
    z = r * cos(theta);
    float distance = sqrt((x-600) * (x-600) + (z-300) * (z-300));
    x = x + 600 + random(-5,5);
    y = random(-20,20);
    z = z + 300 + random(-10,10);
    
    location = new MyVector(x, y, z);
    acceleration = new MyVector(0, 0, 0);
    x = -(x - 600) / 20;
    z = -(z - 300) / 20;
    velocity = new MyVector(x, -10, z);

    size = 3;
    lifeRate = 15;
    lifespan = 500; 
    
    //texture = fire;
    
    part = createShape();
    part.beginShape(QUADS);

    part.noStroke();
    part.normal(0,0,1);

    part.texture(fire);
    //if (abs(location.x-600)<70 && abs(location.z-399)<70 && ) {
    //  part.texture(fire_red);
    //} else {
    //  part.texture(fire);


    //}
    part.vertex(location.x, location.y-size/2, location.z,200+random(-50,50),200+random(-50,50));
    part.vertex(location.x+size/2, location.y, location.z,260+random(-50,50),200+random(-50,50));
    part.vertex(location.x, location.y+size/2, location.z,260+random(-50,50), 260+random(-50,50));
    part.vertex(location.x-size/2, location.y, location.z,200+random(-50,50),260+random(-50,50));

    part.endShape();
    
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
    MyVector movement = new MyVector(0,0,0);
    movement = velocity;
    
    if (location.y < -200) {
      part.setTexture(smoke);
      
    }

    //PVector movement = PVector.sub(location, original_location);
    part.translate(movement.x, movement.y, movement.z);
    
  }
  
  void display() {
    pushMatrix();
    translate(location.x, location.y, location.z);
    noStroke();
    sphere (size);
    popMatrix();

  }
}
