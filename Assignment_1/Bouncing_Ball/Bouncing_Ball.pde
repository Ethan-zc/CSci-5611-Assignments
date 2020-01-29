
PVector location;  // Location of bouncing ball
PVector velocity;  // Velocity of bouncing ball
PVector gravity;   // control the dropping velocity of bouncing ball
float ground; // the height of floor
float radius; // The radius of ball

void setup() {
  size(640,360);
  location = new PVector(320,60);
  velocity = new PVector(0,2.1);
  gravity = new PVector(0,0.2);
  ground = 350;
  radius = 48;

}

void draw() {
  
  // clean the background. 
  background(0);
  
  // draw the ground line. 
  stroke(255);
  line(140, ground, 500, ground);
  
  // add velocity onto the location. 
  location.add(velocity);
  
  // add acceleration onto the velocity. 
  velocity.add(gravity);
  
  // when the ball touches the ground, change the 
  // direction of velocity.
  if (location.y > ground-radius/2) {
    
    velocity.y = velocity.y * -0.95; 
    location.y = ground-radius/2;
  }

  
  stroke(255);
  strokeWeight(2);
  // fill in with red color.
  fill(255,0,0);
  // drawe the ball. 
  ellipse(location.x,location.y,radius,radius);
}
