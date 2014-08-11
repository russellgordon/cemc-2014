class EllipseTest {

  // Global variables
  int x = 0;
  int y = 0;
  
  // constructor
  //
  // Purpose: Run once, when the class is instantiated and an object created.
  //
  EllipseTest() {

    // Size of canvas
    size(800, 600); // Change size to 320 x 240, 640 x 480, or 800 x 600 if too slow at 1024 x 768

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
