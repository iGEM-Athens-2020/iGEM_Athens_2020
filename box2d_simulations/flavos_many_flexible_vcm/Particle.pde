class Particle {

  Body body;
  float r;
  Particle(float x, float y, float r_) {
    r = r_;
    makeBody(x, y, r);
    body.setUserData(this);
  }

  void killBody() {
    box2d.destroyBody(body);
  }

  void display() {
    Vec2 pos = box2d.getBodyPixelCoord(body);
    float a = body.getAngle();
    pushMatrix();
    translate(pos.x, pos.y);

    rotate(-a);
    fill(127);
    stroke(0);
    strokeWeight(2);
    ellipse(0, 0, r*2, r*2);
    line(0, 0, r, 0);
    popMatrix();
  }

  void makeBody(float x, float y, float r) {
    BodyDef bd = new BodyDef();
    bd.position = box2d.coordPixelsToWorld(x, y);
    bd.type = BodyType.DYNAMIC;

    body = box2d.world.createBody(bd);
    CircleShape cs = new CircleShape();
    cs.m_radius = box2d.scalarPixelsToWorld(r);

    FixtureDef fd = new FixtureDef();
    fd.shape = cs;

    fd.density = 5000;
    fd.friction = 0.6;
    fd.restitution = 0.1;

    body.createFixture(fd);
  }
}
