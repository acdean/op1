// pretty much same as button but higher
class Dial extends Thing {
  short tindex;

  Dial(Tile tile, float x, float y, boolean wireframe, int tindex) {
    super(tile, x, y, wireframe);
    w = W2;
    h = H2;
    this.tindex = (short)tindex;
  }

  //@Override
  protected void _draw2() {
    if (shape == null) {
      println("Creating Dial");
      shape = createShape(GROUP);
      // a decal on the tile and a cylinder
      if (!wireframe) {
        PShape decal = createShape();
        decal.beginShape(QUAD);
        decal.texture(dialTex);
        // decal is just a fraction above the tile
        decal.vertex(0, 0, z + d + DECAL, dialTextureX(tindex, -W2 / 2), dialTextureY(tindex, -H2 / 2));
        decal.vertex(0, h, z + d + DECAL, dialTextureX(tindex, -W2 / 2), dialTextureY(tindex, +H2 / 2));
        decal.vertex(w, h, z + d + DECAL, dialTextureX(tindex, +W2 / 2), dialTextureY(tindex, +H2 / 2));
        decal.vertex(w, 0, z + d + DECAL, dialTextureX(tindex, +W2 / 2), dialTextureY(tindex, -H2 / 2));
        decal.endShape();
        // add to main group
        shape.addChild(decal);
      }
      // cylinder
      PShape[] children = cylinder(w / 2.0, h / 2.0, BUTTON_RAD, DIAL_HEIGHT, tindex);
      // add to main shape
      shape.addChild(children[0]);
      shape.addChild(children[1]);
    }
    shape(shape);
  }

  // dial radius is 50 pixes at top, 90 pixels at bottom
  @Override
  protected void _draw() {
    if (shape == null) {
      println("Creating Dial");
      shape = createShape(GROUP);
      // flared cylinder, BUTTON_RAD at the top, BUTTON_RAD2 at the bottom
      ArrayList<PVector> points = new ArrayList();
      for (int i = 0 ; i < SEGMENTS ; i++) {
        float angle = TWO_PI * i / SEGMENTS;
        points.add(new PVector(cos(angle), sin(angle)));
      }
      // create main shape
      shape = createShape(GROUP);

      // top
      PShape top = createShape();
      top.beginShape(POLYGON);
      if (wireframe) {
        top.noFill();
        top.stroke(unhex(WIRE_COLOUR));
      } else {
        top.noStroke();
        top.fill(unhex(KEY_COLOUR));
      }
      for (PVector point : points) {
        top.vertex(w / 2 + BUTTON_RAD * point.x, h / 2 + BUTTON_RAD * point.y, DIAL_HEIGHT);
      }
      top.endShape(CLOSE);

      // sides - do this as quads or three quad strips?
      PShape sides = createShape();
      sides.beginShape(QUADS);
      if (wireframe) {
        sides.noFill();
        sides.stroke(unhex(WIRE_COLOUR));
      } else {
        sides.noStroke();
        sides.fill(unhex(KEY_COLOUR));
      }
      // A-B
      // D-C
      // first row (vertical)
      for (int i = 0 ; i < SEGMENTS ; i++) {
        int j = (i + 1) % SEGMENTS;
        sides.vertex(w / 2 + points.get(i).x * BUTTON_RAD, h / 2 + points.get(i).y * BUTTON_RAD, DIAL_HEIGHT);
        sides.vertex(w / 2 + points.get(j).x * BUTTON_RAD, h / 2 + points.get(j).y * BUTTON_RAD, DIAL_HEIGHT);
        sides.vertex(w / 2 + points.get(j).x * BUTTON_RAD, h / 2 + points.get(j).y * BUTTON_RAD, DIAL_CURVE);
        sides.vertex(w / 2 + points.get(i).x * BUTTON_RAD, h / 2 + points.get(i).y * BUTTON_RAD, DIAL_CURVE);
      }
      // later rows
      int ROWS = 4;
      for (int r = 0 ; r < ROWS ; r++) {
        float a0 = HALF_PI * r / ROWS;
        float a1 = HALF_PI * (r + 1) / ROWS;
        float r0 = BUTTON_RAD + DIAL_CURVE - (DIAL_CURVE * cos(a0));
        float h0 = DIAL_CURVE * (1 - sin(a0));
        float r1 = BUTTON_RAD + DIAL_CURVE - (DIAL_CURVE * cos(a1));
        float h1 = DIAL_CURVE * (1 - sin(a1));
        for (int i = 0 ; i < SEGMENTS ; i++) {
          int j = (i + 1) % SEGMENTS;
          sides.vertex(w / 2 + r0 * points.get(i).x, h / 2 + r0 * points.get(i).y, h0);
          sides.vertex(w / 2 + r0 * points.get(j).x, h / 2 + r0 * points.get(j).y, h0);
          sides.vertex(w / 2 + r1 * points.get(j).x, h / 2 + r1 * points.get(j).y, h1);
          sides.vertex(w / 2 + r1 * points.get(i).x, h / 2 + r1 * points.get(i).y, h1);
        }
      }
      sides.endShape();

      // add to main shape
      shape.addChild(top);
    }
    shape(shape);
  }
}