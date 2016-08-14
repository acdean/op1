// a spinning op-1
// acd 2016
// TODO
// nothing...

import java.util.List;
import peasy.*;

// measurements are taken from png, except D which is 8th of total height according to specs
public static final float W = 150;  // width of a button
public static final float H = 150;  // height of a button
public static final float S = 8;    // separation = 8
public static final float TOP_MARGIN = 45;
public static final float LEFT_MARGIN = TOP_MARGIN;
public static final float BOTTOM_MARGIN = TOP_MARGIN;
public static final float RIGHT_MARGIN = 175;
public static final float D = (TOP_MARGIN + (6 * H) + (5 * S) + BOTTOM_MARGIN) / 8.0; 
public static final float STUB = 10; // height of a tile, height of a button
public static final float DIAL_HEIGHT = STUB * 10;  // height of a dial
public static final float DECAL = .02; // height of decal
public static final float W2 = W + S + W; // double width key
public static final float WH = ((W + S + W + S + W) - S) / 2; // W and a half - for black keys
public static final float H2 = H + S + H; // double height key

public static final int SEGMENTS = 20; //24;
public static final float BUTTON_RAD = 50; // buttons are 25 + 100 + 25 => RAD = 50

public static final float TW = 158; // texture width multiplier
public static final float TH = 158; // texture height multiplier
public static final float TS = 8; // texture separator

public static final String BACKGROUND = "ffc3c9c9";
public static final String KEY_COLOUR = "ffdee9e9";
public static final String WIRE_COLOUR = "ff00ff00";  // green

List<Thing> things = new ArrayList<Thing>();
PeasyCam cam;
PImage tex;
PImage buttonTex;
PImage panelTex;
PImage grillTex;
PImage dialTex;
PImage rightTex;
Tile tile1x1, tile1x2, tile2x1, tile2x2, tile4x2, tile1_5x1;
float rx, ry, rz, dx, dy, dz;

boolean wireframe = false;
boolean record = false;

void setup() {
  size(1280, 720, P3D);
  cam = new PeasyCam(this, 1600);
  // texture
  tex = loadImage("op1.png");
  buttonTex = loadImage("op1_buttons.png");
  panelTex = loadImage("op1_panel.png");
  grillTex = loadImage("op1_grill.png");
  dialTex = loadImage("op1_dials.png");
  rightTex = loadImage("op1_right.png");
  
  dx = random(-.02, .02);
  dy = random(-.02, .02);
  dz = random(-.02, .02);
  
  // tiles
  tile1x1 = new Tile(1, 1);
  tile1x2 = new Tile(1, 2);
  tile2x1 = new Tile(2, 1);
  tile2x2 = new Tile(2, 2);
  tile4x2 = new Tile(4, 2);
  tile1_5x1 = new Tile(1.5, 1);

  // body
  things.add(new Body(0, 0));
  // line 0
  things.add(new Grill(0, 0));
  things.add(new VolumeButton(2, 0));
  things.add(new Display(4, 0));
  things.add(new Dial(8, 0, 0));
  things.add(new Dial(10, 0, 1));
  things.add(new Dial(12, 0, 2));
  things.add(new Dial(14, 0, 3));
  things.add(new Button(16, 0, 0));
  things.add(new Right(17, 0));
  // line 1
  things.add(new Button(2, 1, 2));  // numbering cockup
  things.add(new Button(3, 1, 3));
  things.add(new Button(16, 1, 1));
  // line 2
  things.add(new Button(0, 2, 4));
  things.add(new Button(1, 2, 5));
  things.add(new Button(2, 2, 6));
  things.add(new Button(3, 2, 7));
  things.add(new Button(4, 2, 8));
  things.add(new Button(5, 2, 9));
  things.add(new Button(6, 2, 10));
  things.add(new Button(7, 2, 11));
  things.add(new Button(8, 2, 12));
  things.add(new Button(9, 2, 13));
  things.add(new Button(10, 2, 14));
  things.add(new Button(11, 2, 15));
  things.add(new Button(12, 2, 16));
  things.add(new Button(13, 2, 17));
  things.add(new Button(14, 2, 18));
  things.add(new Button(15, 2, 19));
  things.add(new Button(16, 2, 20));
  // line 3
  things.add(new Button(0, 3, 21));
  things.add(new Button(1, 3, 22));
  things.add(new Button(2, 3, 23));
  things.add(new BlackKey(3, 3, BlackKey.RIGHT));
  things.add(new BlackKey(4.5, 3, BlackKey.MIDDLE));
  things.add(new BlackKey(5.5, 3, BlackKey.LEFT));
  things.add(new BlackKey(7, 3, BlackKey.RIGHT));
  things.add(new BlackKey(8.5, 3, BlackKey.LEFT));
  things.add(new BlackKey(10, 3, BlackKey.RIGHT));
  things.add(new BlackKey(11.5, 3, BlackKey.MIDDLE));
  things.add(new BlackKey(12.5, 3, BlackKey.LEFT));
  things.add(new BlackKey(14, 3, BlackKey.RIGHT));
  things.add(new BlackKey(15.5, 3, BlackKey.LEFT));
  // line 4
  things.add(new Button(0, 4, 24));
  things.add(new Button(1, 4, 25));
  things.add(new Button(2, 4, 26));
  things.add(new Key(3, 4));
  things.add(new Key(4, 4));
  things.add(new Key(5, 4));
  things.add(new Key(6, 4));
  things.add(new Key(7, 4));
  things.add(new Key(8, 4));
  things.add(new Key(9, 4));
  things.add(new Key(10, 4));
  things.add(new Key(11, 4));
  things.add(new Key(12, 4));
  things.add(new Key(13, 4));
  things.add(new Key(14, 4));
  things.add(new Key(15, 4));
  things.add(new Key(16, 4));
  // line 5
  things.add(new Button(0, 5, 27));
  things.add(new Button(1, 5, 28));
  things.add(new Button(2, 5, 29));
}

