
ArrayList<Spring> Springs;
ArrayList<Ball> Balls;
//PVector[][] velocities = {{new PVector(0,0,0),new PVector(0,0,0)}, {new PVector(0,0,0),new PVector(0,0,0)}, {new PVector(0,0,0),new PVector(0,0,0)}};
//PVector[][] positions = {{new PVector(600,200,0),new PVector(670,200,0)}, {new PVector(600,210,0),new PVector(670,210,0)}, {new PVector(600,230,0),new PVector(670,230,0)}};
PVector[][] velocities;
PVector[][] positions;
PVector[][] velocities_new;
boolean[][] clicked_status;
PVector Sphere_pos;
PVector Sphere_velocity;
PVector mouse_pressed_pos;
PVector original_point;


PImage cloth_texture;
int g_flags[] = new int[12];
int column_num = 30;
int row_num = 30;

boolean start_update = false;
boolean mouse_dragged = false;
boolean drag_mode = true;
boolean tear_mode = false;


void setup() {
  size(1200, 1200, P3D);
  surface.setTitle("Ball on Spring!  Frame Rate: " + frameRate);
  g_cam = new Camera2();
  velocities = new PVector[row_num][column_num];
  positions = new PVector[row_num][column_num];
  clicked_status = new boolean[row_num][column_num];
  Sphere_pos = new PVector(1000,600,300);
  Sphere_velocity = new PVector(0,0,0);
  mouse_pressed_pos = new PVector(0,0,0);
  original_point = new PVector(0,0,0);
  cloth_texture = loadImage("texture.jpg");
  //textureMode(NORMAL);
  int i = 0;
  int j = 0;
  
  for (i = 0; i < row_num; i++) {
    for (j = 0; j < column_num; j++) {
      PVector single_node = new PVector(600 + j*20,0,i*20);
      positions[i][j] = single_node;
      velocities[i][j] = new PVector(0,0,0);
      clicked_status[i][j] = false;
    }
  }
  //int height = i * 20;
  //int width = j * 20;
  //print("height is : " + height + ", width is : " + width);
  
  
  
}

//0 gravity, pull left
//20 gravity, kick right, stiff

//float floor = 400;
//float ballX = 600;
//float ballY = 200;
//float velX = 0; //40
//float velY = 0;
float grav = 5; //0
float Sphere_radius = 200;
//float anchorX = 600;
//float anchorY = 100;
float restLen = 10;
float restLen_hor = 20;
float restLen_ver = 10;
float mass = 10;
float k = 500; //1 1000
float kv = 200;
Camera2 g_cam;

