// tile and a decal
class Display extends Thing {

  Display(Tile tile, float x, float y, boolean wireframe) {
    super(tile, x, y, wireframe);
    w = W + S + W + S + W + S + W;
    h = H2;
  }

  @Override
  protected void _draw() {
    if (shape == null) {
      shape = createShape();
      shape.beginShape(QUAD);
      setDrawStyle(shape, wireframe, KEY_COLOUR, panelTex);
      shape.vertex(0, 0, z + d + DECAL, 0, 0);
      shape.vertex(0, h, z + d + DECAL, 0, panelTex.height);
      shape.vertex(w, h, z + d + DECAL, panelTex.width, panelTex.height);
      shape.vertex(w, 0, z + d + DECAL, panelTex.width, 0);
      shape.endShape();
    }
    shape(shape);
  }
}