ParticleSystemSnow pssnow;

int g_flags[] = new int[12];
PImage snow;
Camera2 g_cam;

void setup() {
  
  size(1400,700,P3D);
  colorMode (RGB, 256);
  pssnow = new ParticleSystemSnow();
  g_cam = new Camera2();

}

void draw() {
  background(0);


  g_cam.MoveInLocalSpace(new MyVector(g_flags[0] * 0.8, 0, 0));
  g_cam.MoveInLocalSpace(new MyVector(0, g_flags[1] * 0.8, 0));
  g_cam.MoveInLocalSpace(new MyVector(0, 0, g_flags[2] * 0.8));
    
  g_cam.RotateAlongLocalAxis(new MyVector(1, 0, 0), g_flags[3] * 0.03);
  g_cam.RotateAlongLocalAxis(new MyVector(0, 1, 0), g_flags[4] * 0.03);
  g_cam.RotateAlongLocalAxis(new MyVector(0, 0, 1), g_flags[5] * 0.03);
  g_cam.Apply();

  background(33, 33, 33);
  stroke(0);
  
  fill(255,255,255);
  text("Frame rate: " + int(frameRate), -100, -400);
  text("Number of Particles: " + pssnow.particles.size(), -100, -450);

  

  pssnow.run();
  textSize(32);

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