void draw() {
  if (wireframe) {
    background(0);
  } else {
    background(255);
  }
  rx += dx;
  ry += dy;
  rz += dz;
  //rotateX(rx);
  //rotateY(ry);
  //rotateZ(rz);
  translate(-1404, -470);  // centre - calculated in Body._draw
  lights();
  directionalLight(128, 128, 128, 0, 0, 1);  // reverse angle light for backside
  directionalLight(128, 128, 128, 1, 1, 0);  // light from north west
  directionalLight(128, 128, 128, -1, -1, 0);  // light from south east
  noStroke();
  for (Thing thing : things) {
    thing.draw();
  }
  if (record) {
    saveFrame("op1_####.jpg");
    if (frameCount > 1000) {
      exit();
    }
  }
}

// similar to dial / buttom
class VolumeButton extends Thing {

  VolumeButton(float x, float y) {
    super(tile2x1, x, y);
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

// simple textured round button
class Button extends Thing {

  // one of these for each button - because of decal
  short tindex;

  Button(float x, float y, int tindex) {
    super(tile1x1, x, y);
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

// tile and a decal
class Display extends Thing {

  Display(float x, float y) {
    super(tile4x2, x, y);
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

// tile and a decal
class Grill extends Thing {

  Grill(float x, float y) {
    super(tile2x2, x, y);
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

// no tile, only a decal
class Right extends Thing {

  Right(float x, float y) {
    super(null, x, y);
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

// pretty much same as button but higher
class Dial extends Thing {
  short tindex;

  Dial(float x, float y, int tindex) {
    super(tile2x2, x, y);
    w = W2;
    h = H2;
    this.tindex = (short)tindex;
  }

  @Override
  protected void _draw() {
    if (shape == null) {
      println("Creating Dial");
      shape = createShape(GROUP);
      // a decal on the tile and a cylinder
      if (!wireframe) {
        PShape decal = createShape();
        decal.beginShape(QUAD);
        decal.texture(dialTex);
        // decal is just a fraction above the tile
        decal.vertex(0, 0, z + d + DECAL, dialTextureX(tindex, -W2 / 2), dialTextureY(tindex, -H2 / 2));
        decal.vertex(0, h, z + d + DECAL, dialTextureX(tindex, -W2 / 2), dialTextureY(tindex, +H2 / 2));
        decal.vertex(w, h, z + d + DECAL, dialTextureX(tindex, +W2 / 2), dialTextureY(tindex, +H2 / 2));
        decal.vertex(w, 0, z + d + DECAL, dialTextureX(tindex, +W2 / 2), dialTextureY(tindex, -H2 / 2));
        decal.endShape();
        // add to main group
        shape.addChild(decal);
      }
      // cylinder
      PShape[] children = cylinder(w / 2.0, h / 2.0, BUTTON_RAD, DIAL_HEIGHT, tindex);
      // add to main shape
      shape.addChild(children[0]);
      shape.addChild(children[1]);
    }
    shape(shape);
  }
}

// complicated by size and allignment
class BlackKey extends Thing {
  public static final int MIDDLE = 0;
  public static final int RIGHT = 1;
  public static final int LEFT = 2;

  int allignment;

  BlackKey(float x, float y, int allignment) {
    super(null, x, y);
    if (allignment == RIGHT || allignment == LEFT) {
      // this key is 1.5 wide
      w = WH;
      this.baseTile = tile1_5x1;
    } else {
      this.baseTile = tile1x1;
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