//2D Rotational Dynamics
//Ball on Spring (damped) - 2D Motion
//CSCI 5611 Thread Sample Code
// Stephen J. Guy <sjguy@umn.edu>

ArrayList<Spring> Springs;
ArrayList<Ball> Balls;


void setup() {
  size(1200, 1200, P3D);
  surface.setTitle("Ball on Spring!");
  Springs = new ArrayList();
  Balls = new ArrayList();
  Ball ball_1 = new Ball(600,200);
  Ball ball_2 = new Ball(600,210);
  Ball ball_3 = new Ball(600,220);
  Ball ball_4 = new Ball(600,230);
  Balls.add(ball_1);
  Balls.add(ball_2);
  Balls.add(ball_3);
  Balls.add(ball_4);
  Spring anchor = new Spring(anchorX, anchorY, 600, 200,0,0);
  Spring spring_1 = new Spring(600,200,600,210,0,1);
  Spring spring_2 = new Spring(600,210,600,220,1,2);
  Spring spring_3 = new Spring(600,220,600,230,2,3);
  Springs.add(anchor);
  Springs.add(spring_1);
  Springs.add(spring_2);
  Springs.add(spring_3);
  
}

//0 gravity, pull left
//20 gravity, kick right, stiff

//float floor = 400;
//float ballX = 600;
//float ballY = 200;
//float velX = 0; //40
//float velY = 0;
float grav = 2000; //0
float radius = 20;
float anchorX = 600;
float anchorY = 100;
float restLen = 90;
float mass = 1;
//float k = 160; //1 1000
float kv = 160;

