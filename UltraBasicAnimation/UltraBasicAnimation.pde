int x = 0;

void setup() {
  size(400, 400);
  background(255, 255, 255);
}

void draw() {
  x++;
  
  // uncomment this to see what happens
//fill(255, 255, 255, 10);
//rect(0, 0, width, height);

  ellipse(x, 200, 50, 50);
}
