class BA {

  //use floating numbers (numbers with a decimal point) for the
  //variable 'angle'
  float angle;

  // constructor
  //
  // Purpose: Run once, when the class is instantiated and an object created.
  //
  BA() {
    mySetup();
  }

  // mySetup
  //
  // Purpose: Sets up initial state of sketch.  Called from constructor or when sketch is reset.
  // 
  void mySetup() {
    //colour mode
    //       mode colour Hue Sat Alpha(Transparency)
    colorMode(HSB, 360, 100, 100, 100);

    // background - sky blue
    background(210, 80, 100); 

    //set origin to be in the center 
    translate(width/2, height/2);
    
    angle = 0;
  }

  // drawFrame
  //
  // Purpose: Will be called from draw() function of wrapper program.
  void drawFrame() {
    //This function runs more than once. 

    //set origin at the middle of the canvas
    translate(width/2, height/2);

    //rotate the angle the box/cube displayed at
    rotate(random(angle));

    //if mouse is pressed, decrease light on parts of the sketch
    if (mousePressed) {

      //decreases light on parts of the sketch
      ambientLight(270, 60, 100);
    }

    //draw the eiffel tower, the water under it and the trees on  
    // the side of the canvas.
    eiffel();

    //set the postition of the boxes at random.
    translate(random(0, width), random(0, height), 
    random(width, height));

    //set the thickness of the line to be 1
    strokeWeight(1);

    //colour = between 0 and 180 degree, hue = 80, sat = 90
    fill(random(0, 180), 80, 90);

    //rotate the box to a certain angle at random
    rotate(random(angle));

    //set the size of the box to be 20
    box(20);

    //set the positon of the box at random in the negative axes.
    translate(-random(0, width), -random(0, height), 
    -random(width, height));

    //set the thickness of the line to be 1
    strokeWeight(1);

    //colour = between 0 and 180 degree, hue= 80, sat = 90
    fill(random(0, 360), 80, 90);

    //rotate the box to a certain angle at random
    rotate(random(angle));

    //set the size of the box to be 20
    box(20);
  }

  //drawWater
  //Purpose: To draw the water at the bottom of the tower
  void drawWater() {

    noStroke(); //no outline 
    fill(210, 100, 80, 40); //blue

    //bottom part of water
    rect(-242.5, 305, 485, 30); 

    //top part of water
    beginShape(); //initiate drawing shape
    fill(210, 100, 80, 40); // blue

    // right lower corner
    vertex(30, 270); 

    // left lower corner
    vertex(-30, 270);

    // left lower corner
    vertex(-242.5, 305);

    //right lower corner
    vertex(242.5, 305); 

    endShape(); //terminate drawing shape
  }

  //drawTrees
  //Purpose: To draw the trees on the sides of the canvas.
  void drawTrees() {

    noStroke(); //no outline

      fill(120, 100, 40); //green

    //left part
    triangle(-30, 270, -242.5, 305, -242.5, 195);

    //right part
    triangle(30, 270, 242.5, 305, 242.5, 195);
  }

  //bottomArc
  //Purpose: To draw the semi-circle making up the bottom part of 
  //         the tower
  void bottomArc() {

    noFill(); //no colour in the space created by the arc

    stroke(51, 100, 100);  //golden yellow

    //thickness of curve(arc)
    strokeWeight(20); 

    //semi-cirlce
    arc(0, 263, 133, 147, -PI, 0);
  }

  //drawSide
  //Purpose: To draw the left side of the tower
  void drawSide() {

    noFill(); // no colour in the space created by the arc

    stroke(51, 100, 100);  //golden yellow

    //thickness of curve(arc)
    strokeWeight(20);

    //left side only
    arc(-125, -150, 250, 800, 0, PI / 2.0); 

    //line on top of the arcs making up the sides to make it longer
    line(0, -150, 0, -210);
  }

