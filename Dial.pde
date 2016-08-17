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
}