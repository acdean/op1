// the model of the OP1. contains all the tiles.
class Model {
  
  List<Thing> things = new ArrayList<Thing>();
  Tiles tiles;
  PShape keyShape; // one keyshape per Model. initialised in Key.

  Model() {
    this(false);
  }
  Model(boolean wireframe) {
    tiles = new Tiles(wireframe);

    // body
    things.add(new Body(0, 0, wireframe));  // no tile
    // line 0
    things.add(new Grill(tiles.tile2x2, 0, 0, wireframe));
    things.add(new VolumeButton(tiles.tile2x1, 2, 0, wireframe));
    things.add(new Display(tiles.tile4x2, 4, 0, wireframe));
    things.add(new Dial(tiles.tile2x2, 8, 0, wireframe, 0));
    things.add(new Dial(tiles.tile2x2, 10, 0, wireframe, 1));
    things.add(new Dial(tiles.tile2x2, 12, 0, wireframe, 2));
    things.add(new Dial(tiles.tile2x2, 14, 0, wireframe, 3));
    things.add(new Button(tiles.tile1x1, 16, 0, wireframe, 0));
    things.add(new Right(17, 0, wireframe));  // no tile
    // line 1
    things.add(new Button(tiles.tile1x1, 2, 1, wireframe, 2));  // numbering cockup
    things.add(new Button(tiles.tile1x1, 3, 1, wireframe, 3));
    things.add(new Button(tiles.tile1x1, 16, 1, wireframe, 1));
    // line 2
    things.add(new Button(tiles.tile1x1, 0, 2, wireframe, 4));
    things.add(new Button(tiles.tile1x1, 1, 2, wireframe, 5));
    things.add(new Button(tiles.tile1x1, 2, 2, wireframe, 6));
    things.add(new Button(tiles.tile1x1, 3, 2, wireframe, 7));
    things.add(new Button(tiles.tile1x1, 4, 2, wireframe, 8));
    things.add(new Button(tiles.tile1x1, 5, 2, wireframe, 9));
    things.add(new Button(tiles.tile1x1, 6, 2, wireframe, 10));
    things.add(new Button(tiles.tile1x1, 7, 2, wireframe, 11));
    things.add(new Button(tiles.tile1x1, 8, 2, wireframe, 12));
    things.add(new Button(tiles.tile1x1, 9, 2, wireframe, 13));
    things.add(new Button(tiles.tile1x1, 10, 2, wireframe, 14));
    things.add(new Button(tiles.tile1x1, 11, 2, wireframe, 15));
    things.add(new Button(tiles.tile1x1, 12, 2, wireframe, 16));
    things.add(new Button(tiles.tile1x1, 13, 2, wireframe, 17));
    things.add(new Button(tiles.tile1x1, 14, 2, wireframe, 18));
    things.add(new Button(tiles.tile1x1, 15, 2, wireframe, 19));
    things.add(new Button(tiles.tile1x1, 16, 2, wireframe, 20));
    // line 3
    things.add(new Button(tiles.tile1x1, 0, 3, wireframe, 21));
    things.add(new Button(tiles.tile1x1, 1, 3, wireframe, 22));
    things.add(new Button(tiles.tile1x1, 2, 3, wireframe, 23));
    things.add(new BlackKey(tiles.tile1_5x1, 3, 3, wireframe, BlackKey.RIGHT));
    things.add(new BlackKey(tiles.tile1x1, 4.5, 3, wireframe, BlackKey.MIDDLE));
    things.add(new BlackKey(tiles.tile1_5x1, 5.5, 3, wireframe, BlackKey.LEFT));
    things.add(new BlackKey(tiles.tile1_5x1, 7, 3, wireframe, BlackKey.RIGHT));
    things.add(new BlackKey(tiles.tile1_5x1, 8.5, 3, wireframe, BlackKey.LEFT));
    things.add(new BlackKey(tiles.tile1_5x1, 10, 3, wireframe, BlackKey.RIGHT));
    things.add(new BlackKey(tiles.tile1x1, 11.5, 3, wireframe, BlackKey.MIDDLE));
    things.add(new BlackKey(tiles.tile1_5x1, 12.5, 3, wireframe, BlackKey.LEFT));
    things.add(new BlackKey(tiles.tile1_5x1, 14, 3, wireframe, BlackKey.RIGHT));
    things.add(new BlackKey(tiles.tile1_5x1, 15.5, 3, wireframe, BlackKey.LEFT));
    // line 4
    things.add(new Button(tiles.tile1x1, 0, 4, wireframe, 24));
    things.add(new Button(tiles.tile1x1, 1, 4, wireframe, 25));
    things.add(new Button(tiles.tile1x1, 2, 4, wireframe, 26));
    // all keys share the same keyShape
    things.add(new Key(tiles.tile1x2, keyShape, 3, 4, wireframe));
    things.add(new Key(tiles.tile1x2, keyShape, 4, 4, wireframe));
    things.add(new Key(tiles.tile1x2, keyShape, 5, 4, wireframe));
    things.add(new Key(tiles.tile1x2, keyShape, 6, 4, wireframe));
    things.add(new Key(tiles.tile1x2, keyShape, 7, 4, wireframe));
    things.add(new Key(tiles.tile1x2, keyShape, 8, 4, wireframe));
    things.add(new Key(tiles.tile1x2, keyShape, 9, 4, wireframe));
    things.add(new Key(tiles.tile1x2, keyShape, 10, 4, wireframe));
    things.add(new Key(tiles.tile1x2, keyShape, 11, 4, wireframe));
    things.add(new Key(tiles.tile1x2, keyShape, 12, 4, wireframe));
    things.add(new Key(tiles.tile1x2, keyShape, 13, 4, wireframe));
    things.add(new Key(tiles.tile1x2, keyShape, 14, 4, wireframe));
    things.add(new Key(tiles.tile1x2, keyShape, 15, 4, wireframe));
    things.add(new Key(tiles.tile1x2, keyShape, 16, 4, wireframe));
    // line 5
    things.add(new Button(tiles.tile1x1, 0, 5, wireframe, 27));
    things.add(new Button(tiles.tile1x1, 1, 5, wireframe, 28));
    things.add(new Button(tiles.tile1x1, 2, 5, wireframe, 29));
  }
  
  void draw() {
    for (Thing thing : things) {
      thing.draw();
    }
  }
}