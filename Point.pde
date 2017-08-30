class Point {
  float x;
  float y;
  int tag;
  
  Point() {
    // create point at random location
    x = random(-50, 50);
    y = random(-50, 50);
    tagMe();
  }
  Point(float x_, float y_) {
    // create point at given location
    x = x_;
    y = y_;
    tagMe();
  }
  void tagMe() {
    if (y > eqn(x)) {
      tag = 1;
    } else {
      tag = -1; 
    }
  }
  void show() {
    stroke(150);
    strokeWeight(1);
    noFill();
    if(tag == 1) {
      stroke(50);
      strokeWeight(2);
    }
    drawPoint(x,y,18);
  }
}