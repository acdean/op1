// pretty much same as button but higher
class Dial extends Thing {
  short tindex;

  Dial(Tile tile, float x, float y, boolean wireframe, int tindex) {
    super(tile, x, y, wireframe);
    w = W2;
    h = H2;
    this.tindex = (short)tindex;
  }

  @Override
  protected void _draw() {
    _draw3();
  }
  
  // a textured tile, a textured top, a straight shaft
  @Deprecated
  protected void _drawOriginal() {
    if (shape == null) {
      println("Creating Dial1");
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

  // second version - a curved shaft done using QUADS
  // shape is ok but it looks like it's flat shaded which jars with the power button
  @Deprecated
  protected void _draw2() {
    if (shape == null) {
      println("Creating Dial2");
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
      setDrawStyle(top, wireframe, KEY_COLOUR, dialTex);
      float a = 0;
      for (PVector point : points) {
        a += TWO_PI / points.size();
        float u = dialTextureX(tindex, BUTTON_RAD * cos(a));
        float v = dialTextureY(tindex, BUTTON_RAD * sin(a));
        top.vertex(w / 2 + BUTTON_RAD * point.x, h / 2 + BUTTON_RAD * point.y, DIAL_HEIGHT, u, v);
      }
      top.endShape(CLOSE);

      // sides - do this as quads or three quad strips?
      PShape sides = createShape();
      sides.beginShape(QUADS);
      setDrawStyle(sides, wireframe, KEY_COLOUR);

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

  // third version - a curved shaft done using QUAD_STRIPS
  protected void _draw3() {
    if (shape == null) {
      println("Creating Dial3");
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
      setDrawStyle(top, wireframe, KEY_COLOUR, dialTex);
      float a = 0;
      for (PVector point : points) {
        a += TWO_PI / points.size();
        float u = dialTextureX(tindex, BUTTON_RAD * cos(a));
        float v = dialTextureY(tindex, BUTTON_RAD * sin(a));
        top.vertex(w / 2 + BUTTON_RAD * point.x, h / 2 + BUTTON_RAD * point.y, DIAL_HEIGHT, u, v);
      }
      top.endShape(CLOSE);
      // add to main shape
      shape.addChild(top);

      // sides - do this as quads or three quad strips?
      PShape sides = createShape();
      sides.beginShape(QUAD_STRIP);
      setDrawStyle(sides, wireframe, KEY_COLOUR);

      // A-B
      // D-C
      // first row (vertical)
      for (int i = 0 ; i < SEGMENTS ; i++) {
        sides.normal(points.get(i).x, points.get(i).y, 0.0);
        sides.vertex(w / 2 + points.get(i).x * BUTTON_RAD, h / 2 + points.get(i).y * BUTTON_RAD, DIAL_HEIGHT);
        sides.normal(points.get(i).x, points.get(i).y, 0.0);
        sides.vertex(w / 2 + points.get(i).x * BUTTON_RAD, h / 2 + points.get(i).y * BUTTON_RAD, DIAL_CURVE);
      }
      sides.normal(points.get(0).x, points.get(0).y, 0.0);
      sides.vertex(w / 2 + points.get(0).x * BUTTON_RAD, h / 2 + points.get(0).y * BUTTON_RAD, DIAL_HEIGHT);
      sides.normal(points.get(0).x, points.get(0).y, 0.0);
      sides.vertex(w / 2 + points.get(0).x * BUTTON_RAD, h / 2 + points.get(0).y * BUTTON_RAD, DIAL_CURVE);
      sides.endShape();
      // add to main shape
      shape.addChild(sides);
      
      // later rows
      int ROWS = 4;
      for (int r = 0 ; r < ROWS ; r++) {
        float a0 = HALF_PI * r / ROWS;
        float a1 = HALF_PI * (r + 1) / ROWS;
        float r0 = BUTTON_RAD + DIAL_CURVE - (DIAL_CURVE * cos(a0));
        float h0 = DIAL_CURVE * (1 - sin(a0));
        float r1 = BUTTON_RAD + DIAL_CURVE - (DIAL_CURVE * cos(a1));
        float h1 = DIAL_CURVE * (1 - sin(a1));
        PShape row = createShape();
        row.beginShape(QUAD_STRIP);
        setDrawStyle(row, wireframe, KEY_COLOUR);

        PVector n; // normal
        for (int i = 0 ; i < SEGMENTS ; i++) {
          n = calcNormal(a0, i * (TWO_PI / SEGMENTS));
          row.normal(n.x, n.y, n.z);
          row.vertex(w / 2 + r0 * points.get(i).x, h / 2 + r0 * points.get(i).y, h0);
          n = calcNormal(a1, i * (TWO_PI / SEGMENTS));
          row.normal(n.x, n.y, n.z);
          row.vertex(w / 2 + r1 * points.get(i).x, h / 2 + r1 * points.get(i).y, h1);
        }
        // repeat the first two
        n = calcNormal(a0, 0);
        row.normal(n.x, n.y, n.z);
        row.vertex(w / 2 + r0 * points.get(0).x, h / 2 + r0 * points.get(0).y, h0);
        n = calcNormal(a1, 0);
        row.normal(n.x, n.y, n.z);
        row.vertex(w / 2 + r1 * points.get(0).x, h / 2 + r1 * points.get(0).y, h1);
        row.endShape();
        // add to main shape
        shape.addChild(row);
      }
    }
    shape(shape);
  }
  
  PVector calcNormal(float a1, float a2) {
    PVector n = new PVector(1, 0, 0);
    rotateY(n, a1 + PI); // up / down
    rotateZ(n, a2 + HALF_PI); // around (not sure why i need the HALF_PI here)
    //println("normal[" + degrees(a1) + "][" + degrees(a2) + "]: [" + n.x + "][" + n.y + "][" + n.z + "]");
    return n;
  }
  
  void rotateX(PVector p, float a) {
    float y = p.y * cos(a) + p.z * sin(a);
    float z = p.y * -sin(a) + p.z * cos(a);
    p.y = y;
    p.z = z;
  }

  void rotateY(PVector p, float a) {
    float x = p.x * cos(a) + p.z * sin(a);
    float z = p.x * -sin(a) + p.z * cos(a);
    p.x = x;
    p.z = z;
  }

  void rotateZ(PVector p, float a) {
    float x = p.x * cos(a) + p.y * sin(a);
    float y = p.x * -sin(a) + p.y * cos(a);
    p.x = x;
    p.y = y;
  }
}