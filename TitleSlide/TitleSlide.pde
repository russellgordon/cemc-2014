/**
 * Brightness Thresholding 
 * by Golan Levin. 
 *
 * Modified by Russell Gordon, August 2014.
 *
 * Filters an image based on brightness of each pixel.
 * Audio levels used to determine hue of image tint.
 */

// Required libraries 
import processing.video.*; // for video
import ddf.minim.*;        // for audio

// Global variables
color black;
color white;
int numPixels;
Capture video;
Minim minim;    // core Minim functionality accessed through this object
AudioInput in;  // information picked up by microphone accessed through this object

// This function runs once.
void setup() {

  // Size of canvas
  size(1024, 768); // Change size to 320 x 240, 640 x 480, or 800 x 600 if too slow at 1024 x 768

    // This the default video input, see the GettingStartedCapture 
  // example if it creates an error
  video = new Capture(this, width, height);

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

// This function runs repeatedly. 
void draw() {

  // Capture and filter the video image.
  if (video.available()) {
    video.read();
    video.loadPixels();
    int threshold = 50; // Set the threshold value
    float pixelBrightness; // Declare variable to store a pixel's color
    float maxPixelBrightness = 0;
    // Turn each pixel in the video frame black or white depending on its brightness
    loadPixels();
    for (int i = 0; i < numPixels; i++) {
      pixelBrightness = brightness(video.pixels[i]);
      if (maxPixelBrightness < pixelBrightness) {
        maxPixelBrightness = pixelBrightness;
      }
      if (pixelBrightness > threshold) { // If the pixel is brighter than the
        video.pixels[i] = white; // threshold value, make it white
      } else { // Otherwise,
        video.pixels[i] = black; // make it black
      }
    }

    // Save changes to pixel array
    video.updatePixels();

    // Get the current level (amplitude) of all the samples in the buffer
    float level = in.mix.level();
    float hue = map(level * 100, 0, 50, 0, 360);
    hue = 240 - hue;

    // Tint based on loudness of audio samples
    tint(hue, 80, 90, 50);

    // Show the video image on screen
    image(video, 0, 0);
  }
}

// Required function for audio input; be sure not to remove
void stop()
{
  in.close();
  minim.stop();
  super.stop();
}
