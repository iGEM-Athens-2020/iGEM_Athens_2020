import shiffman.box2d.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.joints.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.collision.shapes.Shape;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.contacts.*;

Box2DProcessing box2d;

Flavo flavo;
Flavo p1;

ArrayList<Particle> particles;
ArrayList<Boundary> boundaries;
ArrayList<Flavo> flavos;

void setup() {
  size(400,400);
  // Initialize box2d physics and create the world
  box2d = new Box2DProcessing(this);
  
  box2d.createWorld();
  box2d.setGravity(0,0);
  
  boundaries = new ArrayList<Boundary>();
  flavos = new ArrayList<Flavo>();
  Flavo p1 = new Flavo(width/4,height/4,false);
  flavos.add(p1);
  boundaries.add(new Boundary(width/2,height-5,width,10,0));
  boundaries.add(new Boundary(width/2,5,width,10,0));
  boundaries.add(new Boundary(width-5,height/2,10,height,0));
  boundaries.add(new Boundary(5,height/2,10,height,0));

}

void draw() {
  background(255);
  for (Boundary wall: boundaries) {
    wall.display();
  }
  box2d.step();
  int i = 0;
  for (Flavo p: flavos) {
    if (i==0) {p.apply_vel(false); }
    if (i==1) {
      p.apply_vel(true); 
  }
    p.display();
    i = i+1;
    
  }
  
  
  fill(0);
}


void mousePressed() {
  Flavo p = new Flavo(mouseX,mouseY,true);
  flavos.add(p);
}
