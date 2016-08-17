
// all the tile types
class Tiles {
  public Tile tile1x1, tile1x2, tile2x1, tile2x2, tile4x2, tile1_5x1;
  
  public Tiles(boolean wireframe) {
    tile1x1 = new Tile(1, 1, wireframe);
    tile1x2 = new Tile(1, 2, wireframe);
    tile2x1 = new Tile(2, 1, wireframe);
    tile2x2 = new Tile(2, 2, wireframe);
    tile4x2 = new Tile(4, 2, wireframe);
    tile1_5x1 = new Tile(1.5, 1, wireframe);
  }
}

// new class to hold a tile
// this is a thin rectangle
// Each thing will position the relevant tile
class Tile {
  PShape s;
  float w, h, d, z;

  Tile(float w, float h, boolean wireframe) {
    // TODO spacing is slightly wrong for 1.5 width keys
    this.w = W * w + (w - 1.0) * S;  // nb spacing
    this.h = H * h + (h - 1.0) * S;
    this.z = -STUB;
    this.d = STUB;
    generateTile(wireframe);
  }
  
  void draw() {
    shape(s);
  }
  
  void generateTile(boolean wireframe) {
    s = createShape();
    s.beginShape(QUADS);
    if (wireframe) {
      s.noFill();
      s.stroke(unhex(WIRE_COLOUR));
    } else {
      s.noStroke();
      s.fill(unhex(BACKGROUND));
    }
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