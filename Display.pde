// tile and a decal
class Display extends Thing {

  Display(Tile tile, float x, float y) {
    super(tile, x, y);
    w = W + S + W + S + W + S + W;
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
        shape.texture(panelTex);
      }
      shape.vertex(0, 0, z + d + DECAL, 0, 0);
      shape.vertex(0, h, z + d + DECAL, 0, panelTex.height);
      shape.vertex(w, h, z + d + DECAL, panelTex.width, panelTex.height);
      shape.vertex(w, 0, z + d + DECAL, panelTex.width, 0);
      shape.endShape();
    }
    shape(shape);
  }
}