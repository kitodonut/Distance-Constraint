class Lizzard extends Body{
  Lizzard(float x, float y) {
    super(x, y, new float[]{52, 58, 40, 60, 68, 71, 65, 50, 28, 15, 11, 9, 8, 8, 8, 8, 8, 8, 8, 7, 7, 7}, 1.0);
  }
  
  Lizzard(float x, float y, float s) {
    super(x, y, new float[]{52, 58, 40, 60, 68, 71, 65, 50, 28, 15, 11, 9, 8, 8, 8, 8, 8, 8, 8, 7, 7, 7}, s);
  }
  
  void showSpine(){
    super.show();
  }
  
  void show(){
    strokeWeight(4);
    stroke(#226C32);
    fill(#3EA255);
    
    beginShape();
    for(PVector v : skin)
      if(v != null)
        vertex(v.x, v.y);
        
    endShape(CLOSE);
  }
}
