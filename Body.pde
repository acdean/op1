// this is the main wraparound body
class Body extends Thing {

  PShape shape = null;
  int allignment;

  Body(float x, float y) {
    super(null, x, y);
  }

  @Override
  protected void _draw() {
    if (shape == null) {
      println("Creating Body");
      shape = createShape();
      shape.beginShape(QUAD_STRIP);
      shape.fill(unhex(BACKGROUND));

      float x0 = x - LEFT_MARGIN;
      float x1 = x;
      float x2 = x + (17 * W) + (16 * S);  // nb spacing
      float x3 = x2 + RIGHT_MARGIN;
      float y0 = y - TOP_MARGIN;
      float y1 = y;
      float y2 = y + (6 * H) + (5 * S);  // nb spacing
      float y3 = y2 + BOTTOM_MARGIN;
      float z = -STUB / 2.0;
      println("X: " + x0 + " , " + x3 + " = " + ((x3 + x0) / 2));
      println("Y: " + y0 + " , " + y3 + " = " + ((y3 + y0) / 2));
      
// A------------C   A = 0, 0
// | B--------D |   Y1 = TOP_MARGIN
// | |        | |
// | H--------F |   Y2 = TOP_MARGIN + 6 * H
// G------------E   Y3 = TOP_MARGIN + 6 * H + BOTTOM_MARGIN
// X X        X X
//   1        2 3   X1 = x + LEFT_MARGIN
//                  X2 = X1 + 17 * W
//                  X3 = X2 + RIGHT_MARGIN

      // ABCD
      shape.vertex(x0, y0, z); // A
      shape.vertex(x1, y1, z); // B
      shape.vertex(x3, y0, z); // C
      shape.vertex(x2, y1, z); // D
      // EF
      shape.vertex(x3, y3, z);  // E
      shape.vertex(x2, y2, z);  // F
      // GH
      shape.vertex(x0, y3, z);  // G
      shape.vertex(x1, y2, z);  // H
      // AB
      shape.vertex(x0, y0, z); // A
      shape.vertex(x1, y1, z); // B
      shape.endShape();
    }
    shape(shape);
  }
}