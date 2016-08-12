// new class to hold a tile
// this is a thin rectangle
// Each thing will position the relevant tile
class Tile {
  PShape s;
  float w, h, d, z;

  Tile(float w, float h) {
    // TODO spacing is slightly wrong for 1.5 width keys
    this.w = W * w + (w - 1.0) * S;  // nb spacing
    this.h = H * h + (h - 1.0) * S;
    this.z = -STUB;
    this.d = STUB;
    generateTile();
  }
  
  void draw() {
    shape(s);
  }
  
  void generateTile() {
    s = createShape();
    s.beginShape(QUADS);
    s.noStroke();
    s.fill(unhex(BACKGROUND));
    // top
    s.vertex(0, 0, z + d);
    s.vertex(w, 0, z + d);
    s.vertex(w, h, z + d);
    s.vertex(0, h, z + d);
    // bottom
    s.vertex(0, 0, z + 0);
    s.vertex(w, 0, z + 0);
    s.vertex(w, h, z + 0);
    s.vertex(0, h, z + 0);
    // south side
    s.vertex(0, 0, z + 0);
    s.vertex(0, 0, z + d);
    s.vertex(w, 0, z + d);
    s.vertex(w, 0, z + 0);
    // west side
    s.vertex(0, 0, z + 0);
    s.vertex(0, 0, z + d);
    s.vertex(0, h, z + d);
    s.vertex(0, h, z + 0);
    // north side
    s.vertex(0, h, z + 0);
    s.vertex(0, h, z + d);
    s.vertex(w, h, z + d);
    s.vertex(w, h, z + 0);
    // east side
    s.vertex(w, 0, z + 0);
    s.vertex(w, 0, z + d);
    s.vertex(w, h, z + d);
    s.vertex(w, h, z + 0);

    s.endShape();
  }
}