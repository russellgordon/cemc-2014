class SinusoidalFunctions {

  // global variables and objects
  PFont serifItalic;
  PFont serif;
  PFont greek;
  PFont sansSerif;
  float initialAngle = 0;
  float angle = initialAngle;
  float quadrantHeight = 0;
  boolean[] anglesRequested = new boolean[541];
  boolean showSine = true;
  color red, green, blue, black, white;

  // constructor
  //
  // Purpose: Run once, when the class is instantiated and an object created.
  //
  SinusoidalFunctions() {
    
    mySetup();
    
  }

  // mySetup
  //
  // Purpose: Sets up initial state of sketch.  Called from constructor or when sketch is reset.
  // 
  void mySetup() {

    // Use Hue-Saturation-Brightness colour model
    colorMode(HSB, 360, 100, 100, 100);

    // Set fonts
    serif = loadFont("Times-Roman-24.vlw");
    serifItalic = loadFont("Times-Italic-24.vlw");
    greek = loadFont("TimesNewRomanPS-ItalicMT-24.vlw");
    sansSerif = loadFont("Calibri-24.vlw");

    // Set frequently used colors
    red = color(0, 80, 90);
    green = color(122, 77, 67);
    blue = color(240, 80, 90);
    black = color(0, 0, 0);
    white = color(0, 0, 100);

    // background colour
    background(white);

    // Height that various interface elements will be constructed against
    // May need to change this if the canvas size is changed
    quadrantHeight = width/5;

    // Draw initial images
    clearCanvas();
    drawHelpText();
    drawUnitCircle(showSine);
    drawSinusoidal(showSine);
  }

  // drawFrame
  //
  // Purpose: Will be called from draw() function of wrapper program.
  void drawFrame() {

  }

  // This function responds to key presses
  void keyPress()
  {
    // Change angle based on keypresses
    if (key == 'l') {
      angle++;
    }
    if (key == 'r') {
      angle--;
    }

    // No negative angles
    if (angle < 0) {
      angle = 0;
    }

    // Flip between sine and cosine view
    if (key == 's') {
      showSine = true;
      // reset unit circle and sinusoidal graph
      angle = initialAngle;
      for (int i = 0; i < anglesRequested.length; i++) {
        anglesRequested[i] = false;
      }
    } else if (key == 'c') {
      showSine = false;
      // reset unit circle and sinusoidal graph
      angle = initialAngle;
      for (int i = 0; i < anglesRequested.length; i++) {
        anglesRequested[i] = false;
      }
    } else {
      // For this value of theta on the unit circle, draw that ratio vs theta on sinusoidal axis 
      if (angle < anglesRequested.length) {
        anglesRequested[int(angle)] = true;
      }
    }

    // Re-draw circle and sinusoidal
    clearCanvas();
    drawHelpText();
    drawUnitCircle(showSine);
    drawSinusoidal(showSine);
    //println(angle); // DEBUG
  }

  // drawUnitCircle
  //
  // Purpose: Draws all elements of the unit circle, using the most recent angle measure.
  //
  // Parameters:       sine          If true, sine ratio will be illustrated.  Otherwise, cosine ratio will be illustrated.
  void drawUnitCircle(boolean sine) {

    // Save regular translation settings
    pushMatrix(); 

    // Make origin for unit circle be at left side of screen
    translate(quadrantHeight, height/2 + height/20);

    // Draw axes for unit circle
    stroke(black);
    strokeWeight(2);
    line(-1*quadrantHeight, 0, quadrantHeight, 0); // x-axis
    line(0, -1*quadrantHeight, 0, quadrantHeight); // y-axis

    // Labels for unit circle
    textFont(serifItalic);
    fill(black);
    text("x", quadrantHeight - quadrantHeight / 16, -1 * quadrantHeight / 16);
    text("y", quadrantHeight / 16, -1 * quadrantHeight + quadrantHeight / 16);

    // Unit circle itself
    noFill();
    float diameter = quadrantHeight*2 - quadrantHeight / 3 * 2;
    float radius = diameter / 2;
    ellipse(0, 0, diameter, diameter);

    // Mark unit points
    fill(black);
    textFont(serif);
    text("(1, 0)", diameter/2 + quadrantHeight / 24, quadrantHeight/8);
    ellipse(diameter/2, 0, quadrantHeight / 36, quadrantHeight / 36);
    text("(-1, 0)", (diameter/2 + (quadrantHeight / 7) * 2) * -1, quadrantHeight/8);
    ellipse(diameter/2 * -1, 0, quadrantHeight / 36, quadrantHeight / 36);
    text("(0, 1)", quadrantHeight/24, (diameter/2 + quadrantHeight / 24) * -1);
    ellipse(0, diameter/2, quadrantHeight / 36, quadrantHeight / 36);
    text("(0, -1)", quadrantHeight/24, diameter/2 + quadrantHeight / 10);
    ellipse(0, diameter/2 * -1, quadrantHeight / 36, quadrantHeight / 36);

    // Draw reference triangle
    strokeWeight(4);
    fill(300); // light grey
    float x = cos(radians(angle)) * radius;
    float y = sin(radians(angle)) * radius;
    noStroke();
    triangle(0, 0, x, 0, x, -1*y);
    stroke(black);
    // side r (radius of unit circle)
    line(0, 0, x, -1*y);
    // side x (base of reference triangle)
    if (!sine) { 
      stroke(green);
    } else {
      stroke(black);
    }
    line(0, 0, x, 0);
    // side y (height of reference triangle)
    if (sine) {
      stroke(blue);
    } else {
      stroke(black);
    }
    line(x, 0, x, -1*y);

    // Draw point P on unit circle
    stroke(black);
    fill(black);
    ellipse(x, -1*y, quadrantHeight / 36, quadrantHeight / 36);
    textFont(serifItalic);
    float xLabel = cos(radians(angle)) * (radius + radius / 6);
    float yLabel = sin(radians(angle)) * (radius + radius / 6);
    text("P", xLabel, yLabel*-1);

    // Draw theta
    noFill();
    strokeWeight(2);
    stroke(red);
    pushMatrix();
    scale(1, -1);
    arc(0, 0, radius/4, radius/4, radians(0), radians(angle));
    popMatrix();

    // Restore original translation settings
    popMatrix();
  }

  // drawSinusoidal
  //
  // Purpose: Draws the matching curve based on what's happening in the unit circle
  //
  // Parameters:       sine          If true, sine curve will be illustrated.  Otherwise, cosine curve will be shown.
  void drawSinusoidal(boolean sine) {

    // Origin for unit circle at left side of screen
    translate(quadrantHeight*270/100, height/2 + height/20);

    // Draw axes for sinusoidal
    stroke(black);
    strokeWeight(2);
    stroke(red);
    line(-1*quadrantHeight/3, 0, quadrantHeight*3, 0); // x-axis
    if (sine) {
      stroke(blue);
    } else {
      stroke(green);
    }
    line(0, -1*quadrantHeight, 0, quadrantHeight); // y-axis

    // Labels for sinusoidal axes
    fill(black);
    textFont(greek);
    String s="\u03B8";        
    text(s, quadrantHeight*2 + quadrantHeight / 8, -1 * quadrantHeight / 16);
    textFont(serifItalic);
    if (sine) {
      text("sine", quadrantHeight / 16, -1 * quadrantHeight + quadrantHeight / 16);
    } else {
      text("cosine", quadrantHeight / 16, -1 * quadrantHeight + quadrantHeight / 16);
    }

    // Scale for vertical axis
    float diameter = quadrantHeight*2 - quadrantHeight / 3 * 2;
    // Positive one
    strokeWeight(2);
    stroke(black);
    line(-1 * quadrantHeight / 36, -1*diameter/2, quadrantHeight / 36, -1*diameter/2);
    fill(black);
    textFont(serif);
    text("1", -1 * quadrantHeight/12, (diameter/2 - quadrantHeight/36) * -1);
    // Negative one
    line(-1 * quadrantHeight / 36, diameter/2, quadrantHeight / 36, diameter/2);
    textFont(serif);
    text("-1", -1 * quadrantHeight/8, (diameter/2 + quadrantHeight/28));

    // Scale for horizontal axis
    line(quadrantHeight/2, -1 * quadrantHeight / 36, quadrantHeight/2, 1 * quadrantHeight / 36);
    textFont(serifItalic); 
    text("90", quadrantHeight/2 - quadrantHeight / 20, quadrantHeight / 8);
    s="\u00B0";
    textFont(greek); 
    text(s, quadrantHeight/2 + quadrantHeight / 20, quadrantHeight / 8);
    line(quadrantHeight, -1 * quadrantHeight / 36, quadrantHeight, 1 * quadrantHeight / 36); 
    textFont(serifItalic); 
    text("180", quadrantHeight - quadrantHeight / 14, quadrantHeight / 8);
    textFont(greek); 
    text(s, quadrantHeight + quadrantHeight / 13, quadrantHeight / 8);
    line(quadrantHeight/2*3, -1 * quadrantHeight / 36, quadrantHeight/2*3, 1 * quadrantHeight / 36); 
    textFont(serifItalic); 
    text("270", quadrantHeight/2*3 - quadrantHeight / 14, quadrantHeight / 8);
    textFont(greek); 
    text(s, quadrantHeight/2*3 + quadrantHeight / 13, quadrantHeight / 8);
    line(quadrantHeight*2, -1 * quadrantHeight / 36, quadrantHeight*2, 1 * quadrantHeight / 36); 
    textFont(serifItalic); 
    text("360", quadrantHeight*2 - quadrantHeight / 14, quadrantHeight / 8);
    textFont(greek); 
    text(s, quadrantHeight*2 + quadrantHeight / 13, quadrantHeight / 8);

    // Plot ratio vs. theta for any angle values that have been requested
    float y2 = 0;
    float x1 = 0;
    float radius = diameter / 2;
    strokeWeight(1);
    if (sine) {
      stroke(blue);
    } else {
      stroke(green);
    }
    for (int i = 0; i < anglesRequested.length; i++) {
      if (anglesRequested[i] == true) {
        if (sine) {
          y2 = sin(radians(i)) * radius;
        } else {
          y2 = cos(radians(i)) * radius;
        }
        x1 = map(i, 0, anglesRequested.length - 1, 0, quadrantHeight*3);
        line(x1, 0, x1, y2*-1);
      }
    }
  }

  // drawHelpText
  //
  // Purpose: Draws the instructions on screen.
  //
  // Parameters:     (none)
  void drawHelpText() {

    // Draw top of screen help text

      // Grey background
    fill(57, 13, 99); // pale yellow
    rect(0, 0, width, height/12);

    // Separating line
    stroke(200);
    strokeWeight(2);
    line(0, height/12, width, height/12);

    // Help text
    textFont(sansSerif);
    fill(200);
    text("Press 'l' and 'r' keys to move point P.   How does what you see on the left connect to what you see on the right?", width/85, height/18);
  }

  // clearCanvas
  //
  // Purpose: Clears everything from the screen.
  // 
  // Parameters: (none)
  void clearCanvas() {

    // White rectangle over entire canvas
    noStroke();
    fill(white);
    rect(0, 0, width, height);
  }
}
