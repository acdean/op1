// a spinning op-1
// acd 2016
// TODO
// there appears to be a bug in 3.1.1 which draws a line from the end of evey quad in a QUAD STRIP
// works fine on 3.0.b7
// better knobs (textured, curved bottoms)
// texture some of the other sides. feet?

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
public static final float DIAL_HEIGHT = 150;  // height of a dial (thanks antony)
public static final float DECAL = .02; // height of decal
public static final float W2 = W + S + W; // double width key
public static final float WH = ((W + S + W + S + W) - S) / 2; // W and a half - for black keys
public static final float H2 = H + S + H; // double height key

public static final int SEGMENTS = 20; //24;
public static final float BUTTON_RAD = 50; // buttons are 25 + 100 + 25 => RAD = 50
public static final float DIAL_RAD = 90; // radius of bottom of dial (top is BUTTOM_RAD)
public static final float DIAL_CURVE = (DIAL_RAD - BUTTON_RAD); // radius of curve at bottom of dial

public static final float TW = 158; // texture width multiplier
public static final float TH = 158; // texture height multiplier
public static final float TS = 8; // texture separator

public static final String BACKGROUND = "ffc3c9c9";
public static final String KEY_COLOUR = "ffdee9e9";
public static final String WIRE_COLOUR = "ff00ff00";  // green

PeasyCam cam;
PImage tex;
PImage buttonTex;
PImage panelTex;
PImage grillTex;
PImage dialTex;
PImage rightTex;
float rx, ry, rz, dx, dy, dz;

boolean record = false;
Model model1, model2;

void setup() {
  size(1280, 750, P3D);
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
  
  //model1 = new Model(true);  // wireframe
  model2 = new Model(false);
}

void draw() {
  background(128);
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

  // draw the actual model
  //model1.draw();
  //rotateX(rx);
  //rotateY(ry);
  model2.draw();

  if (record) {
    saveFrame("op1_####.jpg");
    if (frameCount > 1000) {
      exit();
    }
  }
}