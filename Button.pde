// simple textured round button
class Button extends Thing {

  // one of these for each button - because of decal
  short tindex;

  Button(Tile tile, float x, float y, boolean wireframe, int tindex) {
    super(tile, x, y, wireframe);
    this.tindex = (short)tindex;
  }

  @Override
  protected void _draw() {
    if (shape == null) {
      shape = createShape(GROUP);
      PShape[] children = cylinder(w / 2.0, h / 2.0, BUTTON_RAD, STUB, tindex);
      shape.addChild(children[0]);
      shape.addChild(children[1]);
    }
    shape(shape);
  }
}

