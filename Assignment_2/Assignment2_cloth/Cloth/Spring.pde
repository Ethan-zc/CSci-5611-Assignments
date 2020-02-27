class Spring {
  
  float upper_x;
  float upper_y; // upper end of spring
  float lower_x;
  float lower_y; // lower end of spring
  
  float upper_ball;
  float lower_ball;
  
  float restLen = 90; // initial length of spring;
  float K = 160; // spring constant factor
  
  Spring(float upper_end_x, float upper_end_y, float lower_end_x, float lower_end_y, float input_upper_ball, float input_lower_ball) {
    
    upper_x = upper_end_x;
    upper_y = upper_end_y;
    lower_x = lower_end_x;
    lower_y = lower_end_y;
    
    upper_ball = input_upper_ball;
    lower_ball = input_lower_ball;
    
    
  }
  
  float force() {
    
    float sx = (lower_x - upper_x);
    float sy = (lower_y - upper_y);
    float len = sqrt(sx * sx + sy * sy);
    
    float force_len = len - restLen;
    float force = K * (force_len);
   
    return force;
    
  }
  
  float len() {
    
    float sx = (lower_x - upper_x);
    float sy = (lower_y - upper_y);
    float len = sqrt(sx * sx + sy * sy);
    
    return len;
    
  }
  
  //void update(float dt) {
    
  //  float sx = (lower_x - upper_x);
  //  float sy = (lower_y - upper_y);
    
  //  float springLen = sqrt(sx*sx + sy*sy);
  //  float springForce = -k * (springLen - restLen);
    
  //  //float dirX = sx / springLen;
  //  //float dirY = sy / springLen;
    
    
  //}
  
  
  
}
