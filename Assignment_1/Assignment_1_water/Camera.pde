interface MyCamera {
  abstract void MoveInLocalSpace(PVector x);
  abstract void RotateAlongLocalAxis(PVector axis, float delta_theta);
};

class Camera2 implements MyCamera {
  public PVector pos;
  float azimuth,   
        elevation; 
  Camera2() { 
    pos = new PVector(800, 0, 1000);
    azimuth = PI/2; elevation = 0;
  }
  void Apply() {
    
    PVector center = pos.copy();
    PVector delta = new PVector(cos(azimuth), -sin(elevation), -sin(azimuth));
    //print(String.format("%g %g %g\n", delta.x, delta.y, delta.z));
    center.add(delta);
    camera(pos.x, pos.y, pos.z, center.x, center.y, center.z, 0, 1, 0);
  }
  void MoveInLocalSpace(PVector pos_delta) {
    
    float delta_x = pos_delta.x * cos(azimuth - PI/2) + pos_delta.z * sin(azimuth - PI/2);
    float delta_z = pos_delta.z * cos(azimuth - PI/2) - pos_delta.x * sin(azimuth - PI/2);
    float delta_y = pos_delta.y;
    pos.add(new PVector(delta_x, delta_y, delta_z));
  }
  void RotateAlongLocalAxis(PVector axis, float delta_omega) {
    if (axis.equals(new PVector(0, 1, 0)))      azimuth += delta_omega;
    else if (axis.equals(new PVector(1, 0, 0))) elevation += delta_omega;
  }
  String GetStatusString() {
    return String.format(
      "Camera Position Delta, X:%2d, Y:%2d, Z:%2d\n" +
      "Camera Angle Delta, azimuth:%2d, elevation:%2d",
      g_flags[0], g_flags[1], g_flags[2],
      g_flags[4], g_flags[3]
    );
  }
};
