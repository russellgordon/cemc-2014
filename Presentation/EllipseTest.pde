class ExampleClass {

  // Global variables
  int x = 0;
  int y = 0;
  
  // constructor
  //
  // Purpose: Run once, when the class is instantiated and an object created.
  //
  ExampleClass() {

    // Use HSB colour model.
    colorMode(HSB, 360, 100, 100);

    // Set background
    background(0, 0, 100);

    // Draw all geometry with smooth (anti-aliased) edges
    smooth();
  }

  // drawFrame
  //
  // Purpose: Will be called from draw() function of wrapper program.
  void drawFrame() {
    
    // Change position
    x++;
    y++;
    
    // Clear screen
    background(0, 0, 100);
    
    // Draw the ellipse
    ellipse(x, y, 50, 50);
  }
  
}
