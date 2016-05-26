// a spinning op-1
// acd 2016
// TODO
// knobs
// make 1x1 tile a common pshape

import java.util.List;
import peasy.*;

public static final float W = 150;  // width of a button
public static final float H = 150;  // height of a button
public static final float S = 8;    // separation = 8
public static final float STUB = 10; // height of a tile, height of a button
public static final float DECAL = .02; // height of decal
public static final float W2 = W + S + W; // double width key
public static final float WH = ((W + S + W + S + W) - S) / 2; // W and a half - for black keys
public static final float H2 = H + S + H; // double height key

public static final float BUTTON_RAD = 50; // buttons are 25 + 100 + 25 => RAD = 50

public static final float TW = 158; // texture width multiplier
public static final float TH = 158; // texture height multiplier
public static final float TS = 8; // texture separator

public static final String BACKGROUND = "ffc3c9c9";
public static final String KEY_COLOUR = "ffdee9e9";

PShape keyShape;

List<Thing> things = new ArrayList<Thing>();
PeasyCam cam;
PImage tex;
PImage buttonTex;
PImage panelTex;
PImage grillTex;
PImage dialTex;

void setup() {
  size(800, 600, P3D);
  cam = new PeasyCam(this, 500);
  // texture
  tex = loadImage("op1.png");
  buttonTex = loadImage("op1_buttons.png");
  panelTex = loadImage("op1_panel.png");
  grillTex = loadImage("op1_grill.png");
  dialTex = loadImage("op1_dials.png");
  // line 0
  things.add(new Grill(0, 0));
  things.add(new VolumeButton(2, 0));
  things.add(new Display(4, 0));
  things.add(new Dial(8, 0, 0));
  things.add(new Dial(10, 0, 1));
  things.add(new Dial(12, 0, 2));
  things.add(new Dial(14, 0, 3));
  things.add(new Button(16, 0, 0));
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
  background(192);
  //directionalLight(192, 192, 192, 0, 0, -1);
  //directionalLight(128, 0, 0, 0, 0, 1);
  //ambientLight(102, 102, 102);
  lights();
  noStroke();
  for (Thing thing : things) {
    thing.draw();
  }
}

class VolumeButton extends Thing {
  VolumeButton(float x, float y) {
    super(x, y);
    w = W2;
  }
}

public static int SEGMENTS = 24;
class Button extends Thing {
  // one of these for each button - because of decal
  PShape shape = null;
  short tindex;

  Button(float x, float y, int tindex) {
    super(x, y);
    this.tindex = (short)tindex;
  }

  @Override
  protected void _draw() {
    if (shape == null) {
      println("Creating ButtonShape");
      shape = createShape(GROUP);
      PShape[] children = cylinder(w / 2.0, h / 2.0, BUTTON_RAD, STUB, tindex);
      shape.addChild(children[0]);
      shape.addChild(children[1]);
      PShape tile = myBox();
      shape.addChild(tile);
    }
    shape(shape);
  }
}

class Display extends Thing {
  PShape shape;
  Display(float x, float y) {
    super(x, y);
    w = W + S + W + S + W + S + W;
    h = H2;
  }

  @Override
  protected void _draw() {
    super._draw();
    if (shape == null) {
      shape = createShape();
      shape.beginShape(QUAD);
      shape.texture(panelTex);
      shape.vertex(0, 0, z + d + DECAL, 0, 0);
      shape.vertex(0, h, z + d + DECAL, 0, panelTex.height);
      shape.vertex(w, h, z + d + DECAL, panelTex.width, panelTex.height);
      shape.vertex(w, 0, z + d + DECAL, panelTex.width, 0);
      shape.endShape();
    }
    shape(shape);
  }
}

class Grill extends Thing {
  PShape shape;
  Grill(float x, float y) {
    super(x, y);
    w = W2;
    h = H2;
  }

  @Override
  protected void _draw() {
    super._draw();
    if (shape == null) {
      shape = createShape();
      shape.beginShape(QUAD);
      shape.texture(grillTex);
      shape.vertex(0, 0, z + d + DECAL, 0, 0);
      shape.vertex(0, h, z + d + DECAL, 0, grillTex.height);
      shape.vertex(w, h, z + d + DECAL, grillTex.width, grillTex.height);
      shape.vertex(w, 0, z + d + DECAL, grillTex.width, 0);
      shape.endShape();
    }
    shape(shape);
  }
}

class Dial extends Thing {
  static final float DIAL_HEIGHT = STUB * 10;
  // one of these for each button - because of decal
  PShape shape = null;
  short tindex;

  Dial(float x, float y, int tindex) {
    super(x, y);
    w = W2;
    h = H2;
    this.tindex = (short)tindex;
  }

  @Override
  protected void _draw() {
    if (shape == null) {
      println("Creating Dial");
      shape = createShape(GROUP);
      PShape[] children = cylinder(w / 2.0, h / 2.0, BUTTON_RAD, DIAL_HEIGHT, tindex);
      shape.addChild(children[0]);
      shape.addChild(children[1]);
      PShape tile = myBox();
      shape.addChild(tile);
    }
    shape(shape);
  }
}

class Key extends Thing {

  Key(float x, float y) {
    super(x, y);
    h = H2;
  }

  // elongated version of button
  @Override
  protected void _draw() {
    fill(unhex(KEY_COLOUR));
    if (keyShape == null) {
      println("Creating KeyShape");
      float left = w / 2 - BUTTON_RAD;
      float right = w / 2 + BUTTON_RAD;
      float top = 25 + BUTTON_RAD;
      float bottom = h - 25 - BUTTON_RAD;
      PShape child = createShape();
      // repeated coords so that normals are correct
      child.beginShape(QUADS);
      // left
      child.vertex(left, top, z + d);
      child.vertex(left, bottom, z + d);
      child.vertex(left, bottom, z + d + STUB);
      child.vertex(left, top, z + d + STUB);
      // top
      child.vertex(left, top, z + d + STUB);
      child.vertex(left, bottom, z + d + STUB);
      child.vertex(right, bottom, z + d + STUB);
      child.vertex(right, top, z + d + STUB);
      // right
      child.vertex(right, top, z + d + STUB);
      child.vertex(right, bottom, z + d + STUB);
      child.vertex(right, bottom, z + d);
      child.vertex(right, top, z + d);
      child.endShape();
      // create actual shape
      keyShape = createShape(GROUP);
      PShape[] shapes = buttonShape(w / 2, top, BUTTON_RAD, TOP);
      keyShape.addChild(shapes[0]);
      keyShape.addChild(shapes[1]);
      keyShape.addChild(child);
      shapes = buttonShape(w / 2, bottom, BUTTON_RAD, BOTTOM);
      keyShape.addChild(shapes[0]);
      keyShape.addChild(shapes[1]);
      // underlying tile
      PShape tile = myBox();
      keyShape.addChild(tile);
    }
    shape(keyShape);
  }
}

class BlackKey extends Thing {
  public static final int MIDDLE = 0;
  public static final int RIGHT = 1;
  public static final int LEFT = 2;

  PShape shape = null;
  int allignment;

  BlackKey(float x, float y, int allignment) {
    super(x, y);
    if (allignment == RIGHT || allignment == LEFT) {
      w = WH;
    }
    this.allignment = allignment;
  }

// TODO position of button within tile
  @Override
  protected void _draw() {
    super._draw();
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