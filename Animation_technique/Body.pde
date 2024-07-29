class Body{
  private Anchor[] spine;
  private PVector headPos, vel, acc;
  private float mass;

  Body(float x, float y, float[] radius){
    spine = new Anchor[radius.length];
    
    float previousRadius = 0;
    
    for(int i = 0; i < radius.length; i++) {
      spine[i] = new Anchor(x, y + previousRadius, radius[i]);
      previousRadius += radius[i];
    }
    
    mass = previousRadius * 0.1;
    
    acc = new PVector(0, 0);
    vel = new PVector(0, 0);
    headPos = spine[0].getPos();
  }
  
  void update(){
    edges();
    
    vel.add(acc);
    headPos.add(vel);
    
    //Update all the other points of the spine
    for(int i = 0; i < spine.length - 1 ; i++) { // the last one does not have to update any other anchor
      spine[i].constraint(spine[i+1]);
    }
    
    acc.set(0, 0);
  }
  
  void applyForce(PVector force){
    // F = m * a
    acc.set(force.div(mass));
  }
  
  void setVel(PVector v){
    vel.set(v);
  }
  
  void show(){    
    for(Anchor p: spine)
      p.show();
  }
  
  private void edges(){
    if(headPos.x + vel.x >= width || headPos.x + vel.x <= 0) vel.set(-vel.x, vel.y);
    if(headPos.y + vel.y >= height || headPos.y + vel.y <= 0) vel.set(vel.x, -vel.y);
  }
}
