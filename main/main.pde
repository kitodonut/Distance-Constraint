ArrayList<Body> corps = new ArrayList<Body>();

void setup(){
 size(800, 600);
 /*
 float[] r = {70, 60, 50, 40, 30, 20, 10};
 skeleton = new Body(width * .5, 50, r, 1.0);
 
 fish = new Fish(random(50, width - 50), random(50, height - 50), 0.4);
 lizzard = new Lizzard(random(50, width - 50), random(50, height - 50), 0.4);
 */
 
 corps.add(new Snake(50, 50, 0.4));
 
 for(int i = 0; i < 10; i++)
   corps.add(new Fish(random(50, width - 50), random(50, height - 50), random(0.15, 0.25)));
 corps.add(new Lizzard(random(50, width - 50), random(50, height - 50), 0.3));
}

void mousePressed(){
  for(Body c: corps){
    PVector f = PVector.random2D().mult(random(50, 75));
    c.applyForce(f);
  }
}

void draw(){
  background(168);
  
  for(Body c: corps){
    c.update();
    c.show();
  }
  
  println(frameRate);
}
