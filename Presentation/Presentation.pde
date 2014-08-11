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
final int MAX_SLIDES = 6;

// Variables for each slide
TitleSlide slide1;
SoftwareStructure3 slide2;
SpiralDoodle slide3;
GOL slide4;
SinusoidalFunctions slide5;
BA slide6;
BA slide7;


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
      slide5 = new SinusoidalFunctions();
      // Size of canvas
      size(1200, 640, P3D); // Change size to 320 x 240, 640 x 480, or 800 x 600 if too slow at 1024 x 768
    }
    break;
  case 6:
    if (slide5 != null) {
      slide5 = null; // de-reference object for neighbouring slide
      slide6 = new BA();
      //canvas size
      size(485, 670, P3D);
    }
    if (slide7 != null) {
      slide7 = null; // de-reference object for neighbouring slide
      slide6 = new BA();
      //canvas size
      size(485, 670, P3D);
    }
    slide6.drawFrame();
    break;
  }
}

// This responds to keypresses
void keyPressed() {

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
    }
  }
}
