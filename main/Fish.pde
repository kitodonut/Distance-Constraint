class Fish extends Body{
  Fish(float x, float y){
    super(x, y, new float[]{68, 84, 87, 85, 83, 77, 64, 60, 51, 38, 34, 32, 19, 15}, 1.0);
  }
  
  Fish(float x, float y, float s){
    super(x, y, new float[]{68, 84, 87, 85, 83, 77, 64, 60, 51, 38, 34, 32, 19, 15}, s);
  }
  
  void showSpine(){
    super.show();
  }
  
  void show(){
    strokeWeight(4);
    stroke(#080DFF);
    fill(#0879FF);
    
    beginShape();
    for(PVector v : skin)
      if(v != null)
        vertex(v.x, v.y); 
        
    endShape(CLOSE);
  }
}
