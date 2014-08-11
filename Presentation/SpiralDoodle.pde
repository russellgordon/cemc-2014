class SpiralDoodle {

  // Radius of circle
  float radius;

  // Angle for circle
  float angle;

  // Co-ordinates for prior point
  float[] priorX = new float[10];
  float[] priorY = new float[10];

  // Used to introduce some entropy into the spirals that will be drawn
  float[] perlinPosition = new float[10];
  float xIncrement = 0.17;

  // constructor
  //
  // Purpose: Run once, when the class is instantiated and an object created.
  //
  SpiralDoodle() {

    mySetup();
  }

  // mySetup
  //
  // Purpose: Sets up initial state of sketch.  Called from constructor or when sketch is reset.
  // 
  void mySetup() {
    
    // Use Hue-Saturation-Brightness colour model
    // See: https://twitter.com/rgordon/status/406373396939673602/photo/1
    colorMode(HSB, 360, 100, 100, 100);

    // No border
    noStroke();

    // White background
    background(0, 0, 100);

    // Set Perlin noise start points and initialize prior X and Y values
    for (int i = 0; i < 10; i++) {
      perlinPosition[i] = random(5, 10) * i;
      priorX[i] = 0.0;
      priorY[i] = 0.0;
    }
    
    // Set initial angle and radius
    angle = 0;
    radius = 0;
  }

  // drawFrame
  //
  // Purpose: Will be called from draw() function of wrapper program.
  void drawFrame() {

    // Translate origin to middle of screen
    translate(width/2, height/2);

    // Flip y-axis so it behaves like a regular Cartesian plane
    scale(1, -1);

    // Increase the radius by 1
    radius+=0.01;

    // Increase the angle 
    angle += 1;

    // Draw a series of 10 spirals, made less perfect / with more entropy by use of Perlin noise
    for (float i = 1; i < 2; i+=0.1) {

      // Convert loop variable to an integer we can use to access the elements of the arrays
      int index = (int) ((i-1)*10);

      // Move to new position in Perlin noise space
      perlinPosition[index] += xIncrement; 

      // Find co-ordinates for endpoint of next line to be drawn for this spiral
      float x = (radius + map(noise(perlinPosition[index]), 0, 1, 0, 5))*(i*8)*cos(radians(angle));
      float y = (radius + map(noise(perlinPosition[index]), 0, 1, 0, 5))*(i*8)*sin(radians(angle));

      // Change brightness of fill and stroke (10th or outermost spiral is lighter)
      stroke(240, 40, i*50);
      strokeWeight(1);

      // Draw a line from priorX to new X
      line(priorX[index], priorY[index], x, y);

      // Update prior x and y values
      priorX[index] = x;
      priorY[index] = y;
    }
  }

  // keyPress
  // 
  // Purpose: Handles key presses
  //
  void keyPress() {

    // Reset the sketch when the 'r' key is pressed
    if (key == 'r') {
      mySetup();
    }
  }
}
