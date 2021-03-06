float dialTextureX(short tindex, float in) {
  return W2 * tindex + (W2 / 2) + in;
}

float dialTextureY(short tindex, float in) {
  return (W2 / 2) + in;
}

// everything is a Thing
class Thing {
  Tile baseTile;
  PShape shape;
  float x, y, z;
  float w, h, d;
  boolean wireframe;

  Thing(Tile t, float x, float y, boolean wireframe) {
    baseTile = t;
    this.x = x;
    this.y = y;
    this.z = -STUB;
    this.w = W;
    this.h = H;
    this.d = STUB;
    this.wireframe = wireframe;
  }

  void draw() {
    pushMatrix();
    translate(x2x(x), y2y(y));
    if (baseTile != null) {
      baseTile.draw();
    }
    _draw();
    popMatrix();
  }
  // override this
  protected void _draw() {
    println("_draw: must override this");
  }

  // translates from button grid x to world x
  // origin is the top left of the top left button
  float x2x(float in) {
    // special cases for black buttons
    if (in != floor(in)) {
      // 4.5, 5.5, 8.5, 11.5, 12.5, 15.5
      return floor(in) * (W + S) - W + WH - (TOTAL_W / 2);
    }
    return (in * (W + S)) - (TOTAL_W / 2);
  }

  // translates from button grid y to world y
  float y2y(float in) {
    return (in * (H + S) - (TOTAL_H / 2));
  }

  float textureX(short tindex, float in) {
    return W * tindex + (W / 2) + in;
  }

  float textureY(short tindex, float in) {
    return (H / 2) + in;
  }

  float textureX0() {
    return 50 + (x * TW) + (floor(x) * TS);
  }

  float textureY0() {
    return 50 + (y * TH) + (floor(y) * TS);
  }

  float textureX1() {
    return textureX0() + w;
  }

  float textureY1() {
    return textureY0() + h;
  }

  // position, radius, height, texture
  PShape[] cylinder(float bx, float by, float r, float h, short tindex) {
    println("Cylinder: " + tindex);
    int start = 0, end = SEGMENTS;
    // top
    PShape p1 = createShape();
    p1.beginShape(POLYGON);

    // texture differs depending on type
    PImage thisTexture;
    if (h == STUB) {
      // standard button
      thisTexture = buttonTex;
    } else {
      // dial
      thisTexture = dialTex;
    }
    setDrawStyle(p1, wireframe, KEY_COLOUR, thisTexture);
    for (int i = start ; i <= end ; i++) {
      float a = TWO_PI * i / SEGMENTS;
      if (h == STUB) {
        // button
        p1.vertex(bx + r * cos(a), by + r * sin(a), z + d + h, textureX(tindex, r * cos(a)), textureY(tindex, r * sin(a)));
      } else {
        // dial
        p1.vertex(bx + r * cos(a), by + r * sin(a), z + d + h, dialTextureX(tindex, r * cos(a)), dialTextureY(tindex, r * sin(a)));
      }
    }
    p1.endShape();
    // sides
    PShape p2 = createShape();
    p2.beginShape(QUAD_STRIP);
    setDrawStyle(p2, wireframe, KEY_COLOUR);
    for (int i = start ; i <= end ; i++) { // NB includes final point
      float a = TWO_PI * i / SEGMENTS;
      p2.normal(cos(a), sin(a), 0.0);
      p2.vertex(bx + r * cos(a), by + r * sin(a), z + d);
      p2.normal(cos(a), sin(a), 0.0);
      p2.vertex(bx + r * cos(a), by + r * sin(a), z + d + h);
    }
    p2.endShape();
    // returning sides first as there appears to be a bug in 3.1.1
    return new PShape[] {p2, p1};
  }
}