// m_ratser - ck raster generator //
// generator rastra //

import processing.svg.*;
import processing.awt.*;
import controlP5.*;
import java.awt.*;

PGraphicsSVG svg;
ControlP5 cp5;

Graphics2D  screen;
Graphics2D  paper;
BasicStroke pen;
PShape logo, logo_txt;
public PFont font, font2;

Slider a, b;


//gui setup
float bg_color = 255;
float ws_bg_color = 200;

// --------------------------------------------- [ przestrzen robocza ]
float ws_width;
float ws_height;

// --------------------------------------------- [ lina ]
float l_len = 31;
float l_int_val = 0.28;
float l_int_lin = 12;
float l_ofset = 0.12;
float l_weight = 1;

// --------------------------------------------- [ sin ]
float sin_amp = 20.85;
int sin_freq = 2;
float sin_bend = 0.5;


boolean record_svg = false;
boolean selectPathToExportSVG = false;
String exportPath = "";

// --------------------------------------------- [ offset / zoom ]
float zoom, zoomB;
PVector offset;
PVector poffset;
PVector moffset;
PVector soffset;
PVector mouse;

// --------------------------------------------- [ offset / zoom ]
boolean info_toggle = false;
boolean preset_toggle = false;

String preset_format = "none";

float count = 0;
int seg_nr = 0;
float cal = 0.282222;


// key code
boolean fA = false;
boolean fB = false;
boolean s0 = false;
boolean s1 = false;
boolean s2 = false;
boolean s3 = false;
boolean s4 = false;
boolean s5 = false;
boolean s6 = false;