void update(float dt){

  velocities_new = velocities;
  
  // Horizontal
  for (int i = 0; i < row_num; i++) {
    for (int j = 0; j < column_num - 1; j++) {
      PVector e =  PVector.sub(positions[i][j+1], positions[i][j]);
      float len = sqrt(e.x * e.x + e.y * e.y + e.z * e.z);
      //int test = j + 1;
      //print("(" + i + "," + test + ")-(" + i + "," + j + "):" +len+"\n");
      e = e.normalize();
      float v1 = e.dot(velocities[i][j]);
      float v2 = e.dot(velocities[i][j+1]);
      float f = -k * (restLen_hor - len) - kv * (v1-v2);
      e.mult(f);
      //e.div(mass);
      //e.y += i * mass * grav * dt;
      e.mult(dt);
      
      //PVector gravity = new PVector(0, ((row_num - i) * grav/mass)*dt, 0);
      
      //velocities_new[i][j].add(e);

      velocities_new[i][j].add(e);
      velocities_new[i][j+1].sub(e);


    }
  }
  
  // Vertical
  for (int i = 0; i < row_num - 1; i++) {
    for (int j = 0; j < column_num; j++) {
      PVector e =  PVector.sub(positions[i+1][j], positions[i][j]);
      float len = sqrt(e.x * e.x + e.y * e.y + e.z * e.z);
      //int test = i + 1;
      //print("(" + test + "," + j + ")-(" + i + "," + j + "):" +len+"\n");
      PVector e_norm = e.normalize();
      float v1 = e.dot(velocities[i][j]);
      float v2 = e.dot(velocities[i+1][j]);
      float f = -k * (restLen_ver - len) - kv * (v1-v2);
      PVector gravity = new PVector(0,(row_num - i) * mass * grav,0);

      e = PVector.mult(e_norm,f);
      PVector higher_e = PVector.add(e, gravity);
      e.div(mass);
      higher_e.div(mass);
      e.mult(dt);
      higher_e.mult(dt);
      //e.add(gravity);
      
      //PVector gravity = new PVector(0, ((column_num - j) * grav/mass)*dt, 0);
      
      //velocities_new[i][j].add(e);
      //velocities_new[i][j].add(higher_e);
        if (i == row_num - 2) {
          
          gravity = new PVector(0, -mass * grav,0);
          e = PVector.mult(e_norm,f);
          PVector lower_e = PVector.add(gravity,e);
          lower_e.div(mass);
          lower_e.mult(dt);
          if (clicked_status[i+1][j] != true) {
            velocities_new[i][j].add(higher_e);
            velocities_new[i+1][j].sub(lower_e);
          }
          
        } else {
          if (clicked_status[i+1][j] != true) {
            velocities_new[i][j].add(higher_e);
            velocities_new[i+1][j].sub(e);
          }
        }
      
    }
  }
  
  //if (mouse_dragged == true) {
    
    
    
    
  //}

  
  for (int i = 0; i < row_num; i++) {
    for (int j = 0; j < column_num; j++ ) {
      
      if (mousePressed == true & i == 15 && j == 15 && drag_mode == true) {
        

          velocities[15][15].x = 0;
          velocities[15][15].y = 0;
          velocities[15][15].z = 0;
          if (mouse_dragged == true) {
            positions[15][15].x += (mouseX - mouse_pressed_pos.x)/10000;
            //print("the changing of position should be: " + (mouseX - mouse_pressed_pos.x) + "\n");
            positions[15][15].y += (mouseY - mouse_pressed_pos.y)/10000;
          }
        
      } else if (mousePressed == true & i == 14 && j == 14 && drag_mode == true) {
        
          velocities[14][14].x = 0;
          velocities[14][14].y = 0;
          velocities[14][14].z = 0;
          if (mouse_dragged == true) {
            positions[14][14].x += (mouseX - mouse_pressed_pos.x)/10000;
            positions[14][14].y += (mouseY - mouse_pressed_pos.y)/10000;
          }
        
      } else {
        

        if (i == 0) {
          velocities_new[i][j] = new PVector(0,0);
        }
        positions[i][j].x += velocities_new[i][j].x * dt;
        positions[i][j].y += velocities_new[i][j].y * dt;
        positions[i][j].z += velocities_new[i][j].z * dt;
        velocities = velocities_new;
        
        //Collision Detection
        PVector dist_vector = PVector.sub(positions[i][j], Sphere_pos);
        float dist = sqrt(dist_vector.x * dist_vector.x + dist_vector.y * dist_vector.y + dist_vector.z * dist_vector.z);
        
        
        if (dist < Sphere_radius + 0.09) {
          //print("TOUCH!!!!!!!!!!!!!!!!!!!!!!!!!!!");
          PVector normal = dist_vector;//PVector.mult(dist_vector, -1); //<>//
          normal.normalize(); //<>//
          float vec_norm = velocities[i][j].dot(normal);
          PVector bounce = normal.mult(-vec_norm*1.5);
          //velocities[i][j] = new PVector(0,0,0);
          velocities[i][j].add(bounce);
          //positions[i][j].add(normal.mult(3));
          positions[i][j].add(normal.mult(0.1+Sphere_radius-dist));
          Sphere_velocity.sub(bounce.mult(0.01));
         
        }
      }
      
      
      
      
      
    }
  }
  
}

void keyPressed() {
  //if (keyCode == RIGHT) {
    
  //  Sphere_velocity.x += 10;
  //}
  //if (keyCode == LEFT) {
  //  Sphere_velocity.x -= 10;
  //}
  if (key == ' ') {
    start_update = true;
  }
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
  else if (keyCode == RIGHT) Sphere_velocity.x += 10;
  else if (keyCode == LEFT) Sphere_velocity.x -= 10;
  else if (keyCode == UP) Sphere_velocity.y -= 10;
  else if (keyCode == DOWN) Sphere_velocity.y += 10;
  else if (key == 'n') Sphere_velocity.z += 10;
  else if (key == 'm') Sphere_velocity.z -= 10;
  else if (key == 'x') {
    if (drag_mode == true) {
      drag_mode = false;
      tear_mode = true;
    } else if (drag_mode == false) {
      drag_mode = true;
      tear_mode = false;
    }
  }
}

