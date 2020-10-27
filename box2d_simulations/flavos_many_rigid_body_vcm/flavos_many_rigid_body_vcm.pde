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
Flavo p;
float angle;
float rand_x,rand_y;
ArrayList<Particle> particles;
ArrayList<Boundary> boundaries;
ArrayList<Flavo> flavos;
ArrayList<Float> angles;
int population;
ArrayList<Vec2> positions;
Vec2 pos;
boolean flag;
int len;

void setup() {
  size(500,500);
  // Initialize box2d physics and create the world
  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  box2d.setGravity(0,0);
  
  //initializations
  boundaries = new ArrayList<Boundary>();
  flavos = new ArrayList<Flavo>();
  positions = new ArrayList<Vec2>();
  angles = new ArrayList<Float>();
  
  //change this to control number of flavos
  population = 500;
  
  //spawn the boundaries  
  boundaries.add(new Boundary(width/2,height-5,width,10,0));
  boundaries.add(new Boundary(width/2,5,width,10,0));
  boundaries.add(new Boundary(width-5,height/2,10,height,0));
  boundaries.add(new Boundary(5,height/2,10,height,0));
  
  //random position in world avoid boundaries, add to list as tuple, initialize one flavo to help the process below
  rand_x = (width-20)*random(0.05,0.95);
  rand_y = (height-20)*random(0.05,0.95);
  pos = new Vec2 (rand_x,rand_y);
  positions.add(pos);
  
  //random angle add to list
  angle = 2*PI*random(0,1);
  angles.add(angle);
  
  //add flavo to list of flavos
  Flavo p = new Flavo(rand_x,rand_y,angle);
  flavos.add(p);
  
  //length of the flavo 6 rectangles of width 5, change it to variable,do not change this number!
  len = 5*6;
  
  //part below makse sure that flavos dont get spawned on top of each other by checking if the 2 line segments intersect
  for( int i=0;i<population-1;i++){
    while(true){
      flag = true;
      //guessing a position again
      rand_x = (width-20)*random(0.1,0.95);
      rand_y = (height-20)*random(0.1,0.95);
      angle = 2*PI*random(0,1);
      //making 2 tuples for the positions of the 2 ends of the flavo
      Vec2 first_pos = new Vec2 (rand_x,rand_y);
      Vec2 last_pos = new Vec2 (rand_x + len*cos(angle),rand_y + len*sin(angle));
      int j = 0;
      //checking if the new flavo can be spawned, if its not intersecting any other flavo
      for(Vec2 test: positions){   
        float angl = angles.get(j);
        Vec2 test_end = new Vec2 (test.x+len*cos(angl),test.y+len*sin(angl));
        int o1 = orientation(first_pos, last_pos, test); 
        int o2 = orientation(first_pos, last_pos, test_end); 
        int o3 = orientation(test, test_end, first_pos); 
        int o4 = orientation(test, test_end, last_pos);
        j++;
        if (o1 != o2 && o3 != o4) flag = false;
      }
      if(flag==true) break;
    }
    //if it can be spawned then add the position the angle and the flavo to the appropriate lists
    pos = new Vec2(rand_x,rand_y);
    positions.add(pos);
    angles.add(angle);
    Flavo p1 = new Flavo(rand_x,rand_y,angle);
    flavos.add(p1);
  }

}

//auxiliary function
int orientation(Vec2 p, Vec2 q, Vec2 r) 
{ 
    float val = (q.y - p.y) * (r.x - q.x) - 
              (q.x - p.x) * (r.y - q.y); 
  
    if (val == 0) return 0;
  
    return (val > 0)? 1: 2;
} 

void draw() {
  background(255);
  for (Boundary wall: boundaries) {
    wall.display();
  }
  box2d.step();
  //apply linear velocity to all flavos
  for (Flavo p: flavos) {
    p.apply_vel();
    p.display();   
  }
  
  
  fill(0);
}

 /*void mousePressed() {
  angle = 2*PI*random(0,1);
  Flavo p = new Flavo(mouseX,mouseY,angle);
  flavos.add(p);
}*/
