// Required libraries 
import processing.video.*; // for video
import ddf.minim.*;        // for audio

class TitleSlide {

  // Global variables
  // For video work...
  color black;
  color white;
  int numPixels;
  Capture video;
  // For audio work...
  Minim minim;    // core Minim functionality accessed through this object
  AudioInput in;  // information picked up by microphone accessed through this object

  // constructor
  //
  // Purpose: Run once, when the class is instantiated and an object created.
  //
  TitleSlide(PApplet parentWindow) {

    // This the default video input, see the GettingStartedCapture 
    // example if it creates an error
    video = new Capture(parentWindow, width, height);

    // Use HSB colour model.
    colorMode(HSB, 360, 100, 100);

    // Set colours
    black = color(0, 0, 0);
    white = color(0, 0, 100); 

    // Start capturing the images from the camera
    video.start(); 

    // How many pixels in entire image?
    numPixels = video.width * video.height;

    // Don't show the mouse cursor
    noCursor();

    // Draw all geometry with smooth (anti-aliased) edges
    smooth();

    // Create an instance of the Minim class
    minim = new Minim( this );

    // Create an instance of the AudioInput class (named "in")
    // First arguemnt – process input in stereo
    // Second argument - buffer size in samples 
    //                   (basically, lag time between audio input and response on screen)
    //                   (smaller buffer, fewer samples, less to process, less lag time)
    in = minim.getLineIn( Minim.STEREO, 512 );
  }

  // drawFrame
  //
  // Purpose: Will be called from draw() function of wrapper program.
  void drawFrame() {

    // Capture and filter the video image.
    if (video.available()) {

      video.read();
      video.loadPixels();
      int threshold = 50; // Set the threshold value
      float pixelBrightness; // Declare variable to store a pixel's brightness

        // Turn each pixel in the video frame black or white depending on its brightness
      loadPixels();
      for (int i = 0; i < numPixels; i++) {
        pixelBrightness = brightness(video.pixels[i]);

        // Filter video image as long as no keys are pressed
        //        if (!keyPressed) {
        if (pixelBrightness > threshold) { // If the pixel is brighter than the
          video.pixels[i] = white; // threshold value, make it white
        } else { // Otherwise,
          video.pixels[i] = black; // make it black.
          //        }
        }
      }

      // Save changes to pixel array
      video.updatePixels();

      // Get the current level (amplitude) of all the audio samples in the buffer
      float level = in.mix.level();
      float hue = map(level * 100, 0, 5, 0, 360);
      hue = 240 - hue; // low amplitude/volume is blue, high amplitude/volume is reddish

      // Tint based on loudness of audio samples
      // (only if no keys are pressed)
      //      if (keyPressed) {
      //        tint(white);
      //      } else {
      tint(hue, 80, 90, 50);
      //      }

      // Show the video image on screen
      image(video, 0, 0);

      // Display presentation text in bottom corner of window
      textAlign(LEFT);
      textSize(48);
      fill(white);
      text("Using Processing to Attract", 50, height - 225);
      text("Non-traditional Students", 50, height - 175);
      text("to the CS Classroom", 50, height - 125);
      textSize(24);
      text("Russell Gordon", 50, height - 80);
      text("Royal St. George's College, Toronto, Ontario", 50, height - 50);
    }
  }
}
