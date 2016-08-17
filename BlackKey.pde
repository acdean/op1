// complicated by size and allignment
class BlackKey extends Thing {
  public static final int MIDDLE = 0;
  public static final int RIGHT = 1;
  public static final int LEFT = 2;

  int allignment;

  BlackKey(Tile tile, float x, float y, boolean wireframe, int allignment) {
    super(tile, x, y, wireframe);
    if (allignment == RIGHT || allignment == LEFT) {
      // this key is 1.5 wide
      w = WH;
    } else {
    }
    this.allignment = allignment;
  }

  @Override
  protected void _draw() {
    if (shape == null) {
      println("Creating BlackKeyShape");
      shape = createShape(GROUP);
      PShape[] children = null;
      switch (allignment) {
        case LEFT:
          children = cylinder(25 + BUTTON_RAD, h / 2, BUTTON_RAD, STUB, (short)30);
          break;
        case MIDDLE:
          children = cylinder(w / 2, h / 2, BUTTON_RAD, STUB, (short)30);
          break;
        case RIGHT:
          children = cylinder(WH - BUTTON_RAD - 25, h / 2, BUTTON_RAD, STUB, (short)30);
          break;
      }
      shape.addChild(children[0]);
      shape.addChild(children[1]);
    }
    shape(shape);
  }
}