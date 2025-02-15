import 'package:flutter/material.dart';
// Import Random for dice rolling and pow for probability calculations
import 'dart:math' show pow, Random;

// Entry point of the application
void main() {
  runApp(DiceProbabilityApp());
}

// Root widget of the application - Stateless because it doesn't need to maintain any state
class DiceProbabilityApp extends StatelessWidget {
  const DiceProbabilityApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dice Probability Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DiceScreen(), // Main screen of the app
    );
  }
}

// Main screen widget - Stateful because it needs to maintain state (dice results, etc.)
class DiceScreen extends StatefulWidget {
  const DiceScreen({super.key});

  @override
  _DiceScreenState createState() => _DiceScreenState();
}

// State class for DiceScreen - Contains all the logic and UI state
class _DiceScreenState extends State<DiceScreen> {
  // State variables
  int numberOfDice = 1;         // Current number of dice selected
  int selectedDiceType = 6;     // Current type of dice (d6 by default)
  List<int> diceResults = [];   // Array to store individual dice results
  int totalSum = 0;             // Sum of all dice rolls
  double probability = 0.0;     // Probability of getting the current sum

  // List of supported dice types (standard D&D dice)
  final List<int> diceTypes = [4, 6, 8, 10, 12, 20];

  // Function to calculate probabilities using dynamic programming
  Map<int, double> calculateProbabilities(int n, int m) {
    int maxSum = n * m;    // Maximum possible sum (all dice showing highest value)
    int minSum = n;        // Minimum possible sum (all dice showing 1)
    
    // Create 2D array for dynamic programming
    // First dimension: number of dice
    // Second dimension: possible sums
    List<List<int>> dp = List.generate(
      n + 1,
      (_) => List.filled(maxSum + 1, 0)
    );
    
    // Base case initialization
    dp[0][0] = 1;
    
    // Fill the dynamic programming table
    // i: current number of dice
    // sum: current sum being calculated
    // value: current face value being considered
    for (int i = 1; i <= n; i++) {
      for (int sum = i; sum <= i * m; sum++) {
        for (int value = 1; value <= m && value <= sum; value++) {
          dp[i][sum] += dp[i - 1][sum - value];
        }
      }
    }

    // Calculate total possible outcomes (m^n)
    int totalOutcomes = pow(m, n).toInt();
    
    // Calculate probability for each possible sum
    Map<int, double> probabilities = {};
    for (int sum = minSum; sum <= maxSum; sum++) {
      if (dp[n][sum] > 0) {
        // Convert to percentage
        probabilities[sum] = (dp[n][sum] / totalOutcomes) * 100;
      }
    }
    
    return probabilities;
  }

  // Function to simulate rolling the dice
  void rollDice() {
    List<int> results = [];
    int sum = 0;
    final random = Random();  // Create single Random instance for efficiency
    
    // Roll each die and calculate sum
    for (int i = 0; i < numberOfDice; i++) {
      int result = 1 + random.nextInt(selectedDiceType); // 1 to selectedDiceType
      results.add(result);
      sum += result;
    }

    // Calculate probabilities for this dice configuration
    Map<int, double> probabilities = calculateProbabilities(numberOfDice, selectedDiceType);

    // Update the UI with new results
    setState(() {
      diceResults = results;
      totalSum = sum;
      probability = probabilities[sum] ?? 0.0;  // Get probability for current sum
    });
  }

  // Function to reset all values when dice configuration changes
  void _resetValues() {
    setState(() {
      diceResults = [];     // Clear individual results
      totalSum = 0;         // Reset sum
      probability = 0.0;    // Reset probability
    });
  }

  // Build the UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dice Probability Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Number of dice selector with Slider
            Text(
              'Number of Dice: $numberOfDice',
              style: TextStyle(fontSize: 18),
            ),
            Slider(
              value: numberOfDice.toDouble(),
              min: 1,
              max: 10,
              divisions: 9,
              label: numberOfDice.toString(),
              onChanged: (double value) {
                setState(() {
                  numberOfDice = value.toInt();
                  _resetValues(); // Reset results when dice count changes
                });
              },
            ),
            SizedBox(height: 20),

            // Dice type selector dropdown
            DropdownButton<int>(
              value: selectedDiceType,
              onChanged: (value) {
                setState(() {
                  selectedDiceType = value!;
                  _resetValues(); // Reset results when dice type changes
                });
              },
              items: diceTypes
                  .map((value) => DropdownMenuItem<int>(
                        value: value,
                        child: Text('d$value'),  // Display as "d4", "d6", etc.
                      ))
                  .toList(),
            ),
            SizedBox(height: 20),

            // Roll dice button
            ElevatedButton(
              onPressed: rollDice,
              child: Text('Roll Dice'),
            ),
            SizedBox(height: 20),

            // Results display section
            Text(
              'Results: ${diceResults.join(", ")}',  // Show individual dice results
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'Sum: $totalSum',  // Show total sum
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'Probability: ${probability.toStringAsFixed(2)}%',  // Show probability with 2 decimal places
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}