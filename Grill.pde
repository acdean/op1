// tile and a decal
class Grill extends Thing {

  Grill(Tile tile, float x, float y, boolean wireframe) {
    super(tile, x, y, wireframe);
    w = W2;
    h = H2;
  }

  @Override
  protected void _draw() {
    if (shape == null) {
      shape = createShape();
      shape.beginShape(QUAD);
      if (wireframe) {
        shape.noFill();
        shape.stroke(unhex(WIRE_COLOUR));
      } else {
        shape.texture(grillTex);
      }
      shape.vertex(0, 0, z + d + DECAL, 0, 0);
      shape.vertex(0, h, z + d + DECAL, 0, grillTex.height);
      shape.vertex(w, h, z + d + DECAL, grillTex.width, grillTex.height);
      shape.vertex(w, 0, z + d + DECAL, grillTex.width, 0);
      shape.endShape();
    }
    shape(shape);
  }
}

