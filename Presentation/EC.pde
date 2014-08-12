class EC {

  //global variables: for all functions
  //h line to start
  int hLineShiftA=0; 
  int hLineShiftB=0;
  //h curve to start
  int quadShift=0;
  int hCurveShift=0;
  //h saturation shift to start
  int shiftHLineGradient=0;
  int shiftHCurveGradient=0;
  //rounded rectangle hue shift to start
  int shiftCGradient=0;
  //y line hue shift
  int shiftYGradient=100;
  //rotate the lines of o to start
  int rotateBy=0;
  //the starting shift of the y coordinate of the lines in l
  int lLineShift=0;
  //starting for first x and y coordinates for letter e and m
  float x=-53;
  float y=0;
  //second x and y coordinate for letter e (on circumference)
  float x2E; 
  float y2E; 
  float angleE; // in radians for letter e angle


  // constructor
  //
  // Purpose: Run once, when the class is instantiated and an object created.
  //
  EC() {
    mySetup();
  }

  // mySetup
  //
  // Purpose: Sets up initial state of sketch.  Called from constructor or when sketch is reset.
  // 
  void mySetup() {

    //colour mode set HSBT
    colorMode(HSB, 360, 100, 100, 100);

    // set the background color
    background(0, 0, 100, 0);

    // smooth edges
    smooth();

    // limit the number of frames per second; draw() function is run
    frameRate(15);

    hLineShiftA=0; 
    hLineShiftB=0;
    //h curve to start
    quadShift=0;
    hCurveShift=0;
    //h saturation shift to start
    shiftHLineGradient=0;
    shiftHCurveGradient=0;
    //rounded rectangle hue shift to start
    shiftCGradient=0;
    //y line hue shift
    shiftYGradient=100;
    //rotate the lines of o to start
    rotateBy=0;
    //the starting shift of the y coordinate of the lines in l
    lLineShift=0;
    //starting for first x and y coordinates for letter e and m
    x=-53;
    y=0;
    //second x and y coordinate for letter e (on circumference)
    x2E = 0; 
    y2E = 0; 
    angleE = 0;
  }


  // drawFrame
  //
  // Purpose: Will be called from draw() function of wrapper program.
  void drawFrame() {
    translate(0, 70);

    //draw e: shows coordinates to start lines for e
    drawLine(100, 310, 80);
    drawESpace();

    //draw h: quadratic line for h
    if (quadShift <=11) {
      drawHCurve();
    }
    drawHLine();

    //draw C: drawing the background and the white letter
    drawCBox();
    drawLetterC();

    //call function of drawing letter o
    drawLetterO();

    //call funciton to draw letter m
    //draw a semi transparent white rectangle over to loop the m 
    noStroke();
    fill(0, 0, 100, 6);
    rect(190, 220, 250, 200);
    drawLetterM(260, 250);
    drawLetterM(360, 250);

    //call function to draw letter I
    drawLetterI();
    noStroke();
    fill(0, 0, 100, 4);
    rect(530, 100, 50, 300);

    //call function to draw letter L
    drawLetterL();
    noStroke();
    fill(0, 0, 100, 8);
    rect(495, 90, 60, 330);

    //call function to draw letter Y
    drawLetterY();
  }

  //draw letter e
  void drawLine(int xE, int yE, int radius) {

    // declare any local variables
    //draws lines in circle
    //using trigonometry to determine the angle from the terminal angle
    angleE = random(0, TWO_PI);    
    y2E = sin(angleE)*radius;   
    x2E = cos(angleE)*radius;   
    strokeWeight(3);
    stroke(random(0, 360), 30, 90); 
    line (xE, yE, x2E + xE, yE - y2E);
  }

  //draw white spaces of e 
  void drawESpace() {
    fill(0, 0, 100);
    noStroke();
    arc(100, 305, 130, 130, PI, TWO_PI);
    arc(100, 315, 130, 130, 0, PI);
    rect(150, 315, 35, 30);
  }

  //draw lines of letter H
  void drawHLine() {  
    //draw the lines of h: as long as the elipse has shifted less than
    //270 and 120 continue to shift it 
    if (hLineShiftA <=270) {
      hLineShiftA +=3;
    }
    if (hLineShiftB <=120) {
      hLineShiftB +=3;
    }
    shiftHLineGradient +=1;
    noStroke();
    //shifts the saturation of the circles
    fill(180, 0+shiftHLineGradient, 90);
    ellipse(905, 100+ hLineShiftA, 20, 20);
    ellipse(1011, 250+hLineShiftB, 20, 20);
  }

  //draw curves of letter H
  void drawHCurve() {
    // shift the ellipse in a quadratic shape by 3^2
    if (quadShift <=11) {
      quadShift +=(hLineShiftA^2)/20;
      hCurveShift +=3;
      shiftHCurveGradient +=3;
    }
    // draw curve using quadratic
    noStroke();
    fill(180, 0, 90);
    //changes the coordinate of the circle using the quadratic or curve shift
    ellipse(960+hCurveShift, 240+ quadShift, 20, 20);
    fill(180, 0+shiftHCurveGradient, 90);
    ellipse(960-hCurveShift, 240+ quadShift, 20, 20);
  }

  //draw letter C
  void drawCBox() {
    noStroke();
    //colour change shifting and when it reaches a certain colour
    //it goes back to the original colour and repeats
    if (shiftCGradient == 360) {
      shiftCGradient -= 360;
    } else {
      shiftCGradient += 10;
    }
    //rounded rectangle
    //draws the rectangle with arcs for the rounded corners
    //shifts the colour
    fill(shiftCGradient, 30, 80);
    arc(855, 370, 40, 40, 0, PI/2);
    arc(755, 270, 40, 40, PI, TWO_PI-PI/2);
    arc(855, 270, 40, 40, TWO_PI-PI/2, TWO_PI);
    arc(755, 370, 40, 40, PI/2, PI);
    rect(755, 250, 100, 140);
    rect(735, 270, 140, 100);
  }

  //draw inverse of letter c
  // this draws the white c portioninside the coloured box
  void drawLetterC () {
    stroke(0, 0, 100);
    strokeWeight(15);
    noFill();
    arc(808, 320, 110, 120, PI/6, (11*PI)/6);
  }

  //draw letter o with rotating lines usint a shifted origin
  //rotate the line
  void drawLetterO() {
    //rotates line
    rotateBy +=3; 
    stroke(80, 80, 80, 30);
    strokeWeight(3);
    //shifts origin
    pushMatrix();
    translate(1110, 310);
    rotate(rotateBy);
    //randomizes line length
    line(50, 3, random(40, 80), 40);
    popMatrix();
  }
  //draw letter m using a shifted origin
  //draw a circle and follow quadratic path within certain domain
  void drawLetterM (int xM, int yM) {
    fill(55, 70, 80);
    stroke(0, 0, 100);
    //shifts origin
    pushMatrix();
    //loops animation by restarting x value once it reaches certain domain
    translate(xM, yM);
    if (x<53) {
      x+=1.5;
    }
    if (x>=53) {
      x= -53;
    }
    //quadratic formula
    y=0.05*x*x;
    ellipse(x, y, 25, 25);
    popMatrix();
  }

  //change colours by changing variable of tessalating  circles
  //tessalate circles for 'i' and shift colour
  void drawLetterI () {
    fill(shiftCGradient, 20, 80);
    for (int y = 0; y<=120; y +=30) {
      ellipse(460, 260+y, 20, 20);
    }
    ellipse(460, 210, 20, 20);
  }

  //shift y coordinate by until it readhes 380 and then restart
  void drawLetterL () {
    stroke(random(0, 360), 50, 80);
    strokeWeight(4);
    line(500, 100+lLineShift, 520, 100+lLineShift);
    //contsrict y coordinate of lines
    if (lLineShift<280) {
      lLineShift+=15;
    } else {
      lLineShift=0;
    }
  }

  //draw lines with a thickness of 15
  void drawLetterY() {
    //change the colour of the y starting with 100
    if (shiftYGradient == 360) {
      shiftYGradient -= 360;
    } else {
      shiftYGradient += 10;
    }
    stroke(shiftYGradient, 20, 80);
    strokeWeight(15);
    line(540, 260, 600, 380);
    line(660, 260, 560, 460);
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
