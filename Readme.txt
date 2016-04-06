----------------------------
CIS 540 Project, Spring 2015
----------------------------

In this project, you need to implement a controller to navigate aircraft while avoiding collision in MATLAB. We have provided here the skeleton code to run simulation for a given source and destinations of aircraft.

Organization
------------
The skeleton code consists of following files:
1. simulateStep(out, in, v, k, q): Computes the updated aircraft state based on controller output and previous state, that is used as input for the controller in the next iteration
2. runSimulation(s1, t1, s2, t2, timeout): Runs the simulation for given source and destination locations of aircraft until they reach their destination or timeout happens. 
3. controller(in, state): Computes the controller output based on the current state of the aircraft. A sample controller is provided. The code must be replaced with the actual controller. 
4. safetyMonitor(in1, in2): It returns true if the aircraft avoid collision avoidance. Must be implemented. 
5. testSimulation(s1, t1, s2, t2, timeout):  Runs the simulation and returns true if both aircraft reach their destination before timeout and false otherwise. 
6. [numPassed, numFailed, failureLog] = testbench(n, timeout): runs testSimulation for different sources and destinations on a grid of 2n x 2n points and returns number of test cases passed and failed and a log containing set of points that failed. 

Usage
-----
To run the simulation use the following command
runSimulation(s1, t1, s2, t2, timeout)

For example, say A goes from (0, 0) -> (0, 10) and B goes from (-5, 5) -> (5, 5). To run the simulation for at most 30 steps the following command is used. 
runSimulation([0, 0], [0, 10], [-5, 5], [5, 5], 40)

To test simulation use the following command
testSimulation(s1, t1, s2, t2, timeout)

To test controller on different source/destination points in a grid of 2n x 2n points, use the following command
[numPassed, numFailed, log] = testbench(n, timeout)


Test Cases: 
-----------
Use the following test cases to test your code:
runSimulation([0, 0], [0, 10], [5, 10], [10, 5], 40)
runSimulation([0, 0], [0, 10], [-5, 5], [5, 5], 40)
runSimulation([0, 0], [0, 10], [10, 0], [0, 0], 40)
runSimulation([0, 0], [10, 10], [10, 0], [0, 10], 40)
runSimulation([0, 5], [15, 5], [5, 10], [15, 0], 40)

Evaluation: 
-----------
Make sure that all test cases pass the following command:
[numPassed, numFailed, log] = testbench(3, 100)


