// no tile, only a decal
class Right extends Thing {

  Right(float x, float y, boolean wireframe) {
    super(null, x, y, wireframe);
    w = W;                  // single button width
    h = (6 * H) + (5 * S);  // 6 buttons high
  }

  @Override
  protected void _draw() {
    if (wireframe) {
      // just a decal - do absolutely nothing
    } else {
      // define and use shape
      if (shape == null) {
        shape = createShape();
        shape.beginShape(QUAD);
        shape.texture(rightTex);
        // just a fraction above the body
        shape.vertex(0, 0, Body.BODY_DEPTH + DECAL, 0, 0);
        shape.vertex(0, h, Body.BODY_DEPTH + DECAL, 0, rightTex.height);
        shape.vertex(w, h, Body.BODY_DEPTH + DECAL, rightTex.width, rightTex.height);
        shape.vertex(w, 0, Body.BODY_DEPTH + DECAL, rightTex.width, 0);
        shape.endShape();
      }
      shape(shape);
    }
  }
}