  //bar 1
  //Purpose: To draw the upper horizontal bar on the tower
  void bar1() {

    //stores information about the co-ordinate system.
    pushMatrix();

    //moves it -10 units closer to the viewer (in the z-axis)
    translate(0, 0, -10);

    stroke(30, 80, 100);  //orange

    //thickness of the horizontal lines and the lines connecting them
    strokeWeight(5);

    line(-37, 70, 37, 70);  //top line

    line(-32, 95, 32, 95);  //bottom line

    //line on the left connecting the top and bottom lines
    line(-37, 70, -32, 95);

    //line on the right connecting the top and bottom lines
    line(37, 70, 32, 95);

    //draws the function drawX1 repeatedly by changing the value
    //of the x co-ordinate by 10 till it gets to a value of 55
    //horizontal tessellation
    for (int i=0; i<=55; i+=10) {
      //the negative of all the x co-ordinates till 55 and 0 as 
      //the y co-ordinate
      drawX1(-i, 0);
    }
  }

  // drawX1
  //  Purpose: To draw the X in between the top and bottom lines
  //           of bar1 once.
  //  Parameters: int x and int y
  //                x is the x co-ordinate of the left most point 
  //                  of the first line (starting point of the line)  
  //                y is the y co-ordinate of the left most point 
  //                  of the first line (starting point of the line)
  void drawX1(int x, int y) {

    //stores data about the current state of the co-ordinate system
    pushMatrix();

    //transforms the co-ordinate system
    translate(x, y);

    //thickness of the lines in between the top and bottom lines
    strokeWeight(2);

    line(37, 70, 10, 95);//from down to up

    line(37, 95, 17, 70);//from up to down

    //restores the co-ordinate system to its original
    popMatrix();
  }

  //bar2
  //Purpose: To draw the lower horizontal bar on the tower
  void bar2() {

    stroke(30, 80, 100);  //orange

    //thickness of the middle line
    strokeWeight(5);

    line(-57, 150, 57, 150); // middle line

    //thickness of the lower and upper lines
    strokeWeight(2);

    line(-57, 175, 60, 175); //lower line

    line(-57, 125, 60, 125); //upper line

    //line on the left connecting the lower, middle and upper bar
    line(60, 125, 60, 175);

    //line on the right connecting the lower, middle and upper bar
    line(-57, 125, -57, 175);

    //draws the x in between the middle and lower line and middle 
    //and upper line repeatedly
    //tesselates x both horizontally and vertically
    for (int i=0; i<=100; i+=20) {
      for (int j=0; j<=40; j+=25) {
        //value between the starting point of the line and 100 for 
        //the x co-ordinate and a value between the starting point of 
        //the line and 40 for the y co-ordiante
        drawX2(i, j);
      }
    }
    //returns the co-ordinate system to the way it was before the 
    //translation takes place
    popMatrix();
  }

  // drawX2
  //  Purpose: To draw the X in between the middle and lower line
  //           and middle and upper lines of bar2 once.
  //  Parameters: int x and int y
  //                x is the x co-ordinate of the left most point 
  //                  of the first line (starting point of the line)  
  //                y is the y co-ordinate of the left most point 
  //                  of the first line (starting point of the line)
  void drawX2(int x, int y) {

    //stores data about the current state of the co-ordinate system
    pushMatrix();

    //transfomrs the co-ordinate system
    translate(x, y);

    line(-57, 150, -37, 125);//from down to up

    line(-57, 125, -37, 150);//from up to down

    //restores the co-ordinate system to its original
    popMatrix();
  }

  //drawTop
  //Purpose: To draw the top part of the tower
  //         (semi-cricle and line on top)
  void drawTop() {

    fill(270, 60, 100); // lavander
    stroke(0, 0, 0); //black
    arc(0, -210, 17, 17, -PI, 0); // semi-circle

    //line extending up from the semi-circle
    line(0, -219, 0, -245);
  }

  //eiffel
  //Purpose: Contains all of the functions used to draw the 
  //         eiffel tower.
  void eiffel() {

    //water
    drawWater(); 

    //trees
    drawTrees();

    //arc making up the bottom of the tower
    bottomArc();

    //left side of the tower
    drawSide();

    //reflect the left arc with respect to the y-axis to form 
    //the right part
    rotateY(135.125);
    drawSide();

    //trees
    drawTrees();

    //the first horizontal bar on the tower
    bar1();

    //the second horizontal bar on the tower
    bar2();

    //pink semi-circle and line on top of the tower
    drawTop();
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
