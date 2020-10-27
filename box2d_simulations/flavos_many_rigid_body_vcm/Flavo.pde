class Flavo {
  
  RevoluteJoint joint1;
  RevoluteJoint joint2;
  Body body;
  Box box1;
  Particle node1;
  Particle node2;
  float w;
  float h;
  float r;
  float a1,a2;
  float vel;
  float force;
  Vec2 center;
  boolean mode;
  float angle_;
  Vec2 pos1,pos2;
  
  Flavo(float x, float y,float angle) {
    w = 1;
    r = 0.1;
    h = 5*6;
    angle_ = angle;
    
    // Initialize positions of two boxes
      node1 = new Particle(x,y,r);
      node2 = new Particle(x+h*cos(angle),y+h*sin(angle),r);
      Vec2 pos1 = box2d.getBodyPixelCoord(node1.body);
      Vec2 pos2 = box2d.getBodyPixelCoord(node2.body);
      box1 = new Box((pos1.x + pos2.x)/2, (pos1.y + pos2.y)/2, h, w); 
      box1.body.setTransform(box1.body.getWorldCenter(),-angle);
         // Define joint as between two bodies
    RevoluteJointDef rjd1 = new RevoluteJointDef();
    rjd1.initialize(node1.body, box1.body, node1.body.getWorldCenter());
    rjd1.enableLimit = true;
    rjd1.lowerAngle = -PI/100;
    rjd1.upperAngle = PI/100;
    // Create the joint
    joint1 = (RevoluteJoint) box2d.world.createJoint(rjd1);
    
    RevoluteJointDef rjd2 = new RevoluteJointDef();
    rjd2.initialize(box1.body, node2.body, node2.body.getWorldCenter());
    rjd2.enableLimit = true;
    rjd2.lowerAngle = -PI/100;
    rjd2.upperAngle = PI/100;    
    // Create the joint
    joint2 = (RevoluteJoint) box2d.world.createJoint(rjd2);
}

  void apply_vel(){
    a1 = box1.body.getAngle();
    vel = 1;
    Vec2 vel1 = new Vec2(vel*cos(a1),vel*sin(a1));
    node1.body.setLinearVelocity(vel1);
    node2.body.setLinearVelocity(vel1); }

  void display(){
    box1.display();   
    node2.display();
    node1.display();
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