void setup() {

  PImage icon = loadImage("ikonaGenerator.gif");
  surface.setIcon(icon);
  surface.setTitle("generator rastra ck");
  surface.setResizable(true);


  frameRate(60);

  logo = loadShape("logo.svg");
  logo_txt = loadShape("logo_txt.svg");
  font = createFont("PTS55F.ttf", 12, true);
  font2 = loadFont("PTSansPro-Bold-62.vlw");

  noStroke();
  cp5 = new ControlP5(this);
  ControlFont c_font = new ControlFont(font, 12);

  // cp5.setControlFont(p);
  // cp5.setColorLabel(0);
  cp5.setColorForeground(#000000);
  cp5.setColorBackground(#B4B4B4);
  cp5.setColorActive(#838383);

  // --------------------------------------------- [ przestrzen robocza ]

  float ws_menu_x = 50;
  float ws_menu_y = 100;
  float ws_menu_s = 20;
  int ws_menu_w = 350;
  int ws_menu_h = 15;

  cp5.addTextlabel("workspace")
    .setText("PRZESTRZEŃ ROBOCZA")
    .setPosition(ws_menu_x, ws_menu_y)
    .setFont(font)
    .setColorValue(#000000);

  a = cp5.addSlider("ws_width")
    .setCaptionLabel("szerokosc")
    .setColorCaptionLabel(0)
    .setPosition(ws_menu_x, ws_menu_y+ws_menu_s)
    .setSize(ws_menu_w, ws_menu_h)
    .setRange(100, 5120)
    ;

  b = cp5.addSlider("ws_height")
    .setCaptionLabel("wysokosc")
    .setColorCaptionLabel(0)
    .setPosition(ws_menu_x, ws_menu_y+(ws_menu_s*2))
    .setSize(ws_menu_w, ws_menu_h)
    .setRange(100, 5120)
    ;

  float linia_menu_x = 50;
  float linia_menu_y = 170;
  float linia_menu_s = 20;
  int linia_menu_w = 350;
  int linia_menu_h = 15;

  cp5.addTextlabel("linia")
    .setText("PARAMETRY LINII")
    .setPosition(linia_menu_x, linia_menu_y)
    .setFont(font)
    .setColorValue(#000000);

  Slider c = cp5.addSlider("l_len")
    .setCaptionLabel("dlugosc")
    .setColorCaptionLabel(0)
    .setPosition(linia_menu_x, linia_menu_y+linia_menu_s)
    .setSize(linia_menu_w, linia_menu_h)
    .setRange(7, 100)
    ;

  Slider d = cp5.addSlider("l_int_val")
    .setCaptionLabel("odstep")
    .setColorCaptionLabel(0)
    .setPosition(linia_menu_x, linia_menu_y+(linia_menu_s*2))
    .setSize(linia_menu_w, linia_menu_h)
    .setRange(0, 1)
    ;

  Slider e = cp5.addSlider("l_int_lin")
    .setCaptionLabel("interlinia")
    .setColorCaptionLabel(0)
    .setPosition(linia_menu_x, linia_menu_y+(linia_menu_s*3))
    .setSize(linia_menu_w, linia_menu_h)
    .setRange(5, 100)
    ;

  Slider f = cp5.addSlider("l_ofset")
    .setCaptionLabel("offset")
    .setColorCaptionLabel(0)
    .setPosition(linia_menu_x, linia_menu_y+(linia_menu_s*4))
    .setSize(linia_menu_w, linia_menu_h)
    .setRange(0, 1)
    ;

  Slider g = cp5.addSlider("l_weight")
    .setCaptionLabel("grubosc")
    .setColorCaptionLabel(0)
    .setPosition(linia_menu_x, linia_menu_y+(linia_menu_s*5))
    .setSize(linia_menu_w, linia_menu_h)
    .setRange(0.5, 7)
    ;

  float sin_menu_x = 50;
  float sin_menu_y = 300;
  float sin_menu_s = 20;
  int sin_menu_w = 350;
  int sin_menu_h = 15;

  cp5.addTextlabel("sin")
    .setText("WYGIĘCIE SINUSOIDALNE")
    .setPosition(sin_menu_x, sin_menu_y)
    .setFont(font)
    .setColorValue(#000000);

  Slider h = cp5.addSlider("sin_amp")
    .setCaptionLabel("amplituda")
    .setColorCaptionLabel(0)
    .setPosition(sin_menu_x, sin_menu_y+sin_menu_s)
    .setSize(sin_menu_w, sin_menu_h)
    .setRange(0, 100)
    ;

  Slider i = cp5.addSlider("sin_freq")
    .setCaptionLabel("czestotliwosc")
    .setColorCaptionLabel(0)
    .setPosition(sin_menu_x, sin_menu_y+(sin_menu_s*2))
    .setSize(sin_menu_w, sin_menu_h)
    .setRange(1, 20)
    ;

  Slider j = cp5.addSlider("sin_bend")
    .setCaptionLabel("zaokraglenie")
    .setColorCaptionLabel(0)
    .setPosition(sin_menu_x, sin_menu_y+(sin_menu_s*3))
    .setSize(sin_menu_w, sin_menu_h)
    .setRange(0, 1)
    ;

  cp5.addButton("export_svg")
    .setLabel("eksportuj svg")
    .setPosition( sin_menu_x, sin_menu_y+(sin_menu_s*5) )
    .setSize(350, 20)
    .setColorLabel(#ffffff);

  // create a toggle
  cp5.addToggle("toggle")
    .setLabel("INFO")
    .setPosition(sin_menu_x, sin_menu_y+(sin_menu_s*7))
    .setSize(50, 20);
  //  a.captionLabel().toUpperCase(false);
  //  b.captionLabel().toUpperCase(false);
  //  c.captionLabel().toUpperCase(false);
  //  d.captionLabel().toUpperCase(false);
  //  e.captionLabel().toUpperCase(false);
  //  f.captionLabel().toUpperCase(false);
  //  g.captionLabel().toUpperCase(false);
  //  h.captionLabel().toUpperCase(false);
  //  i.captionLabel().toUpperCase(false);
  //  j.captionLabel().toUpperCase(false);

  // work space default set
  ws_width = 600;
  ws_height = 200;


  // zoom end position offset
  zoom = 1.0;
  zoomB = zoom * width/(ws_width+200);
  offset = new PVector((width-ws_width*zoomB)/2, (height-ws_height*zoomB)/2);
  soffset = new PVector(((width-ws_width)*zoomB/2), ((width-ws_width)*zoomB/2));
  poffset = new PVector(0, 0);
  moffset = new PVector(0, 0);
}

void settings()
{
  smooth();
  size(((int) (displayWidth/1.25)), ((int) (displayHeight/1.25)));
}

void draw() {
  if (zoom < 0.1)
   {
      zoom = 0.1;
   }
  //noLoop();
  zoomB = zoom * width/(ws_width+200);
  soffset.x = (width-ws_width*zoomB)/2;
  soffset.y = (height-ws_height*zoomB)/2;
  offset.x = soffset.x + moffset.x;
  offset.y = soffset.y + moffset.y;
  a.setValue(ws_width);
  b.setValue(ws_height);
  background(bg_color);
  // presety formatów drukarskich
  float n_l_int_val = ( l_len * l_int_val );


  if ( fA == true && s0 == true) {
    ws_width = 841 / cal;
    ws_height = 1189 / cal;
    count = 0;
    preset_toggle = true;
    preset_format = "A0";
    println("A0 - format drukarski");
  }

  if ( fA == true && s1 == true) {
    ws_width = 594 / cal;
    ws_height = 841 / cal;
    count = 0;
    preset_toggle = true;
    preset_format = "A1";
    println("A1 - format drukarski");
  }

  if ( fA == true && s2 == true) {
    ws_width = 420 / cal;
    ws_height = 594 / cal;
    count = 0;
    preset_toggle = true;
    preset_format = "A2";
    println("A2 - format drukarski");
  }

  if ( fA == true && s3 == true) {
    ws_width = 297 / cal;
    ws_height = 420 / cal;
    count = 0;
    preset_toggle = true;
    preset_format = "A3";
    println("A3 - format drukarski");
  }

  if ( fA == true && s4 == true) {
    ws_width = 210 / cal;
    ws_height = 297 / cal;
    count = 0;
    preset_toggle = true;
    preset_format = "A4";
    println("A4 - format drukarski");
  }

  if ( fA == true && s5 == true) {
    ws_width = 148 / cal;
    ws_height = 210 / cal;
    count = 0;
    preset_toggle = true;
    preset_format = "A5";
    println("A5 - format drukarski");
  }

  if ( fA == true && s6 == true) {
    ws_width = 105 / cal;
    ws_height = 148 / cal;
    count = 0;
    preset_toggle = true;
    preset_format = "A6";
    println("A6 - format drukarski");
  }

  if ( fB == true && s0 == true) {
    ws_width = 1000 / cal;
    ws_height = 1414 / cal;
    count = 0;
    preset_toggle = true;
    preset_format = "B0";
    println("B0 - format drukarski");
  }

  if ( fB == true && s1 == true) {
    ws_width = 707 / cal;
    ws_height = 1000 / cal;
    count = 0;
    preset_toggle = true;
    preset_format = "B1";
    println("B1 - format drukarski");
  }

  if ( fB == true && s2 == true) {
    ws_width = 500 / cal;
    ws_height = 707 / cal;
    count = 0;
    preset_toggle = true;
    preset_format = "B2";
    println("B2 - format drukarski");
  }

  if ( fB == true && s3 == true) {
    ws_width = 353 / cal;
    ws_height = 500 / cal;
    count = 0;
    preset_toggle = true;
    preset_format = "B3";
    println("B3 - format drukarski");
  }

  if ( fB == true && s4 == true) {
    ws_width = 250 / cal;
    ws_height = 353 / cal;
    count = 0;
    preset_toggle = true;
    preset_format = "B4";
    println("B4 - format drukarski");
  }

  if ( fB == true && s5 == true) {
    ws_width = 176 / cal;
    ws_height = 250 / cal;
    count = 0;
    preset_toggle = true;
    preset_format = "B5";
    println("B5 - format drukarski");
  }

  if ( fB == true && s6 == true) {
    ws_width = 125 / cal;
    ws_height = 176 / cal;
    count = 0;
    preset_toggle = true;
    preset_format = "B6";
    println("B6 - format drukarski");
  }

  pushMatrix(); 
  scale(zoomB);
  translate(offset.x/zoomB, offset.y/zoomB);
  ws_info();
  ws_display();
  popMatrix();

  if (selectPathToExportSVG) {
    println("selectPathToExportSVG = " + selectPathToExportSVG);
    record_svg = true;
    zoom = 1.0;
    poffset.x = offset.x;
    poffset.y = offset.y;
    offset.x = 0.0 - (0);
    offset.y = 0.0 - (0);
    record_svg = true;
  }

  if (record_svg) {
    svg = (PGraphicsSVG) createGraphics(int(ws_width), int(ws_height), SVG, exportPath + ".svg");
    beginRecord(svg);
    screen = ((PGraphicsJava2D) g).g2;
    paper = svg.g2;
    paper.setStroke(pen);
  }
  pushMatrix();
  scale(zoomB);
  translate(offset.x/zoomB, offset.y/zoomB);

  float[] _dash = {
    l_len, n_l_int_val
  };

  pen = new BasicStroke(l_weight, BasicStroke.CAP_BUTT, BasicStroke.JOIN_MITER, 4.0f, _dash, 0);
  Graphics2D g2 = ((PGraphicsJava2D) g).g2;
  g2.setStroke(pen);

  for (int i = 0; i < ( ws_height / l_int_lin ); i++) {
    qcur(points( i * l_int_lin, false));
    qcur(points( i * l_int_lin + ( l_int_lin/2 ), true));
  }
  popMatrix();

  if (record_svg) {
    endRecord();
    record_svg = false;
    selectPathToExportSVG = false;
    offset.x = poffset.x;
    offset.y = poffset.y;
  }


  noStroke();
  fill(255, 255, 255, 200);
  rect(0, 50, 500, 450);
  rect(50, 50, 350, 30);
  // shape(logo, 50, 50, 350, 30);

  if (info_toggle) {
    info();
  }
  shape(logo, 50, 50);
  shape(logo_txt, 50, 50);

  if (preset_toggle) {
    counter();
    preset_info(preset_format, counter());
  }
  info_b();
  text(" – POMOC", 155, 455);
  // info();
}

void ws_display() {
  stroke(75);
  strokeWeight(0.1);
  fill(255);
  rect(0, 0, ws_width, ws_height);
}

void keyPressed() {

  if ( key == 'r') {
    zoom = 1;
    moffset.x = 0;
    moffset.y = 0;
  }
  if (key == '=') {
    zoom += 0.1;
  } else if (key == '-') {
    zoom -= 0.1;
  }

  if (Character.toLowerCase(key) == 'a') fA = true;
  if (Character.toLowerCase(key) == 'b') fB = true;
  if (key == '0') s0 = true;
  if (key == '1') s1 = true;
  if (key == '2') s2 = true;
  if (key == '3') s3 = true;
  if (key == '4') s4 = true;
  if (key == '5') s5 = true;
  if (key == '6') s6 = true;
}

void keyReleased() {

  if (Character.toLowerCase(key) == 'a') fA = false;
  if (Character.toLowerCase(key) == 'b') fB = false;
  if (key == '0') s0 = false;
  if (key == '1') s1 = false;
  if (key == '2') s2 = false;
  if (key == '3') s3 = false;
  if (key == '4') s4 = false;
  if (key == '5') s5 = false;
  if (key == '6') s6 = false;
}

// Store the mouse and the previous offset
void mousePressed() {
  if (mouseButton == RIGHT) {
    mouse = new PVector(mouseX, mouseY);
    poffset.set(moffset);
  }
}

// Calculate the new offset based on change in mouse vs. previous offsey
void mouseDragged() {
  if (mouseButton == RIGHT) {
    moffset.x = mouseX - mouse.x + poffset.x;
    moffset.y = mouseY - mouse.y + poffset.y;
    offset.x = soffset.x + moffset.x;
    offset.y = soffset.y + moffset.y;
  }
}

void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  if ( e == -1.0) {
    zoom += 0.1;
  }
  if (e == 1.0) {
    zoom -= 0.1;
  }
}

void export_svg() {
  selectOutput("Wybierz lokalizację", "exportFileSVG");
  // println();
}

void exportFileSVG(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    exportPath = selection.getAbsolutePath();
    selectPathToExportSVG = true;
    println("plik zapisany : " + exportPath + ".svg");
  }
}

void toggle(boolean theFlag) {
  if (theFlag) {
    info_toggle = true;
  } else {
    info_toggle = false;
  }
  // println(info_toggle);
}

float counter() {
  if (count <= 200) {
    count++;
  }
  if (count == 200) {
    count = 200;
    preset_toggle = false;
  }
  return count;
}





// ------------------------------------------------------------ temp
void line_grid() {
  float x = 0;
  float y = 0;
  float step = 50;

  fill(0);
  strokeWeight(0.1);
  stroke(0);
  // kreski pionowe
  for (int i = 0; i < width/step; i++) {
    x = i * step;
    line(x, 0, x, height);
    text(int(x), x, 10);
  }
  // kreski poziome

  for (int i = 0; i < height/step; i++) {
    y = i * step;
    line(0, y, width, y);
    text(int(y), 10, y);
  }

  // kursor myszy z koordynatami
  stroke(255);
  text(mouseX + ": x cor", mouseX + 20, mouseY);
  text(mouseY + ": y cor", mouseX + 20, mouseY + 15);
}

void line_grid(float w_x, float w_y, int sep) {
  noFill();
  strokeWeight(0.1);
  stroke(0);
  float x = 0;
  float y = 0;
  fill(0);
  for (int i = 1; i < (w_x/sep); i++ ) {
    x = i * sep;
    line(x, 0, x, w_y);
    text(int(x), x, 10);
  }

  for (int i = 1; i < (w_y/sep); i++ ) {
    y = i * sep;
    line(0, y, w_x, y);
    text(int(y), 10, y);
  }
}

void temp_info() {
  noStroke();
  pushMatrix();
  translate(width-200, ((height-300)/2));
  fill(0);
  rect(0, 0, 200, 300);
  fill(255);

  text("fps: ", 10, 20);
  text(frameRate, 70, 20);

  text("zoom: ", 10, 40);
  text(zoom, 70, 40);

  text("offset.x: ", 10, 60);
  text(offset.x, 70, 60);

  text("offset.y: ", 10, 80);
  text(offset.y, 70, 80);

  text("poffset.x: ", 10, 100);
  text(poffset.x, 70, 100);

  text("poffset.y", 10, 120);
  text(poffset.y, 70, 120);

  popMatrix();
}
