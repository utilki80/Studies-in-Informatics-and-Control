# Studies-in-Informatics-and-Control
For revision of our manuscript in Studies in Informatics and Control
Terminal Sliding Mode Control (TSMC) and Backstepping Terminal Sliding Mode Control (BTSMC). Both control schemes utilize radial basis function neural networks (RBFNN) to approximate the elements M(q), Vm(q, qdot), and G(q) in the dynamic equation of the robot system. The RBFNN is employed to approach the dynamic equation.

A finite-time control law, along with an appropriate update law, is designed to drive the system states towards the sliding surface and converge to zero within a finite time. The genetic algorithm is used to calculate the coefficients for the controller and the artificial neural network (ANN). These coefficients play a crucial role in influencing the system behavior, which ultimately affects the overall stability of the system. Achieving better tracking performance while considering real-life expectations and limitations is the primary motivation for this work, with a focus on optimizing the calculated controller coefficients.

To run the simulation, start by running the .slx file in Simulink. In the "genel kod" file, execute the command: genelkod(psize, mutation possibility, crossover possibility, crossover coefficient). Once the population is generated, the iteration process begins. The Genetic Algorithm uses the mean of link errors from the Simulink simulation as a cost function, aiming to minimize the error functions by determining the coefficients for the neural network (NN) and sliding mode control (SMC).
