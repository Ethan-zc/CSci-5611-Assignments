class ParticleSnow {
  MyVector velocity, acceleration, location;
  float lifespan, lifeRate;
  float perlin_x;
  float perlin_z;
  float size;
  PShape part;
  PImage texture;
  //PImage water_texture = loadImage("water_texture.jpg");
  
  
  ParticleSnow() {
    

    float x = 0.0;
    float z = 0.0;
    float y = -200.0;
    float perlin_x = 0;
    float perlin_z = 0;
    
  
    
    location = new MyVector(x+random(-500,500), y, z+random(-500,500));
    acceleration = new MyVector(0, 0, 0);
    velocity = new MyVector(x, 2, z);

    size = 3;
    lifeRate = 10;
    lifespan = 500; 
    
    //texture = fire;
    
    part = createShape();
    part.beginShape(QUADS);

    part.noStroke();
    part.normal(0,0,1);

    //part.texture(fire);
    //if (abs(location.x-600)<70 && abs(location.z-399)<70 && ) {
    //  part.texture(fire_red);
    //} else {
    //  part.texture(fire);


    //}
    part.vertex(location.x, location.y-size/2, location.z,0,0);
    part.vertex(location.x+size/2, location.y, location.z,0,0);
    part.vertex(location.x, location.y+size/2, location.z,0,0);
    part.vertex(location.x-size/2, location.y, location.z,0,0);

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
    perlin_x += 1;
    perlin_z += 1;
    float x_noise = noise(perlin_x);
    float z_noise = noise(perlin_z);
    x_noise = map(x_noise,0,1,-5,5);
    z_noise = map(z_noise,0,1,-5,5);
    velocity.x = x_noise;
    velocity.z = z_noise;
    //PVector original_location = location;
    velocity.add(acceleration);
    location.add(velocity);
    MyVector movement = new MyVector(0,0,0);
    movement = velocity;
    

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
