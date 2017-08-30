# Simple Perceptron
This is a repository that contains the code I've written for a simple perceptron, the core element of a neural network. This perceptron is written in [Processing](http://www.processing.org). It has a small optimization to allow it to train and reach a **0% error rate** very quickly for the set of points.

The code is commented. In the `Main.pde` file, there are variables and functions near the top. These can be modified to change, for example, the equation of the dividing line, in the format *m*x+*c*, the number of points and the learning rate. The `scale` variable can also be altered to change the scale of the graph to make it more legible.

The center of the graph is the point `(0,0)`, indicated by the intersection of the axes. A filled-in dot is an incorrect guess, while a clear dot is a correct one. Due to the nature of a single perceptron, it is only able to solve *linear equations*. The **green** line indicates the actual dividing line given by the original equation. The **translucent blue** line indicates the perceptron's guess.

In order to start the training process, *click* the canvas. It then begins to train the line until it reaches a 0% error rate. After reaching 0%, the program prints out the weights in the console. The optimization used is to skip over the correct guesses. This may seem minor but it reduced the training time from about **60 seconds** to about **5 seconds** for 1000 points. *That's more than a 10x improvement in speed!*

This was a fun project that taught me a lot about the basics of machine learning. Next stop - neural networks!

*- By [@preyneyv](http://www.twitter.com/preyneyv)*