void update(float dt){
  //Spring anchor = new Spring(anchorX, anchorY, ballX, ballY,0,1);
  for (int i = 0; i < Springs.size(); i++) {
    
    // Anchor Spring
    if (i == 0) {
      Spring current_Spring = Springs.get(i);
      Ball lowerBall = Balls.get(0);
      
      float sx = (current_Spring.lower_x - current_Spring.upper_x);
      float sy = (current_Spring.lower_y - current_Spring.upper_y);
      float stringLen = current_Spring.len();
    
      float stringF = -current_Spring.force();
      float dirX = sx/stringLen;
      float dirY = sy/stringLen;
      float projVel = lowerBall.velX*dirX + lowerBall.velY*dirY;
      float dampF = -kv*(projVel - 0);
      
      float springForceX = (stringF+dampF)*dirX;
      float springForceY = (stringF+dampF)*dirY;
      
      lowerBall.velX += (springForceX/mass)*dt;
      lowerBall.velY += ((springForceY+grav*Balls.size())/mass)*dt;
      
      lowerBall.ball_x += lowerBall.velX*dt;
      lowerBall.ball_y += lowerBall.velY*dt;
      
      current_Spring.lower_x = lowerBall.ball_x;
      current_Spring.lower_y = lowerBall.ball_y;
    }
    
    // The last Spring
    else if (i == Springs.size() -1 ) {
      Spring current_Spring = Springs.get(i);
      Spring previous_Spring = Springs.get(i-1);
      Ball upperBall = Balls.get(Balls.size()-2);
      Ball lowerBall = Balls.get(Balls.size()-1);
      
      float sx = (current_Spring.lower_x - current_Spring.upper_x);
      float sy = (current_Spring.lower_y - current_Spring.upper_y);
      float sx_previous = (previous_Spring.lower_x - previous_Spring.upper_x);
      float sy_previous = (previous_Spring.lower_y - previous_Spring.upper_y);
      
      float stringLen = current_Spring.len();
      float stringLen_previous = previous_Spring.len();
    
      float stringF = -current_Spring.force();
      float dirX = sx/stringLen;
      float dirY = sy/stringLen;
      float dirX_previous = sx_previous/stringLen_previous;
      float dirY_previous = sy_previous/stringLen_previous;
      
      float projVel = lowerBall.velX*dirX + lowerBall.velY*dirY;
      float projVel_previous = upperBall.velX*dirX_previous + upperBall.velY*dirY_previous;
      
      // Use project velocity of previous node. 
      float dampF = -kv*(projVel - projVel_previous);
      
      float springForceX = (stringF+dampF)*dirX;
      float springForceY = (stringF+dampF)*dirY;
      
      lowerBall.velX += (springForceX/mass)*dt;
      lowerBall.velY += ((springForceY+grav)/mass)*dt;
      
      lowerBall.ball_x += lowerBall.velX*dt;
      lowerBall.ball_y += lowerBall.velY*dt;
      
      upperBall.velX += (springForceX/(2 * mass))*dt;
      //upperBall.velY -= ((springForceY+grav)/ (2 * mass))*dt;
      
      upperBall.ball_x += upperBall.velX*dt;
      //upperBall.ball_y += upperBall.velY*dt;
      
      current_Spring.lower_x = lowerBall.ball_x;
      current_Spring.lower_y = lowerBall.ball_y;
      
      current_Spring.upper_x = upperBall.ball_x;
      current_Spring.upper_y = upperBall.ball_y;
      
    }
    
    // Springs in the middle
    else {
      Spring current_Spring = Springs.get(i);
      Ball upperBall = Balls.get(i-1);
      Ball lowerBall = Balls.get(i);
      
      float sx = (current_Spring.lower_x - current_Spring.upper_x);
      float sy = (current_Spring.lower_y - current_Spring.upper_y);
      float stringLen = current_Spring.len();
    
      float stringF = -current_Spring.force();
      float dirX = sx/stringLen;
      float dirY = sy/stringLen;
      float projVel = lowerBall.velX*dirX + lowerBall.velY*dirY;
      float dampF = -kv*(projVel - 0);
      
      float springForceX = (stringF+dampF)*dirX;
      float springForceY = (stringF+dampF)*dirY;
      
      lowerBall.velX += (springForceX/mass)*dt;
      lowerBall.velY += ((springForceY+grav * (Balls.size() - i))/mass)*dt;
      
      lowerBall.ball_x += lowerBall.velX*dt;
      lowerBall.ball_y += lowerBall.velY*dt;
      
      //upperBall.velX -= (springForceX/mass)*dt * 0.1;
      //upperBall.velY -= ((springForceY+grav/mass))*dt * 0.1;
      
      //upperBall.ball_x += upperBall.velX*dt;
      //upperBall.ball_y += upperBall.velY*dt;
      
      current_Spring.lower_x = lowerBall.ball_x;
      current_Spring.lower_y = lowerBall.ball_y;
      
      current_Spring.upper_x = upperBall.ball_x;
      current_Spring.upper_y = upperBall.ball_y;
      
    }
    
  }
  
}

void keyPressed() {
  Ball lowerBall = Balls.get(Balls.size() - 1);
  if (keyCode == RIGHT) {
    
    lowerBall.velX += 100;
  }
  if (keyCode == LEFT) {
    lowerBall.velX -= 100;
  }
}

void draw() {
  background(255,255,255);
  for (int i = 0; i < 10; i++){
    update(1/(10.0*frameRate));
  }
  println(1.0/frameRate);
  
  for (int i = 0; i < Springs.size(); i ++) {
    Spring current_Spring = Springs.get(i);
    fill(0,0,0);
    stroke(5);
    line(current_Spring.upper_x, current_Spring.upper_y,current_Spring.lower_x,current_Spring.lower_y);
    
  }
  //fill(0,0,0);
  //stroke(5);
  //line(anchorX,anchorY,ballX,ballY);
  //translate(ballX,ballY);
  
  for (int i = 0; i < Balls.size(); i++) {
    pushMatrix();
    Ball current_ball = Balls.get(i);
    translate(current_ball.ball_x,current_ball.ball_y);
    noStroke();
    fill(0,0,0);
    sphere(radius);
    popMatrix();
  }

}
