// moved Key to own class as it's kind long

// global variable - this way there's only one
// (gets around problems with static in inline classes)
PShape keyShape;

class Key extends Thing {

  Key(float x, float y) {
    super(tile1x2, x, y);
    h = H2;
    z = 0;
  }

  // elongated version of button
  @Override
  protected void _draw() {
    if (keyShape == null) {
      println("Creating KeyShape");
      float top = 25 + BUTTON_RAD;
      float bottom = h - 25 - BUTTON_RAD;
      float bx, by;
      
      // reimplements code from Thing.buttonShape() (but better)
      ArrayList<PVector> points = new ArrayList();
      // top arc
      bx = w / 2;
      by = top;
      for (int i = SEGMENTS / 2 ; i <= SEGMENTS ; i++) { // NB equals
        float a = TWO_PI * i / SEGMENTS;
        points.add(new PVector(bx + BUTTON_RAD * cos(a), by + BUTTON_RAD * sin(a)));
      }
      // bottom arc
      bx = w / 2;
      by = bottom;
      for (int i = 0 ; i <= SEGMENTS / 2 ; i++) {  // NB equals
        float a = TWO_PI * i / SEGMENTS;
        points.add(new PVector(bx + BUTTON_RAD * cos(a), by + BUTTON_RAD * sin(a)));
      }
      
      // top shape
      PShape face = createShape();
      face.beginShape(POLYGON);
      if (wireframe) {
        face.noFill();
        face.stroke(unhex(WIRE_COLOUR));
      } else {
        face.noStroke();
        face.fill(unhex(KEY_COLOUR));
      }
      for (PVector p : points) {
        face.vertex(p.x, p.y, z + d);
      }
      // close circle
      face.vertex(points.get(0).x, points.get(0).y, z + d);
      face.endShape();

      PShape sides = createShape();
      sides.beginShape(QUAD_STRIP);
      if (wireframe) {
        sides.noFill();
        sides.stroke(unhex(WIRE_COLOUR));
      } else {
        sides.fill(unhex(KEY_COLOUR));
        sides.noStroke();
      }
      for (PVector p : points) {
        sides.vertex(p.x, p.y, z);
        sides.vertex(p.x, p.y, z + d);
      }
      // close strip
      sides.vertex(points.get(0).x, points.get(0).y, z);
      sides.vertex(points.get(0).x, points.get(0).y, z + d);
      sides.endShape();
      
      // create actual shape
      keyShape = createShape(GROUP);
      keyShape.addChild(face);
      keyShape.addChild(sides);
    }
    shape(keyShape);
  }
}