class Box {

  Body body;
  float w;
  float h;
  float weight;
  color col;
  Box(float x, float y, float w_, float h_, float weight_) {
    w = w_;
    h = h_;
    weight = weight_;
    
    col = color(127);
    BodyDef bd = new BodyDef();
    bd.position.set(box2d.coordPixelsToWorld(new Vec2(x,y)));
    bd.type = BodyType.DYNAMIC;

    body = box2d.createBody(bd);
    body.setUserData(this);
    PolygonShape sd = new PolygonShape();
    float box2dW = box2d.scalarPixelsToWorld(w/2);
    float box2dH = box2d.scalarPixelsToWorld(h/2);
    sd.setAsBox(box2dW, box2dH);

    FixtureDef fd = new FixtureDef();
    fd.shape = sd;
    fd.density = weight;
    fd.friction = 0.6;
    fd.restitution = 0.1;

    body.createFixture(fd);
  }

  void killBody() {
    box2d.destroyBody(body);
  }

  void change(){
    col = color(255,0,0);
  }
  
  void display() {
    Vec2 pos = box2d.getBodyPixelCoord(body);
    float a = body.getAngle();

    rectMode(PConstants.CENTER);
    pushMatrix();
    translate(pos.x,pos.y);
    rotate(-a);
    fill(col);
    stroke(0);
    strokeWeight(2);
    rect(0,0,w,h);
    popMatrix();
  }
}