void keyReleased() {
  if      (key == 'w' || key == 's') { g_flags[2] = 0; }
  else if (key == 'a' || key == 'd') { g_flags[0] = 0; }
  else if (key == 'q' || key == 'e') { g_flags[1] = 0; }
  else if (key == 't' || key == 'g') { g_flags[3] = 0; }
  else if (key == 'f' || key == 'h') { g_flags[4] = 0; }
  else if (key == 'r' || key == 'y') { g_flags[5] = 0; }
}

void mouseDragged() {
  //print("mouseX is: " + mouseX + ", mouseY is: " + mouseY + "------------\n");
  mouse_dragged = true;
  if (tear_mode == true) { 
    float x_proportion = (mouseY - 390.0)/ 500.0;
    //float y_proportion = (mouseY - 390.0) / 500.0;
    int estimate_node_x = int(x_proportion * 30 - 1);
    //int estimate_node_y = int(y_proportion * 30 - 1);
    print("X is: " + estimate_node_x + "------------\n");
    for (int i = 0; i < column_num; i++) {
      clicked_status[estimate_node_x][i] = true;
    }
    
  }
  
  //print("mouse is dragged!" + mouse_dragged + "\n");
}

void mouseReleased() {
  
  mouse_dragged = false;
  //print("mouse is released!" + mouse_dragged + "\n");
  
}

void mousePressed() {
  
  mouse_pressed_pos.x = mouseX;
  mouse_pressed_pos.y = mouseY;
  //print("mouse_X: " + mouseX + ", mouse_Y: " + mouseY + ". \n");
  
  //if (tear_mode == true) {
  //  for (int i = 0; i < 30; i++) {
      
  //    clicked_status[15][i] = true;
      
  //  }
  //}
  
}

void draw() {
  background(255,255,255);
  fill(0,0,0);
  textSize(50);
  text("Frame Rate: "+ frameRate, 600,-350);
  if (drag_mode == true) {
    text("Drag mode", 600, -300);
  } else if (tear_mode == true) {
    text("Tear mode", 600, -300);
  }
  
  
  g_cam.MoveInLocalSpace(new PVector(g_flags[0] * 0.8, 0, 0));
  g_cam.MoveInLocalSpace(new PVector(0, g_flags[1] * 0.8, 0));
  g_cam.MoveInLocalSpace(new PVector(0, 0, g_flags[2] * 0.8));

  g_cam.RotateAlongLocalAxis(new PVector(1, 0, 0), g_flags[3] * 0.03);
  g_cam.RotateAlongLocalAxis(new PVector(0, 1, 0), g_flags[4] * 0.03);
  g_cam.RotateAlongLocalAxis(new PVector(0, 0, 1), g_flags[5] * 0.03);
  g_cam.Apply();
  
  if (start_update == true) {
    for (int i = 0; i < 100; i++){
      //update(1/(100.0*frameRate));
      update(1/(20.0*frameRate));
    }
  }
 

 
  fill(0,0,255);
  int grid_height = 600 / column_num;
  int grid_width = 600 / row_num;
  for (int i = 0; i < row_num-1; i++) {
    beginShape(TRIANGLE_STRIP);
    texture(cloth_texture);
    for (int j = 0; j < column_num; j++) {
      if (clicked_status[i+1][j] != true) {
        vertex(positions[i+1][j].x, positions[i+1][j].y, positions[i+1][j].z,(i+1) * grid_height, j * grid_width);
        vertex(positions[i][j].x, positions[i][j].y, positions[i][j].z, i * grid_height, j * grid_width);
      }
    }
    endShape();
  }
  
  PVector dump = PVector.sub(Sphere_velocity, original_point);
  dump.mult(0.1);
  Sphere_velocity.sub(dump);
  Sphere_pos.add(Sphere_velocity);

  pushMatrix();
  translate(Sphere_pos.x, Sphere_pos.y + Sphere_velocity.y, Sphere_pos.z);
  noStroke();
  fill(255,0,0);
  //spotLight(255, 255, 255, width/2, height/2, 0, 0, 0, -1, PI/4, 2);
  sphere(Sphere_radius);
  popMatrix();
      
     

}
