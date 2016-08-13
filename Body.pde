// this is the main wraparound body
class Body extends Thing {
  
  public static final float BODY_DEPTH = -5;

  PShape shape = null;
  int allignment;

  Body(float x, float y) {
    super(null, x, y);
  }

  // /-------\
  // |       | 0
  // \-------/
  @Override
  protected void _draw() {
    if (shape == null) {
      println("Creating Body");
      
      ArrayList<PVector> points = new ArrayList();
     
      float x1 = x - LEFT_MARGIN + BUTTON_RAD;  // top left x and y
      float y1 = y - TOP_MARGIN + BUTTON_RAD;
      float x2 = x + (17 * W) + (16 * S) + RIGHT_MARGIN - BUTTON_RAD;  // bottom left x and y
      float y2 = y + (6 * H) + (5 * S) + BOTTOM_MARGIN - BUTTON_RAD;  // bottom left x and y
      float z0 = BODY_DEPTH;
      float z1 = -D;

      // top left
      for (int i = SEGMENTS / 2 ; i <= SEGMENTS * 3 / 4 ; i++) {  // NB equals
        float a = TWO_PI * i / SEGMENTS;
        points.add(new PVector(x1 + BUTTON_RAD * cos(a), y1 + BUTTON_RAD * sin(a)));
      }
      // top right
      for (int i = SEGMENTS * 3 / 4 ; i <= SEGMENTS ; i++) {
        float a = TWO_PI * i / SEGMENTS;
        points.add(new PVector(x2 + BUTTON_RAD * cos(a), y1 + BUTTON_RAD * sin(a)));
      }
      // bottom right
      for (int i = 0 ; i <= SEGMENTS / 4 ; i++) {
        float a = TWO_PI * i / SEGMENTS;
        points.add(new PVector(x2 + BUTTON_RAD * cos(a), y2 + BUTTON_RAD * sin(a)));
      }
      // bottom left
      for (int i = SEGMENTS / 4 ; i <= SEGMENTS / 2 ; i++) {
        float a = TWO_PI * i / SEGMENTS;
        points.add(new PVector(x1 + BUTTON_RAD * cos(a), y2 + BUTTON_RAD * sin(a)));
      }
      
      PShape topFace = createShape();
      topFace.beginShape(POLYGON);
      topFace.fill(unhex(BACKGROUND));
      for (PVector p : points) {
        topFace.vertex(p.x, p.y, z1);
      }
      topFace.vertex(points.get(0).x, points.get(0).y, z1);
      topFace.endShape();

      // bottom face is reverse order
      PShape bottomFace = createShape();
      bottomFace.beginShape(POLYGON);
      bottomFace.fill(unhex(BACKGROUND));
      for (int i = points.size() - 1 ; i >= 0 ; i--) { 
        PVector p = points.get(i);
        bottomFace.vertex(p.x, p.y, z0);
      }
      bottomFace.vertex(points.get(points.size() - 1).x, points.get(points.size() - 1).y, z1);
      bottomFace.endShape();

      // sides
      PShape sides = createShape();
      sides.beginShape(QUAD_STRIP);
      sides.fill(unhex(BACKGROUND));
      for (PVector p : points) {
        sides.vertex(p.x, p.y, z0);
        sides.vertex(p.x, p.y, z1);
      }
      sides.vertex(points.get(0).x, points.get(0).y, z0);
      sides.vertex(points.get(0).x, points.get(0).y, z1);
      sides.endShape();

      shape = createShape(GROUP);
      shape.addChild(topFace);
      shape.addChild(bottomFace);
      shape.addChild(sides);
    }
    shape(shape);
  }
}