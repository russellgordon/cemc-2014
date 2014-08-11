/*
 * A wrapper program that basically allows me to move
 * through various Processing programs as a slideshow.
 */

// Track what slide we are on
int currentSlide = 1;
final int MAX_SLIDES = 2;

// Variables for each slide
TitleSlide slide1;
EllipseTest slide2;

// This runs once.
void setup() {

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
      slide1 = null; // de-reference object for prior slide
      slide2 = new EllipseTest();
      size(800, 600);
    }
    slide2.drawFrame();
    //println("case 2");
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
  }
}
