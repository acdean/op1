// the model of the OP1. contains all the tiles.
class Model {
  Tile tile1x1, tile1x2, tile2x1, tile2x2, tile4x2, tile1_5x1;
  List<Thing> things = new ArrayList<Thing>();

  Model() {
    // tiles (these may be per-model. probably shouldn't be)
    // can't be singletons though because we may need wireframe and non-wireframe.
    tile1x1 = new Tile(1, 1);
    tile1x2 = new Tile(1, 2);
    tile2x1 = new Tile(2, 1);
    tile2x2 = new Tile(2, 2);
    tile4x2 = new Tile(4, 2);
    tile1_5x1 = new Tile(1.5, 1);

    // body
    things.add(new Body(0, 0));  // no tile
    // line 0
    things.add(new Grill(tile2x2, 0, 0));
    things.add(new VolumeButton(tile2x1, 2, 0));
    things.add(new Display(tile4x2, 4, 0));
    things.add(new Dial(tile2x2, 8, 0, 0));
    things.add(new Dial(tile2x2, 10, 0, 1));
    things.add(new Dial(tile2x2, 12, 0, 2));
    things.add(new Dial(tile2x2, 14, 0, 3));
    things.add(new Button(tile1x1, 16, 0, 0));
    things.add(new Right(17, 0));  // no tile
    // line 1
    things.add(new Button(tile1x1, 2, 1, 2));  // numbering cockup
    things.add(new Button(tile1x1, 3, 1, 3));
    things.add(new Button(tile1x1, 16, 1, 1));
    // line 2
    things.add(new Button(tile1x1, 0, 2, 4));
    things.add(new Button(tile1x1, 1, 2, 5));
    things.add(new Button(tile1x1, 2, 2, 6));
    things.add(new Button(tile1x1, 3, 2, 7));
    things.add(new Button(tile1x1, 4, 2, 8));
    things.add(new Button(tile1x1, 5, 2, 9));
    things.add(new Button(tile1x1, 6, 2, 10));
    things.add(new Button(tile1x1, 7, 2, 11));
    things.add(new Button(tile1x1, 8, 2, 12));
    things.add(new Button(tile1x1, 9, 2, 13));
    things.add(new Button(tile1x1, 10, 2, 14));
    things.add(new Button(tile1x1, 11, 2, 15));
    things.add(new Button(tile1x1, 12, 2, 16));
    things.add(new Button(tile1x1, 13, 2, 17));
    things.add(new Button(tile1x1, 14, 2, 18));
    things.add(new Button(tile1x1, 15, 2, 19));
    things.add(new Button(tile1x1, 16, 2, 20));
    // line 3
    things.add(new Button(tile1x1, 0, 3, 21));
    things.add(new Button(tile1x1, 1, 3, 22));
    things.add(new Button(tile1x1, 2, 3, 23));
    things.add(new BlackKey(tile1_5x1, 3, 3, BlackKey.RIGHT));
    things.add(new BlackKey(tile1x1, 4.5, 3, BlackKey.MIDDLE));
    things.add(new BlackKey(tile1_5x1, 5.5, 3, BlackKey.LEFT));
    things.add(new BlackKey(tile1_5x1, 7, 3, BlackKey.RIGHT));
    things.add(new BlackKey(tile1_5x1, 8.5, 3, BlackKey.LEFT));
    things.add(new BlackKey(tile1_5x1, 10, 3, BlackKey.RIGHT));
    things.add(new BlackKey(tile1x1, 11.5, 3, BlackKey.MIDDLE));
    things.add(new BlackKey(tile1_5x1, 12.5, 3, BlackKey.LEFT));
    things.add(new BlackKey(tile1_5x1, 14, 3, BlackKey.RIGHT));
    things.add(new BlackKey(tile1_5x1, 15.5, 3, BlackKey.LEFT));
    // line 4
    things.add(new Button(tile1x1, 0, 4, 24));
    things.add(new Button(tile1x1, 1, 4, 25));
    things.add(new Button(tile1x1, 2, 4, 26));
    things.add(new Key(tile1x2, 3, 4));
    things.add(new Key(tile1x2, 4, 4));
    things.add(new Key(tile1x2, 5, 4));
    things.add(new Key(tile1x2, 6, 4));
    things.add(new Key(tile1x2, 7, 4));
    things.add(new Key(tile1x2, 8, 4));
    things.add(new Key(tile1x2, 9, 4));
    things.add(new Key(tile1x2, 10, 4));
    things.add(new Key(tile1x2, 11, 4));
    things.add(new Key(tile1x2, 12, 4));
    things.add(new Key(tile1x2, 13, 4));
    things.add(new Key(tile1x2, 14, 4));
    things.add(new Key(tile1x2, 15, 4));
    things.add(new Key(tile1x2, 16, 4));
    // line 5
    things.add(new Button(tile1x1, 0, 5, 27));
    things.add(new Button(tile1x1, 1, 5, 28));
    things.add(new Button(tile1x1, 2, 5, 29));
  }
  
  void draw() {
    for (Thing thing : things) {
      thing.draw();
    }
  }
}