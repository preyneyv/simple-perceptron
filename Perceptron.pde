class Perceptron {
  float[] weights;
  float bias = 0;
  float learningRate;
  Perceptron(int inputs, float learningRate_) {
    weights = new float[inputs];
    //initalize weights with arbitrary values
    for (int i = 0; i < inputs; i++) {
      weights[i] = 1;
    }
    learningRate = learningRate_;
  }
  int guess(float... inputs) {
    // calculate sum and call activation function
    float sum = 0;
    for(int i = 0; i < weights.length; i++) {
      sum += weights[i]*inputs[i];
    }
    sum += bias;
    
    return activate(sum); 
  }
  int activate(float sum) {
    // activation function
    // classifies into +1 (above line)
    // or -1 (below line)
    if (sum >= 0)
      return 1;
    return -1;
  }
  
  void train(int desired, float... inputs) {
    // training function
    
    int guess = guess(inputs); // get guess
    float error = desired - guess; // calculate error
    
    // adjust weights and bias
    for(int i = 0; i < weights.length; i++) {
      weights[i] += error * inputs[i] * learningRate;
    }
    bias += error * 500 * learningRate;
    
  }
  
  void showWeights() {
    // show perceptron's line 
    stroke(0, 150, 255, 70);
    strokeWeight(10);
    drawLine(-50, getY(-50), 50, getY(50));
  }
  float getY(float x) {
    // calculate y value for given x using perceptron's weights
    float w0 = weights[0];
    float w1 = weights[1];
    return (-bias/w1) - (w0/w1) * x;
  }
  
  void setLearningRate(float lr) {
    // change the learning rate of the perceptron
    learningRate = lr; 
  }
  void printWeights() {
    println("Done training. Here are the weights.");
    for (float weight : weights) {
      print("Weight: ");
      println(weight);
    }
    print("Bias:   "); 
    println(bias);
  }
}