
ParticleSystemBubble psbubble;
PShape gun;
PShape target;
PImage water_drop;
int g_flags[] = new int[12];
Camera2 g_cam;

void setup() {
  
  size(1400,700,P3D);
  colorMode (RGB, 256);
  psbubble = new ParticleSystemBubble();
  g_cam = new Camera2();
  gun = loadShape("RayGun.obj");
  target = loadShape("Target.obj");
  water_drop = loadImage("water_texture.jpg");
}

void draw() {
  background(0);


    g_cam.MoveInLocalSpace(new PVector(g_flags[0] * 0.8, 0, 0));
    g_cam.MoveInLocalSpace(new PVector(0, g_flags[1] * 0.8, 0));
    g_cam.MoveInLocalSpace(new PVector(0, 0, g_flags[2] * 0.8));

  

    g_cam.RotateAlongLocalAxis(new PVector(1, 0, 0), g_flags[3] * 0.03);
    g_cam.RotateAlongLocalAxis(new PVector(0, 1, 0), g_flags[4] * 0.03);
    g_cam.RotateAlongLocalAxis(new PVector(0, 0, 1), g_flags[5] * 0.03);
  g_cam.Apply();

  background(33, 33, 33);
  stroke(0);
  
  fill(255,255,255);
  text("Frame rate: " + int(frameRate), -100, -400);
  text("Number of Particles: " + psbubble.particles.size(), -100, -450);
  

  psbubble.run();
  textSize(32);
  drawGun();
  drawTarget();
  drawGround();

}

void drawGun() {
  
  pushMatrix();
  //background(204);
  translate(0, 0);
  rotate(1.0*PI);
  rotateY(0.5*PI);
  directionalLight(0, 255, 0, 0, -1, 0);
  directionalLight(0, 255, 0, 0, 1, 0);
  scale(200,200,200);
  shape(gun,0,0);
  popMatrix();

}

void drawTarget() {
  
  pushMatrix();
  translate(1650,100);
  //rotateX(0*PI);
  rotateZ(0.8*PI);
  rotateY(0.5*PI);
  scale(200,200,200);
  shape(target,0,0);
  popMatrix();
}

void drawGround() {
  
  pushMatrix();
  beginShape();
  fill(0,255,255);
  translate(800,600,0);
  vertex(-1500,0,-1500,0,0);
  vertex(-1500,0,1500,0,1500);
  vertex(1500,0,1500,1500,1500);
  vertex(1500,0,-1500,1500,0);
  endShape();
  popMatrix();
  
}

void keyPressed() {

  if      (key == 'w') g_flags[2] = -10; // (-Z)
  else if (key == 's') g_flags[2] =  10; // (+Z)
  else if (key == 'a') g_flags[0] = -10; // (-X)
  else if (key == 'd') g_flags[0] =  10; // (+X)
  else if (key == 'q') g_flags[1] =  10; // (+Y)
  else if (key == 'e') g_flags[1] = -10; // (-Y)
  else if (key == 't') g_flags[3] =  5; // 
  else if (key == 'g') g_flags[3] = -5; // 
  else if (key == 'f') g_flags[4] =  5; // 
  else if (key == 'h') g_flags[4] = -5; // 
  else if (key == 'r') g_flags[5] = -5; // 
  else if (key == 'y') g_flags[5] =  5; // 
}

void keyReleased() {
  if      (key == 'w' || key == 's') { g_flags[2] = 0; }
  else if (key == 'a' || key == 'd') { g_flags[0] = 0; }
  else if (key == 'q' || key == 'e') { g_flags[1] = 0; }
  else if (key == 't' || key == 'g') { g_flags[3] = 0; }
  else if (key == 'f' || key == 'h') { g_flags[4] = 0; }
  else if (key == 'r' || key == 'y') { g_flags[5] = 0; }
}
