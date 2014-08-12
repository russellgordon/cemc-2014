/*
 * A wrapper program that basically allows me to move
 * through various Processing programs as a slideshow.
 *
 * Complement for presentation given at CEMC Summer Institute 2014:
 *
 * http://cemc.uwaterloo.ca/events/csteachers.html
 *
 * Notes and resources to accompany this presentation can be found here:
 *
 * http://russellgordon.ca/cemc/2014/using-processing-to-attract-non-traditional-students-to-the-cs-classroom/index.html
 *
 * License for use applies to this file only.  License for use for this wrapper file:
 *
 * http://creativecommons.org/licenses/by-nc-sa/4.0/
 *
 * Class files utilized by this wrapper may have different licensing terms.  See header information in each
 * class for details.
 */

// Track what slide we are on
int currentSlide = 1;
final int MAX_SLIDES = 10;

// Variables for each slide
TitleSlide slide1;
SoftwareStructure3 slide2;
SpiralDoodle slide3;
GOL slide4;
SinusoidalFunctions slide5;
BA slide6;
JH slide7;
EC slide8;
PixarImage slide9;
FooOriginal slide10;
FooOriginal slide11;

// This runs once.
void setup() {

  // Size of canvas
  size(1200, 640, P3D); // Change size to 320 x 240, 640 x 480, or 800 x 600 if too slow at 1024 x 768

  // Instantiate object for first slide.  
  slide1 = new TitleSlide(this);
}

// This runs repeatedly
void draw() {

  switch(currentSlide) {
  case 1:
    if (slide2 != null) {
      slide2 = null;
      slide1 = new TitleSlide(this);
    }
    slide1.drawFrame();
    break;
  case 2:
    if (slide1 != null) {
      slide1 = null; // de-reference object for neighbouring slide
      tint(0, 0, 100);
      slide2 = new SoftwareStructure3();
    }
    if (slide3 != null) {
      slide3 = null; // de-reference object for neighbouring slide
      slide2 = new SoftwareStructure3();
    }
    slide2.drawFrame();
    break;
  case 3:
    if (slide2 != null) {
      slide2 = null; // de-reference object for neighbouring slide
      slide3 = new SpiralDoodle();
    }
    if (slide4 != null) {
      slide4 = null; // de-reference object for neighbouring slide
      slide3 = new SpiralDoodle();
    }
    slide3.drawFrame();
    break;
  case 4:
    if (slide3 != null) {
      slide3 = null; // de-reference object for neighbouring slide
      slide4 = new GOL();
    }
    if (slide5 != null) {
      slide5 = null; // de-reference object for neighbouring slide
      slide4 = new GOL();
    }
    slide4.generate();
    slide4.display();
    break;
  case 5:
    if (slide4 != null) {
      slide4 = null; // de-reference object for neighbouring slide
      slide5 = new SinusoidalFunctions();
    }
    if (slide6 != null) {
      slide6 = null; // de-reference object for neighbouring slide
      // Size of canvas
      size(1200, 640, P3D); // Change size to 320 x 240, 640 x 480, or 800 x 600 if too slow at 1024 x 768
      slide5 = new SinusoidalFunctions();
    }
    break;
  case 6:
    if (slide5 != null) {
      slide5 = null; // de-reference object for neighbouring slide
      //canvas size
      size(485, 670, P3D);
      slide6 = new BA();
    }
    if (slide7 != null) {
      slide7 = null; // de-reference object for neighbouring slide
      //canvas size
      size(485, 670, P3D);
      frameRate(60);
      slide6 = new BA();
    }
    slide6.drawFrame();
    break;
  case 7:
    if (slide6 != null) {
      slide6 = null; // de-reference object for neighbouring slide
      // Size of canvas
      size(1200, 640, P3D); // Change size to 320 x 240, 640 x 480, or 800 x 600 if too slow at 1024 x 768
      slide7 = new JH();
    }
    if (slide8 != null) {
      slide8 = null; // de-reference object for neighbouring slide
      frameRate(25);
      slide7 = new JH();
    }
    slide7.drawFrame();
    break;
  case 8:
    if (slide7 != null) {
      slide7 = null; // de-reference object for neighbouring slide
      slide8 = new EC();
    }
    if (slide9 != null) {
      slide9 = null; // de-reference object for neighbouring slide
      slide8 = new EC();
    }
    slide8.drawFrame();
    break;
  case 9:
    if (slide8 != null) {
      slide8 = null; // de-reference object for neighbouring slide
      slide9 = new PixarImage();
    }
    if (slide10 != null) {
      slide10 = null; // de-reference object for neighbouring slide
      slide9 = new PixarImage();
    }
    slide9.drawFrame();
    break;
  case 10:
    if (slide9 != null) {
      slide9 = null; // de-reference object for neighbouring slide
      slide10 = new FooOriginal(width/2, height/2, 0.3, 5);
      slide10.update();
    }
    if (slide11 != null) {
      slide11 = null; // de-reference object for neighbouring slide
      slide10 = new FooOriginal(width/2, height/2, 0.3, 5);
      slide10.update();
    }
    break;
  }
}

// This responds to keypresses
void keyPressed() {
  
  loop();

  if (key == CODED) {
    if (keyCode == RIGHT) {
      // Can't go greater than max number of slides
      if (currentSlide < MAX_SLIDES) { 
        currentSlide++;
      }
    }
    if (keyCode == LEFT) {
      // Can't go lower than slide 1.
      if (currentSlide > 1) {
        currentSlide--;
      }
      println("current slide is " + currentSlide);
    }
  } else {
    switch(currentSlide) {

    case 1:
      break;
    case 2:
      slide2.keyPress();
      break;
    case 3:
      slide3.keyPress();
      break;
    case 4:
      slide4.keyPress();
      break;
    case 5:
      slide5.keyPress();
      break;
    case 6:
      slide6.keyPress();
      break;
    case 7:
      slide7.keyPress();
      break;
    case 8:
      slide8.keyPress();
      break;
    case 9:
      slide9.keyPress();
      break;
    case 10:
      slide10.keyPress();
      break;
    }
  }
}
