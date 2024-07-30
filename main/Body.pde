class Body{
  protected Anchor[] spine;
  protected PVector[] skin;
  protected PVector headPos, vel, acc;
  protected float mass;

  Body(float x, float y, float[] radius, float scl /*scale is a key word*/){
    if(scl != 1.0) radius = scaleRadius(radius, scl); //scale the radius to make it smaller or bigger
    if(scl <= 0.0) throw new IllegalArgumentException("The scale must be > 0.0");
    
    spine = new Anchor[radius.length];
    float previousRadius = 0;
    
    for(int i = 0; i < radius.length; i++) {
      spine[i] = new Anchor(x, y + previousRadius, radius[i]);
      previousRadius += radius[i];
    }
    
    mass = previousRadius * 0.1; // The 10% of the sum of the radius will be the mass
    
    acc = new PVector(0, 0);
    vel = new PVector(0, 0);
    headPos = spine[0].getPos(); // A reference to the position of the first anchor
    
    skin = getSkinVertices();
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
    
    //Update the skin vertices
    skin = getSkinVertices();
    
    acc.set(0, 0);
  }
  
  void show(){    
    for(Anchor p: spine)
      p.show();
    
    stroke(255, 0, 0);
    strokeWeight(4);
        
    for(PVector v: skin)
      if(v != null) // When it does not have velocity there are some nulls
        point(v.x, v.y);
  }
  
  void applyForce(PVector force){
    // F = m * a
    acc.add(force.copy().div(mass));
  }
  
  void setVel(PVector v){
    vel.set(v);
  }
  
  Anchor getHead(){
    return spine[0];
  }
  
  Anchor getTail(){
    return spine[spine.length - 1];
  }
  
  PVector[] getSkinVertices(){
    PVector[] vertices = new PVector[2 * spine.length + 6]; // 2 vertices for each anchor plus three more for the tail and head each
    
     // x = pos.x + radius * cos Alpha
     // y = pos.y + radius * sin Alpha
    
    //Head
    float radius = getHead().getRadius();
    
    float alpha = vel.heading();
    float x = headPos.x + radius * cos(alpha);
    float y = headPos.y + radius * sin(alpha);
    
    vertices[0] = new PVector(x, y);
    
    alpha = vel.copy().rotate(HALF_PI * .5).heading();
    x = headPos.x + radius * cos(alpha);
    y = headPos.y + radius * sin(alpha);
    
    vertices[1] = new PVector(x, y);
    
    alpha = vel.copy().rotate(HALF_PI).heading();
    x = headPos.x + radius * cos(alpha);
    y = headPos.y + radius * sin(alpha);
    
    vertices[2] = new PVector(x, y);
    
    alpha = vel.copy().rotate(-HALF_PI).heading();
    x = headPos.x + radius * cos(alpha);
    y = headPos.y + radius * sin(alpha);
    
    vertices[vertices.length - 2] = new PVector(x, y); 
    
    alpha = vel.copy().rotate(HALF_PI * -.5).heading();
    x = headPos.x + radius * cos(alpha);
    y = headPos.y + radius * sin(alpha);
    
    vertices[vertices.length - 1] = new PVector(x, y); 
    
    //Body
    for(int i = 1; i < spine.length; i++){
      PVector pos = spine[i].getPos();
      PVector dir = spine[i].getVectorConstraint(spine[i - 1]);
      radius = spine[i].getRadius();
      
      // Upper body
      alpha = dir.copy().rotate(HALF_PI).heading();
      x = pos.x + radius * cos(alpha);
      y = pos.y + radius * sin(alpha);
      
      vertices[i + 2] = new PVector(x, y);
      
      // Inferior body
      alpha = dir.copy().rotate(-HALF_PI).heading();
      x = pos.x + radius * cos(alpha);
      y = pos.y + radius * sin(alpha);
      
      //i + 2 + 2 * (spine.length - i - 1) + 3 + 1
      vertices[2*spine.length - i + 4] = new PVector(x, y);
    }
    
    // Tail
    Anchor tail = getTail();
    radius = tail.getRadius();
    PVector dir = tail.getVectorConstraint(spine[spine.length - 2]).copy().mult(-1);
    PVector pos = tail.getPosCopy();
    
    alpha = dir.heading();
    x = pos.x + radius * cos(alpha);
    y = pos.y + radius * sin(alpha);
    
    vertices[spine.length + 3] = new PVector(x, y);
    
    alpha = dir.copy().rotate(HALF_PI * -.5).heading();
    x = pos.x + radius * cos(alpha);
    y = pos.y + radius * sin(alpha);
    
    vertices[spine.length + 2] = new PVector(x, y);
    
    alpha = dir.copy().rotate(HALF_PI * .5).heading();
    x = pos.x + radius * cos(alpha);
    y = pos.y + radius * sin(alpha);
    
    vertices[spine.length + 4] = new PVector(x, y);
    
    return vertices;
  }
  
  private void edges(){
    if(headPos.x + vel.x >= width || headPos.x + vel.x <= 0) vel.set(-vel.x, vel.y);
    if(headPos.y + vel.y >= height || headPos.y + vel.y <= 0) vel.set(vel.x, -vel.y);
  }
  
  private float[] scaleRadius(float[] original, float scale) {
    float[] scaled = new float[original.length];
    for (int i = 0; i < original.length; i++) {
      scaled[i] = original[i] * scale;
      
      if(scaled[i] < 1.0) scaled[i] = 1.0; // the minimun length of radius must be 1.0
    }
    return scaled;
  }
}
