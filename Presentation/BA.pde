import processing.video.*;

class BA {

  Movie myMovie;

  // constructor
  //
  // Purpose: Run once, when the class is instantiated and an object created.
  //
  BA(PApplet parentWindow) {
    background(0, 0, 0);
    myMovie = new Movie(parentWindow, "BA-edited.mov");
    myMovie.play();
  }

  // drawFrame
  //
  // Purpose: Will be called from draw() function of wrapper program.
  void drawFrame() {
    image(myMovie, (width - myMovie.width) / 2, (height - myMovie.height) / 2);
  }

}
