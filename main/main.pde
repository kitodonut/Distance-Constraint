Body skeleton;
Fish fish;
Lizzard lizzard;

void setup(){
 size(800, 600);
 float[] r = {70, 60, 50, 40, 30, 20, 10};
 skeleton = new Body(width * .5, 50, r, 1.0);
 
 fish = new Fish(random(50, width - 50), random(50, height - 50), 0.4);
 lizzard = new Lizzard(random(50, width - 50), random(50, height - 50), 0.4);
}

void mousePressed(){
  PVector v = PVector.random2D().mult(100);
  fish.applyForce(v);
  
  v = PVector.random2D().mult(50);
  lizzard.applyForce(v);
  
  v = PVector.random2D().mult(50);
  skeleton.applyForce(v);
}

void draw(){
  background(0);
  
  skeleton.update();
  fish.update();
  lizzard.update();
  
  skeleton.show();
  fish.show();
  lizzard.show();
  
  println(frameRate);
}
