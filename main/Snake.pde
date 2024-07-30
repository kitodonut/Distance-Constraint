class Snake extends Body{
  Snake(float x, float y) {
    super(x, y, new float[]{68, 78, 62, 60, 58, 56, 54, 52, 50, 48, 46, 44, 42, 40, 38, 36, 34, 32, 30, 28, 26, 24, 23, 22, 20, 18, 16, 14, 12, 10}, 1.0);
  }
  
  Snake(float x, float y, float s) {
    super(x, y, new float[]{68, 78, 62, 60, 58, 56, 54, 52, 50, 48, 46, 44, 42, 40, 38, 36, 34, 32, 30, 28, 26, 24, 23, 22, 20, 18, 16, 14, 12, 10}, s);
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
    
    noStroke();
    fill(0);
    PVector p1 = getHead().getVectorConstraint(skin[1]).mult(0.65).add(headPos);
    PVector p2 = getHead().getVectorConstraint(skin[skin.length - 1]).mult(0.65).add(headPos);
    circle(p1.x, p1.y, 15);
    circle(p2.x, p2.y, 15);
  }
}
