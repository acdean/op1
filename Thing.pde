class Thing {
  PShape shape;
  float x, y, z;
  float w, h, d;

  Thing(float x, float y) {
    this.x = x;
    this.y = y;
    this.z = -STUB;
    this.w = W;
    this.h = H;
    this.d = STUB;
  }

  void draw() {
    pushMatrix();
    translate(x2x(x), y2y(y));
    _draw();
    popMatrix();
  }
  // override this
  protected void _draw() {
    if (shape == null) {
      shape = myBox();
    }
    shape(shape);
  }

  float x2x(float in) {
    // special cases for black buttons
    if (in != floor(in)) {
      // 4.5, 5.5, 8.5, 11.5, 12.5, 15.5
      return floor(in) * (W + S) - W + WH; 
    }
    return (in * (W + S));
  }

  float y2y(float in) {
    return (in * (H + S));
  }

  float textureX(short tindex, float in) {
    return W * tindex + (W / 2) + in;
  }

  float textureY(short tindex, float in) {
    return (H / 2) + in;
  }

  float dialTextureX(short tindex, float in) {
    return W2 * tindex + (W2 / 2) + in;
  }

  float dialTextureY(short tindex, float in) {
    return (W2 / 2) + in;
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

  // base of everything
  PShape myBox() {
    println("Creating Tile");
    PShape p = createShape();
    p.beginShape(QUADS);
    p.fill(unhex(BACKGROUND));
    // top
    p.vertex(0, 0, z + d);
    p.vertex(w, 0, z + d);
    p.vertex(w, h, z + d);
    p.vertex(0, h, z + d);
    // bottom
//    p.fill(128, 0, 0);
//    p.vertex(0, 0, z);
//    p.vertex(w, 0, z);
//    p.vertex(w, h, z);
//    p.vertex(0, h, z);
    // y side
    p.vertex(0, 0, z);
    p.vertex(0, 0, z + d);
    p.vertex(w, 0, z + d);
    p.vertex(w, 0, z);
    // x side
    p.vertex(0, 0, z);
    p.vertex(0, 0, z + d);
    p.vertex(0, h, z + d);
    p.vertex(0, h, z);
    // y side
    p.vertex(0, h, z);
    p.vertex(0, h, z + d);
    p.vertex(w, h, z + d);
    p.vertex(w, h, z);
    // x side
    p.vertex(w, 0, z);
    p.vertex(w, 0, z + d);
    p.vertex(w, h, z + d);
    p.vertex(w, h, z);
    p.endShape();
    return p;
  }
  
  int ALL = 999;
  short NO_TEX = -1;
  PShape[] buttonShape(float bx, float by, float r) {
    println("ButtonShape1");
    return buttonShape(bx, by, r, ALL, NO_TEX);
  }
  PShape[] buttonShape(float bx, float by, float r, short tindex) {
    println("ButtonShape2");
    return buttonShape(bx, by, r, ALL, tindex);
  }
  PShape[] buttonShape(float bx, float by, float r, int part) {
    println("ButtonShape3");
    return buttonShape(bx, by, r, part, NO_TEX);
  }
  // part = TOP or BOTTOM or ALL (so we can use this to draw keys)
  PShape[] buttonShape(float bx, float by, float r, int part, short tindex) {
    println("ButtonShape: " + tindex);
    int start, end;
    if (part == BOTTOM) {
      start = 0;
      end = SEGMENTS / 2;
    } else if (part == TOP) {
      start = SEGMENTS / 2;
      end = SEGMENTS;
    } else {
      // all
      start = 0;
      end = SEGMENTS;
    }
    // top
    if (tindex != NO_TEX) {  // debug
      println("Texture[" + bx + "][" + by + "]: [" + textureX(tindex, 0) + "][" + textureY(tindex, 0) + "]");
    }
    PShape p1 = createShape();
    p1.beginShape(POLYGON);
    p1.fill(unhex(KEY_COLOUR));
    p1.texture(buttonTex);
//    p1.vertex(bx, by, z + d + STUB, textureX(tindex, 0), textureY(tindex, 0));
    for (int i = start ; i <= end ; i++) {
      float a = TWO_PI * i / SEGMENTS;
      if (tindex == NO_TEX) {
        p1.vertex(bx + r * cos(a), by + r * sin(a), z + d + STUB);
      } else {
        p1.vertex(bx + r * cos(a), by + r * sin(a), z + d + STUB, textureX(tindex, r * cos(a)), textureY(tindex, r * sin(a)));
      }
    }
    p1.endShape();
    // sides
    PShape p2 = createShape();
    p2.beginShape(QUAD_STRIP);
    p2.fill(unhex(KEY_COLOUR));
    for (int i = start ; i <= end ; i++) {
      float a = TWO_PI * i / SEGMENTS;
      p2.vertex(bx + r * cos(a), by + r * sin(a), z + d);
      p2.vertex(bx + r * cos(a), by + r * sin(a), z + d + STUB);
    }
    p2.endShape();
    return new PShape[] {p1, p2};
  }

  // position, radius, height, texture
  PShape[] cylinder(float bx, float by, float r, float h, short tindex) {
    println("ButtonShape: " + tindex);
    int start = 0, end = SEGMENTS;
    // top
    if (tindex != NO_TEX) {  // debug
      println("Texture[" + bx + "][" + by + "]: [" + textureX(tindex, 0) + "][" + textureY(tindex, 0) + "]");
    }
    PShape p1 = createShape();
    p1.beginShape(POLYGON);
    p1.fill(unhex(KEY_COLOUR));
    if (h == STUB) {
      // standard button
      p1.texture(buttonTex);
    } else {
      // dial
      p1.texture(dialTex);
    }
//    p1.vertex(bx, by, z + d + STUB, textureX(tindex, 0), textureY(tindex, 0));
    for (int i = start ; i <= end ; i++) {
      float a = TWO_PI * i / SEGMENTS;
      if (tindex == NO_TEX) {
        p1.vertex(bx + r * cos(a), by + r * sin(a), z + d + h);
      } else {
        if (h == STUB) {
          // button
          p1.vertex(bx + r * cos(a), by + r * sin(a), z + d + h, textureX(tindex, r * cos(a)), textureY(tindex, r * sin(a)));
        } else {
          // dial
          p1.vertex(bx + r * cos(a), by + r * sin(a), z + d + h, dialTextureX(tindex, r * cos(a)), dialTextureY(tindex, r * sin(a)));
        }
      }
    }
    p1.endShape();
    // sides
    PShape p2 = createShape();
    p2.beginShape(QUAD_STRIP);
    p2.fill(unhex(KEY_COLOUR));
    for (int i = start ; i <= end ; i++) {
      float a = TWO_PI * i / SEGMENTS;
      p2.vertex(bx + r * cos(a), by + r * sin(a), z + d);
      p2.vertex(bx + r * cos(a), by + r * sin(a), z + d + h);
    }
    p2.endShape();
    return new PShape[] {p1, p2};
  }
}