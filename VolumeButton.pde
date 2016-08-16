// similar to dial / buttom
class VolumeButton extends Thing {

  VolumeButton(Tile tile, float x, float y) {
    super(tile, x, y);
    w = W2;
  }

  @Override
  protected void _draw() {
    if (shape == null) {
      println("Creating VolumeButtonShape");
      shape = createShape(GROUP);
      // NB this is treated as a 5th dial because of the height
      PShape[] children = cylinder(w / 4.0, h / 2.0, BUTTON_RAD, DIAL_HEIGHT, (short)4);
      shape.addChild(children[0]);
      shape.addChild(children[1]);
    }
    shape(shape);
  }
}