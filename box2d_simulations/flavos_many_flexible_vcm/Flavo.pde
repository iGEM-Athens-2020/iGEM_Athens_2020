class Flavo {
  
  RevoluteJoint joint1;
  RevoluteJoint joint2;
  RevoluteJoint joint3;
  RevoluteJoint joint4;
  RevoluteJoint joint5;
  RevoluteJoint joint6;
  RevoluteJoint joint7;
  RevoluteJoint joint8;
  RevoluteJoint joint9;
  RevoluteJoint joint10;
  RevoluteJoint joint11;
  RevoluteJoint joint12;
  DistanceJoint dj1;
  DistanceJoint dj2;
  DistanceJoint dj3;
  DistanceJoint dj4;
  DistanceJoint dj5;
  Body body;
  Box box1;
  Box box2;
  Box box3;
  Box box4;
  Box box5;
  Box box6;
  Particle node1;
  Particle node2;
  Particle node3;
  Particle node4;
  Particle node5;
  Particle node6;
  Particle node7;
  float w;
  float h;
  float r;
  float a2,a3,a4,a5,a6;
  float vel;
  float force;
  Vec2 center;
  boolean mode;
  float angle_;
  Vec2 pos1,pos2,pos3,pos4,pos5,pos6,pos7;
  
  Flavo(float x, float y,float angle) {
    w = 1;
    r = 0.1;
    h = 6.6;
    angle_ = angle;
    
      node1 = new Particle(x,y,r);
      node2 = new Particle(x+h*cos(angle),y+h*sin(angle),r);
      node3 = new Particle(x+2*h*cos(angle),y+2*h*sin(angle),r);
      node4 = new Particle(x+3*h*cos(angle),y+3*h*sin(angle),r);
      node5 = new Particle(x+4*h*cos(angle),y+4*h*sin(angle),r);
      node6 = new Particle(x+5*h*cos(angle),y+5*h*sin(angle),r);
      node7 = new Particle(x+6*h*cos(angle),y+6*h*sin(angle),r);
      Vec2 pos1 = box2d.getBodyPixelCoord(node1.body);
      Vec2 pos2 = box2d.getBodyPixelCoord(node2.body);
      Vec2 pos3 = box2d.getBodyPixelCoord(node3.body);
      Vec2 pos4 = box2d.getBodyPixelCoord(node4.body);
      Vec2 pos5 = box2d.getBodyPixelCoord(node5.body);
      Vec2 pos6 = box2d.getBodyPixelCoord(node6.body);
      Vec2 pos7 = box2d.getBodyPixelCoord(node7.body);
      box1 = new Box((pos1.x + pos2.x)/2, (pos1.y + pos2.y)/2, h, w); 
      box2 = new Box((pos2.x + pos3.x)/2, (pos2.y + pos3.y)/2, h, w); 
      box3 = new Box((pos3.x + pos4.x)/2, (pos3.y + pos4.y)/2, h, w); 
      box4 = new Box((pos4.x + pos5.x)/2, (pos4.y + pos5.y)/2, h, w); 
      box5 = new Box((pos5.x + pos6.x)/2, (pos5.y + pos6.y)/2, h, w); 
      box6 = new Box((pos6.x + pos7.x)/2, (pos6.y + pos7.y)/2, h, w);      
      box1.body.setTransform(box1.body.getWorldCenter(),-angle);
      box2.body.setTransform(box2.body.getWorldCenter(),-angle);
      box3.body.setTransform(box3.body.getWorldCenter(),-angle);
      box4.body.setTransform(box4.body.getWorldCenter(),-angle);
      box5.body.setTransform(box5.body.getWorldCenter(),-angle);
      box6.body.setTransform(box6.body.getWorldCenter(),-angle);
      
    // Define joint as between two bodies
    RevoluteJointDef rjd1 = new RevoluteJointDef();
    rjd1.initialize(node1.body, box1.body, node1.body.getWorldCenter());
    rjd1.enableLimit = true;
    rjd1.lowerAngle = -PI/6;
    rjd1.upperAngle = PI/6;
    // Create the joint
    joint1 = (RevoluteJoint) box2d.world.createJoint(rjd1);
    
    RevoluteJointDef rjd2 = new RevoluteJointDef();
    rjd2.initialize(box1.body, node2.body, node2.body.getWorldCenter());
    rjd2.enableLimit = true;
    rjd2.lowerAngle = -PI/6;
    rjd2.upperAngle = PI/6;    
    // Create the joint
    joint2 = (RevoluteJoint) box2d.world.createJoint(rjd2);
    
    RevoluteJointDef rjd3 = new RevoluteJointDef();
    rjd3.initialize(node2.body, box2.body, node2.body.getWorldCenter());
    rjd3.enableLimit = true;
    rjd3.lowerAngle = -PI/6;
    rjd3.upperAngle = PI/6;
    // Create the joint
    joint3 = (RevoluteJoint) box2d.world.createJoint(rjd3);
    
    RevoluteJointDef rjd4 = new RevoluteJointDef();
    rjd4.initialize(box2.body, node3.body, node3.body.getWorldCenter());
    rjd4.enableLimit = true;
    rjd4.lowerAngle = -PI/6;
    rjd4.upperAngle = PI/6;
    // Create the joint
    joint4 = (RevoluteJoint) box2d.world.createJoint(rjd4);
    
    RevoluteJointDef rjd5 = new RevoluteJointDef();
    rjd5.initialize(node3.body, box3.body, node3.body.getWorldCenter());
    rjd5.enableLimit = true;
    rjd5.lowerAngle = -PI/6;
    rjd5.upperAngle = PI/6;
    // Create the joint
    joint5 = (RevoluteJoint) box2d.world.createJoint(rjd5);
    
    RevoluteJointDef rjd6 = new RevoluteJointDef();
    rjd6.initialize(box3.body, node4.body, node4.body.getWorldCenter());
    rjd6.enableLimit = true;
    rjd6.lowerAngle = -PI/6;
    rjd6.upperAngle = PI/6;
    // Create the joint
    joint6 = (RevoluteJoint) box2d.world.createJoint(rjd6);
    
    RevoluteJointDef rjd7 = new RevoluteJointDef();
    rjd7.initialize(node4.body, box4.body, node4.body.getWorldCenter());
    rjd7.enableLimit = true;
    rjd7.lowerAngle = -PI/6;
    rjd7.upperAngle = PI/6;
    // Create the joint
    joint7 = (RevoluteJoint) box2d.world.createJoint(rjd7);
    
    RevoluteJointDef rjd8 = new RevoluteJointDef();
    rjd8.initialize(box4.body, node5.body, node5.body.getWorldCenter());
    rjd8.enableLimit = true;
    rjd8.lowerAngle = -PI/6;
    rjd8.upperAngle = PI/6;
    // Create the joint
    joint8 = (RevoluteJoint) box2d.world.createJoint(rjd8);
    
    RevoluteJointDef rjd9 = new RevoluteJointDef();
    rjd9.initialize(node5.body, box5.body, node5.body.getWorldCenter());
    rjd9.enableLimit = true;
    rjd9.lowerAngle = -PI/6;
    rjd9.upperAngle = PI/6;
    // Create the joint
    joint9 = (RevoluteJoint) box2d.world.createJoint(rjd9);
    
    RevoluteJointDef rjd10 = new RevoluteJointDef();
    rjd10.initialize(box5.body, node6.body, node6.body.getWorldCenter());
    rjd10.enableLimit = true;
    rjd10.lowerAngle = -PI/6;
    rjd10.upperAngle = PI/6;
    // Create the joint
    joint10 = (RevoluteJoint) box2d.world.createJoint(rjd10);
    
    RevoluteJointDef rjd11 = new RevoluteJointDef();
    rjd11.initialize(node6.body, box6.body, node6.body.getWorldCenter());
    rjd11.enableLimit = true;
    rjd11.lowerAngle = -PI/6;
    rjd11.upperAngle = PI/6;
    // Create the joint
    joint11 = (RevoluteJoint) box2d.world.createJoint(rjd11);
    
    RevoluteJointDef rjd12 = new RevoluteJointDef();
    rjd12.initialize(box6.body, node7.body, node7.body.getWorldCenter());
    rjd12.enableLimit = true;
    rjd12.lowerAngle = -PI/6;
    rjd12.upperAngle = PI/6;
    // Create the joint
    joint12 = (RevoluteJoint) box2d.world.createJoint(rjd12);
    
    DistanceJointDef dist13= new DistanceJointDef();
    dist13.bodyA = node1.body;
    dist13.bodyB = node3.body;
    dist13.length = box2d.scalarPixelsToWorld(2*h);
    dist13.frequencyHz = 10;
    dist13.dampingRatio = 1.0;
    DistanceJoint dj1 = (DistanceJoint) box2d.world.createJoint(dist13);
    
    DistanceJointDef dist24= new DistanceJointDef();
    dist24.bodyA = node2.body;
    dist24.bodyB = node4.body;
    dist24.length = box2d.scalarPixelsToWorld(2*h);
    dist24.frequencyHz = 10;
    dist24.dampingRatio = 1.0;
    DistanceJoint dj2 = (DistanceJoint) box2d.world.createJoint(dist24);
    
    DistanceJointDef dist35= new DistanceJointDef();
    dist35.bodyA = node3.body;
    dist35.bodyB = node5.body;
    dist35.length = box2d.scalarPixelsToWorld(2*h);
    dist35.frequencyHz = 10;
    dist35.dampingRatio = 1.0;
    DistanceJoint dj3 = (DistanceJoint) box2d.world.createJoint(dist35);
    
    DistanceJointDef dist46 = new DistanceJointDef();
    dist46.bodyA = node4.body;
    dist46.bodyB = node6.body;
    dist46.length = box2d.scalarPixelsToWorld(2*h);
    dist46.frequencyHz = 10;
    dist46.dampingRatio = 1.0;
    DistanceJoint dj4 = (DistanceJoint) box2d.world.createJoint(dist46);
    
    DistanceJointDef dist57= new DistanceJointDef();
    dist57.bodyA = node5.body;
    dist57.bodyB = node7.body;
    dist57.length = box2d.scalarPixelsToWorld(2*h);
    dist57.frequencyHz = 10;
    dist57.dampingRatio = 1.0;
    DistanceJoint dj5 = (DistanceJoint) box2d.world.createJoint(dist57);
     
     
}

  void apply_vel(){
       a2 = node2.body.getAngle() - angle_;
       a3 = node3.body.getAngle() - angle_;
       a4 = node4.body.getAngle() - angle_;
       a5 = node5.body.getAngle() - angle_;
       a6 = node6.body.getAngle() - angle_;  
     vel = 0.5;
     Vec2 vel2 = new Vec2(vel*cos(a2),vel*sin(a2));
     node2.body.setLinearVelocity(vel2);
     Vec2 vel3 = new Vec2(vel*cos(a3),vel*sin(a3));
     node3.body.setLinearVelocity(vel3);
     Vec2 vel4 = new Vec2(vel*cos(a4),vel*sin(a4));
     node4.body.setLinearVelocity(vel4);
     Vec2 vel5 = new Vec2(vel*cos(a5),vel*sin(a5));
     node5.body.setLinearVelocity(vel5);
     Vec2 vel6 = new Vec2(vel*cos(a6),vel*sin(a6));
     node6.body.setLinearVelocity(vel6);
  }
   void apply_force(){
    Vec2 pos1 = box2d.getBodyPixelCoord(node1.body);
    Vec2 pos2 = box2d.getBodyPixelCoord(node2.body);
    Vec2 pos3 = box2d.getBodyPixelCoord(node3.body);
    Vec2 pos4 = box2d.getBodyPixelCoord(node4.body);
    Vec2 pos5 = box2d.getBodyPixelCoord(node5.body);
    Vec2 pos6 = box2d.getBodyPixelCoord(node6.body);
    Vec2 pos7 = box2d.getBodyPixelCoord(node7.body);   
    float coeff = 100;

    Vec2 mid13 = new Vec2((pos1.x+pos3.x)/2,(pos1.y+pos3.y)/2);
    Vec2 mid24 = new Vec2((pos2.x+pos4.x)/2,(pos2.y+pos4.y)/2);
    Vec2 mid35 = new Vec2((pos3.x+pos5.x)/2,(pos3.y+pos5.y)/2);
    Vec2 mid46 = new Vec2((pos4.x+pos6.x)/2,(pos4.y+pos6.y)/2);
    Vec2 mid57 = new Vec2((pos5.x+pos7.x)/2,(pos5.y+pos7.y)/2);
    
    Vec2 force2 = new Vec2(coeff*(mid13.x - pos2.x),coeff*(mid13.y-pos2.y));
    Vec2 force3 = new Vec2(coeff*(mid24.x - pos3.x),coeff*(mid24.y-pos3.y));
    Vec2 force4 = new Vec2(coeff*(mid35.x - pos4.x),coeff*(mid35.y-pos4.y));
    Vec2 force5 = new Vec2(coeff*(mid46.x - pos5.x),coeff*(mid46.y-pos5.y));
    Vec2 force6 = new Vec2(coeff*(mid57.x - pos6.x),coeff*(mid57.y-pos6.y));
    
    node2.body.applyForce(force2,node2.body.getWorldCenter());
    node3.body.applyForce(force3,node3.body.getWorldCenter());
    node4.body.applyForce(force4,node4.body.getWorldCenter());
    node5.body.applyForce(force5,node5.body.getWorldCenter());
    node6.body.applyForce(force6,node6.body.getWorldCenter()); 

  }
  void display() {
    box2.display();
    box1.display();
    box3.display();
    box4.display();
    box5.display();
    box6.display();
    node2.display();
    node1.display();
    node3.display();
    node4.display();
    node5.display();
    node6.display();
    node7.display();
    //to show the linear springs/distance joints
    /*Vec2 pos1 = box2d.getBodyPixelCoord(node1.body);
    Vec2 pos2 = box2d.getBodyPixelCoord(node2.body);
    Vec2 pos3 = box2d.getBodyPixelCoord(node3.body);
    Vec2 pos4 = box2d.getBodyPixelCoord(node4.body);
    Vec2 pos5 = box2d.getBodyPixelCoord(node5.body);
    Vec2 pos6 = box2d.getBodyPixelCoord(node6.body);
    Vec2 pos7 = box2d.getBodyPixelCoord(node7.body);
    stroke(0);
    strokeWeight(2);
    line(pos1.x,pos1.y,pos3.x,pos3.y);
    stroke(0);
    strokeWeight(2);
    line(pos2.x,pos2.y,pos4.x,pos4.y);
    stroke(0);
    strokeWeight(2);
    line(pos3.x,pos3.y,pos5.x,pos5.y);
    stroke(0);
    strokeWeight(2);
    line(pos4.x,pos4.y,pos6.x,pos6.y);
    stroke(0);
    strokeWeight(2);
    line(pos5.x,pos5.y,pos7.x,pos7.y);*/
  }
  }
