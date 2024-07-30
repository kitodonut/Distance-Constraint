class Body{
  protected Anchor[] spine;
  protected PVector headPos, vel, acc;
  protected float mass;

  Body(float x, float y, float[] radius, float scl /*scale is a key word*/){
    if(scl != 1.0) radius = scaleRadius(radius, scl);
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
    
    //Needs to impose an angle constraint (spine's level of flexivility)
    
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
    acc.add(force.div(mass));
  }
  
  void setVel(PVector v){
    vel.set(v);
  }
  
  void show(){    
    for(Anchor p: spine)
      p.show();
  }
  
  Anchor getHead(){
    return spine[0];
  }
  
  Anchor getTail(){
    return spine[spine.length - 1];
  }
  
  private void edges(){
    if(headPos.x + vel.x >= width || headPos.x + vel.x <= 0) vel.set(-vel.x, vel.y);
    if(headPos.y + vel.y >= height || headPos.y + vel.y <= 0) vel.set(vel.x, -vel.y);
  }
  
  private float[] scaleRadius(float[] original, float scale) {
    float[] scaled = new float[original.length];
    for (int i = 0; i < original.length; i++) {
      scaled[i] = original[i] * scale;
      
      if(scaled[i] < 1.0) scaled[i] = 1.0;
    }
    return scaled;
  }
}
