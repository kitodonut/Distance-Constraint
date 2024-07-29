Body skeleton;

void setup(){
 size(600, 600);
 float[] r = {70, 60, 50, 40, 30, 20, 10};
 skeleton = new Body(width * .5, 50, r);
}

void mousePressed(){
  PVector v = PVector.random2D().mult(100);
  skeleton.applyForce(v);
}

void draw(){
  background(0);
  
  skeleton.update();
  skeleton.show();
}
