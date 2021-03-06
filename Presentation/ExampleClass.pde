class ExampleClass {

  // Global variables
  int x = 0;
  int y = 0;

  // constructor
  //
  // Purpose: Run once, when the class is instantiated and an object created.
  //
  ExampleClass() {

    mySetup();
    
  }

  // mySetup
  //
  // Purpose: Sets up initial state of sketch.  Called from constructor or when sketch is reset.
  // 
  void mySetup() {
    
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
