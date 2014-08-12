class HabermanOriginal {

  // Contains the starting, or intial, word (axiom)
  String axiom = "FF";

  // Contains the existing word
  String existingWord = "";

  // Contains the new (re-written) word
  String newWord = "";

  // Tracks how many times existing word has been re-written
  // In other words, how many generations of replacements have occured. 
  int rewriteCount = 0;

  // Tracks what character we are currently inspecting in the existing word
  int currentCharacter = 0;

  // Will contain all the rules that apply for this L-system
  StringDict rules; 

  // Defines the line segment length for n = 0 (if we press 'd' to draw the axiom)
  float lineLength = 300;

  // Will contain the line segment length for the current generation of the drawing
  float currentLineLength = 0;

  // Initial x-position of the turtle
  int xPosition = 400;

  // Initial y-position of the turtle
  int yPosition = 0;

  // Initial direction of the turtle (0 degrees: right, 90 degrees: down, 180 degrees: left,
  //                                  270 degrees: up).
  int direction = 90;

  // Angle of rotation for the turtle (when a + or a - is processed)
  float angle = 15; 

  // Optimal number of word re-writes that should occur
  // (You can directly control how many re-writes occur with the right arrow key)
  int n = 4;

  // Whether to show on-screen results (easier to follow, but slower)
  // or whether to show results in the console (harder to see what's going on, but program runs faster)
  boolean debug = false; 

  // How much to scale plant drawing by
  float scaleBy = 1; // no change to default size

  // constructor
  //
  // Purpose: Run once, when the class is instantiated and an object created.
  //
  // Parameters:
  //              xPos      Where the plant should be created, horizontally.
  //              yPos      Where the plant should be created, vertically.
  //              scaling   How much to scale plant drawing by. 1.0 = 'normal' size.
  HabermanOriginal(int xPos, int yPos, float scaling, int maxRewrites) {

    // Set turtle starting position
    xPosition = xPos; 
    yPosition = yPos;

    // Set scale factor for this instance of the class
    scaleBy = scaling;

    //set max allowable re-writes
    n = maxRewrites;

    // White background
    background(0, 0, 100);

    // Black text
    fill(0, 0, 0);

    // Set text size
    textSize(24);

    // Slow down the refresh rate
    //    frameRate(1);

    // Create the string dictionary object
    // What this line of code does...
    // "Using the StringDict class, create a new StringDict object, named 'rules' "
    rules = new StringDict();

    // Add rules (key-value pairs)
    //         key     value
    //
    // Some L-systems have more than one rule for replacements.
    // Just add another ".set" line for additional rules
    rules.set("F1", "0F1[+FF][-FF]X"); //33% chance this version will be drawn
    rules.set("F2", "0FF1[++FF][-FF]X"); //33% chance this version will be drawn
    rules.set("F3", "0F1[+FF][-F-F]X"); //34% chance this version will be drawn

    rules.set("X", "0F1[+FFF][-FFF]");


    // Before any re-writes, the existing word is set to the axiom
    existingWord = axiom;
    newWord = existingWord;
    rewriteCount = 0;

    // Print information about the current state of the L-system
    printLSystemState();
  }

  // update
  //
  // Purpose: When invoked, re-writes the L-system once, and then asks the turtle
  //          to draw it. 
  //
  void update() {
    
    // Only update the drawing if we haven't yet reached the optimal number of iterations
    if (rewriteCount < n) {
      rewriteWord();
    }
    pushMatrix();
    turtleDraw();
    popMatrix();
  }

  // printLSystemState
  //
  // Purpose: Prints information about what is currently happening in the L-system.
  //
  void printLSystemState() {

    // Print the axiom
    if (debug == true) {
      text("The axiom is: " + axiom, 0, 25);
    } else {
      //println("The axiom is: " + axiom);
    }

    // Print the existing word
    if (debug == true) {
      text("The existing word: " + existingWord, 0, 50, width, 200);
    } else {
      //println("The existing word: " + existingWord);
    }

    // Print what generation of replacement this is
    if (debug == true) {
      text("Have re-written word this many times: " + rewriteCount, 0, 275);
    } else {
      //println("Have re-written word this many times: " + rewriteCount);
    }
  }

  // rewriteWord
  // 
  // Purpose: Take existing word, iterate over each character, make replacements
  //          where needed based on the production rules.
  //
  void rewriteWord() {

    // New word from last time becomes existing word for this round of replacement
    existingWord = newWord;

    // Need to reset these variables to get ready for another round of replacement 
    newWord = "";
    rewriteCount += 1;

    // Paint the background again to clear previous work
    //background(255, 255, 255);

    // Print information about current state of L-system to screen
    printLSystemState();

    //Iterate over each character
    for (currentCharacter= 0; currentCharacter < existingWord.length (); currentCharacter++) {

      // Check each character - if it matches a rule, replace it
      if ( existingWord.charAt(currentCharacter) == 'F') {
        // replace
        // randomly generate a number between 0 and 100
        float randomNumber = random(0, 100); //"seed"
        if (randomNumber > 0 && randomNumber <= 33) {
          newWord += rules.get("F1");
        } else if (randomNumber > 33 && randomNumber <=66) {
          newWord += rules.get("F2");
        } else {
          newWord += rules.get("F3");
        }
      } else if ( existingWord.charAt(currentCharacter) == 'X') {
        // replace
        newWord += rules.get("X");
      } else {
        // copy the character directly
        newWord += existingWord.charAt(currentCharacter);
      }
    }

    // Print the new word
    if (debug == true) {
      text("New word is: " + newWord, 0, 350, width, 200);
    } else {
      //println("New word is: " + newWord);
      //println("That's " + rewriteCount + " rewrites.");
    }
  }

  // keyPressed
  // 
  // Purpose: A built-in function, Processing runs this any time a keyboard key is pressed.
  //
  void keyPress() {

    // When the 'n' key is pressed, do another round of replacement
    if (key == 'n') {
      rewriteWord();
    }

    // Draw the newly re-written word
    if (key == 'd') {
      turtleDraw();
    }

    // Start again
    if (key == 'r') {
      println("restarting drawing");
      // Before any re-writes, the existing word is set to the axiom
      existingWord = axiom;
      newWord = existingWord;
      rewriteCount = 0;

      // Start image again
      rewriteWord();
      turtleDraw();
    }
  }

  // turtleDraw
  //
  // Purpose: When invoked, the 'metaphorical' or imaginary turtle draws on-screen based on
  //          the contents of the newly re-written word
  //
  void turtleDraw() {

    background(0, 0, 100);

    //starting colour of tree
    stroke(81, 103, 71);

    // Get the turtle into it's starting position 
    translate(xPosition, yPosition);
    rotate(radians(direction));

    // Scale drawing
    scale(scaleBy);

    // Set the line length for this round of drawing
    currentLineLength = lineLength / pow(1.5, rewriteCount);

    // Iterate  
    for (currentCharacter= 0; currentCharacter < newWord.length(); currentCharacter++) {

      if ( newWord.charAt(currentCharacter) == '+') {
        // Turn left      
        rotate(radians(-angle));
      }
      else if ( newWord.charAt(currentCharacter) == '-') {
        // Turn right
        rotate(radians(angle));
      }
      else if ( newWord.charAt(currentCharacter) == '[') {
        // Pushing (saving) current position and rotation 
        //info onto the stack
        pushMatrix();
      }
      else if ( newWord.charAt(currentCharacter) == ']') {
        // Popping (removing) most recently saved location&rotation
        // info from stack
        popMatrix();
      }
      //Colouring the tree
      else if ( newWord.charAt(currentCharacter) == '0') {
        //brown
        stroke(72, 48, 43);
      }
      else if ( newWord.charAt(currentCharacter) == '1') {
        //second shade green
        stroke(81, 103, 71);
      }
      else if ( newWord.charAt(currentCharacter) == '2') {
        //third shade green
        stroke(61, 144, 60);
      }
      else {
        // Draw a segment
        line(0, 0, currentLineLength, 0);
        translate(currentLineLength, 0);
      }
    }
  }
}
