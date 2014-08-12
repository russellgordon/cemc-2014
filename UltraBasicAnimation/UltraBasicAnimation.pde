int x = 0;

void setup() {
  size(400, 400);
  background(255, 255, 255);
}

void draw() {
  x++;
//background(255, 255, 255);  // uncomment this to see what happens
  ellipse(x, 200, 50, 50);
}
