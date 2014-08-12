class JH {

  //global variable - controls the angle 
  float angle = 0.0;
  float speed = 1;

  // constructor
  //
  // Purpose: Run once, when the class is instantiated and an object created.
  //
  JH() {
    mySetup();
  }

  // mySetup
  //
  // Purpose: Sets up initial state of sketch.  Called from constructor or when sketch is reset.
  // 
  void mySetup() {

    //sets speed of frames to 50
    frameRate(25);

    //sets background to white
    background(0, 0, 100);

    //change opacity and stroke weight
    strokeWeight(2);
    frameRate(speed);
    
    angle = 0;
    
    stroke(0);
    
    loop();
  }


  // drawFrame
  //
  // Purpose: Will be called from draw() function of wrapper program.
  void drawFrame() {

    //angle increases by 3 each frame
    angle += 6;

    //this will make shapes rotate only 357 degrees around the centre
    // so that it makes a full rotation with no overlap
    if (angle > 357) {
      noLoop();
    }


    //shifts origin left 600 and down 400 (centre of the page)
    translate(width/2, height/2);


    //makes shape rotate at origin by indicated angle (3) each frame
    rotate(radians(angle));

    //draws the shape at different locations and with different sizes
    //but all rotate around origin in same manner 
    drawCoolShape(0, 0, 0.25);
    drawCoolShape(50, 0, 0.125);
    drawCoolShape(100, 0, 0.175);
    drawCoolShape(150, 0, 0.125);
    drawCoolShape(200, 0, 0.275);
    drawCoolShape(250, 0, 0.30);
  }

  //Purpose: Draws four curves out of lines at each of the 
  //four corners to create square shape
  //
  //Parameters:
  //    x and y Control the location from which the shape is to be
  //    drawn, with the centre of the shape being the origin
  //    
  //    scaleValue Control the size of the shape, 1 being the
  //    original size
  void drawCoolShape(int x, int y, float scaleValue) {

    // saves old co-ordinate system
    pushMatrix();

    // translates shape by x and y given when calling function
    translate(x, y);

    //scales shape by given scaleValue when calling function
    scale(scaleValue);

    /*Subtract 150 b/c whole shape is 300x300 so to translate
     from origin, have to put origin in top let corner */

    //left top curve
    line(-150, 20-150, 30-150, 300-150);
    line(-150, 60-150, 70-150, 300-150);
    line(-150, 100-150, 110-150, 300-150);  
    line(-150, 140-150, 150-150, 300-150);
    line(-150, 180-150, 190-150, 300-150);
    line(-150, 220-150, 230-150, 300-150); 
    line(-150, 260-150, 270-150, 300-150);

    //right bottom curve
    line(300-150, 20-150, 270-150, 300-150);
    line(300-150, 60-150, 230-150, 300-150);
    line(300-150, 100-150, 190-150, 300-150);
    line(300-150, 140-150, 150-150, 300-150);
    line(300-150, 180-150, 110-150, 300-150);
    line(300-150, 220-150, 70-150, 300-150);
    line(300-150, 260-150, 30-150, 300-150);

    //right top curve
    line(300-150, 270-150, 270-150, 0-150);
    line(300-150, 230-150, 230-150, 0-150);
    line(300-150, 190-150, 190-150, 0-150);
    line(300-150, 150-150, 150-150, 0-150);
    line(300-150, 110-150, 110-150, 0-150);
    line(300-150, 70-150, 70-150, 0-150);
    line(300-150, 30-150, 30-150, 0-150);

    //left bottom curve
    line(30-150, 0-150, 0-150, 270-150);
    line(70-150, 0-150, 0-150, 230-150);
    line(110-150, 0-150, 0-150, 190-150);
    line(150-150, 0-150, 0-150, 150-150);
    line(190-150, 0-150, 0-150, 110-150);
    line(230-150, 0-150, 0-150, 70-150);
    line(270-150, 0-150, 0-150, 30-150);

    popMatrix();
  }

  // keyPress
  // 
  // Purpose: Handles key presses
  //
  void keyPress() {

    // Reset the sketch when the 'r' key is pressed
    if (key == 'r') {
      mySetup();
    } else if (key == 'f') {
      speed++;
      frameRate(speed);
    } else if (key == 's') {
      if (speed > 1) {
        speed--;
        frameRate(speed);
      }
    }
  }
}
