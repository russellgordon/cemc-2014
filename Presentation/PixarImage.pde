class PixarImage {

  PImage img = loadImage("pixar.jpg");
  
  // constructor
  //
  // Purpose: Run once, when the class is instantiated and an object created.
  //
  PixarImage() {

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
    background(0, 0, 100, 100);

    // Draw all geometry with smooth (anti-aliased) edges
    image(img, (width - img.width) / 2, (height - img.height) / 2);
  }

  // drawFrame
  //
  // Purpose: Will be called from draw() function of wrapper program.
  void drawFrame() {
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
