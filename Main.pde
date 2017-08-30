// the tunable variables

// scale of graph
int scale = 8;

// equation of dividing line
float eqn(float x) {
  return -0.5*x+21;
}
int numTrainingPoints = 1000;       // the number of training points to be used
float initialLearningRate = 0.001;  // the inital learning rate
float fineLearningRate = 0.0001;    // the fine tune learning rate
float rateChangeThreshold = 5;      // percentage at which to switch to fine rate 
// ----------------------
// - the illegible code -
// ----------------------

// int form of same equation
int intEqn(float x) {
  return (int) eqn(x);
}
// function to draw line using graph coordinates
void drawLine(float x1, float y1, float x2, float y2) {
  line(toScale(x1+50), height-toScale(y1+50), toScale(x2+50), height-toScale(y2+50));
}
// function to draw point using graph coordinates
void drawPoint(float x, float y, int size) {
  ellipse(toScale(x+50), height-toScale(y+50), size, size);
}
// function to adjust values to graph scale
int toScale(float input) {
  return scale * (int) input;
}

// stores all training points
Point[] points = new Point[numTrainingPoints];

// main instance of perceptron
Perceptron perceptron = new Perceptron(2, initialLearningRate);

void setup() {
  // set size and background of canvas
  surface.setSize(toScale(100), toScale(100));
  background(255);
  
  // initialize each point
  for (int x = 0; x < points.length; x++) {
    points[x] = new Point();
  }
}
// keep track of which point we are on
int trainingIndex = 0;

// keep track of whether we are training or not
boolean training = false;

// store error value to change learning rate
float previousError = 100;
void draw() {
  background(255);
  stroke(200);
  strokeWeight(1);
  drawLine(-50,0,50,0);
  drawLine(0,-50,0,50);
  
  if (training) {
    // get training point
    Point p = points[trainingIndex];
    while (perceptron.guess(p.x, p.y) == p.tag) {
      if (previousError == 0f) {
        training = false;
        perceptron.printWeights();
        break;
      }
      //skip right guesses
      trainingIndex++;
      if (trainingIndex == points.length)
        trainingIndex = 0;
      p = points[trainingIndex];
    }
    if (previousError < rateChangeThreshold) {
      // switch to fine learning rate
      perceptron.setLearningRate(fineLearningRate);
    }
    if (previousError < 1) {
      perceptron.setLearningRate(fineLearningRate/16);
    }
        
    // train with point data
    perceptron.train(p.tag, p.x, p.y);
  }
  
  // calculate total missed points
  int missed = 0;
  for (Point point : points) {
    point.show();
    int error = point.tag - perceptron.guess(point.x, point.y);
    if (error == 0) {
      noFill();
    } else {
      fill(200); // wrong guess in red
      missed++;
    }
    noStroke();
    
    drawPoint(point.x, point.y, 12);
  }
  
  // draw actual divider
  stroke(0, 200, 0);
  strokeWeight(3);
  drawLine(-50, intEqn(-50), 50, intEqn(50));
  
  // show perceptron's line
  perceptron.showWeights();
  
  if (training) {
    noStroke();
    // calculate error as percentage
    previousError = missed*100/(float) numTrainingPoints;
    
    // show error in fancy rectangle up top
    fill(255, 255, 255, 220);
    rect(0, 0, width, toScale(10));
    fill(0);
    textAlign(CENTER);
    textSize(toScale(5));
    text(String.format("Error: %.2f%% (%d/%d)", previousError, missed, numTrainingPoints), width/2, toScale(7));
  }
}
boolean pressed = false;
void mousePressed() {if(!pressed) {training = true;pressed = true;}} // start training state