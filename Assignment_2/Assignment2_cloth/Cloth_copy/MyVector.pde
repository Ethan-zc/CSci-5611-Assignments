class MyVector {
  
   float x;
   float y;
   float z;
   
   MyVector(float input_x, float input_y, float input_z) {
     
     x = input_x;
     y = input_y;
     z = input_z;
     
   }
  
  public void subtract(MyVector subtracted_vector) {
   
    
    x = x - subtracted_vector.x;
    y = y - subtracted_vector.y;
    z = z - subtracted_vector.z;
    
    
  }
  
  public void add(MyVector add_vector) {
    
    x = x + add_vector.x;
    y = y + add_vector.y;
    z = z + add_vector.z;
    
  }
  
  public MyVector copy() {
    
    MyVector result = new MyVector(x,y,z);
    
    return result;
  }
  
  public boolean equals(MyVector compare_vector) {
    
    if (x == compare_vector.x && y == compare_vector.y && z == compare_vector.z) {
      return true;
    } else {
      return false;
    }
    
  }
  
}
