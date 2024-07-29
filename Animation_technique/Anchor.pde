class Anchor {
  private PVector pos;
  private float radius;
  
  Anchor(float x, float y, float r) {
    pos = new PVector(x, y);
    radius = r;
  }
  
  void update(PVector p){
    pos.set(p);
  }
  
  void update(float x, float y){
    pos.set(x, y);
  }
  
  void changeRadius(float r){
    radius = r;
  }
  
  void show(){
    noFill();
    strokeWeight(1);
    stroke(65);
    circle(pos.x, pos.y, radius * 2);
    
    strokeWeight(8);
    stroke(255);
    point(pos.x, pos.y);
  }
  
  PVector getPosCopy(){
    return pos.copy();
  }
  
  PVector getPos(){
    return pos;
  }
  
  float getRadius(){
    return radius;
  }
  
  PVector getVectorConstraint(PVector p){
    return p.copy().sub(pos).setMag(radius);
  }
  
  PVector getVectorConstraint(Anchor other){
    return other.getPosCopy().sub(pos).setMag(radius);
  }
  
  void constraint(Anchor other){
    PVector dir = this.getVectorConstraint(other).add(pos);
    other.update(dir);
  }

}
