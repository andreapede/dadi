# Dice Probability Calculator

A Flutter application for calculating dice roll probabilities using dynamic programming.

## Project Overview

This application allows users to:
- Select number of dice (1-10)
- Choose dice type (d4, d6, d8, d10, d12, d20)
- Roll dice and see results
- View the probability of getting specific sums

## Flutter Setup

1. Install Flutter SDK
   ```bash
   flutter doctor
I'll help you update the README.md file with detailed information about the project, Flutter, and the probability calculation algorithm.

```markdown
# Dice Probability Calculator

A Flutter application for calculating dice roll probabilities using dynamic programming.

## Project Overview

This application allows users to:
- Select number of dice (1-10)
- Choose dice type (d4, d6, d8, d10, d12, d20)
- Roll dice and see results
- View the probability of getting specific sums

## Flutter Setup

1. Install Flutter SDK
   ```bash
   flutter doctor
   ```

2. Clone the repository
   ```bash
   git clone [repository-url]
   ```

3. Get dependencies
   ```bash
   flutter pub get
   ```

4. Run the app
   ```bash
   flutter run
   ```

## Probability Calculation Algorithm

The app uses dynamic programming to calculate exact probabilities for dice roll sums:

1. Creates a 2D array `dp[n+1][maxSum+1]` where:
   - n = number of dice
   - maxSum = n * faces (maximum possible sum)

2. Base case: `dp[0][0] = 1`

3. For each die (i), sum (j), and face value (k):
   ```
   dp[i][j] += dp[i-1][j-k]
   ```

4. Final probability = (number of ways to get sum) / (total possible outcomes)

### Example: 3d6 (Three 6-sided dice)

Total possible outcomes = 6³ = 216

| Sum | Ways to Get | Probability |
|-----|-------------|-------------|
| 3   | 1          | 0.46%      |
| 4   | 3          | 1.39%      |
| 5   | 6          | 2.78%      |
| 6   | 10         | 4.63%      |
| 7   | 15         | 6.94%      |
| 8   | 21         | 9.72%      |
| 9   | 25         | 11.57%     |
| 10  | 27         | 12.50%     |
| 11  | 27         | 12.50%     |
| 12  | 25         | 11.57%     |
| 13  | 21         | 9.72%      |
| 14  | 15         | 6.94%      |
| 15  | 10         | 4.63%      |
| 16  | 6          | 2.78%      |
| 17  | 3          | 1.39%      |
| 18  | 1          | 0.46%      |

## Implementation Details

The algorithm is implemented in Dart/Flutter using:
- Dynamic Programming for efficient calculation
- Material Design UI components
- Stateful widgets for managing dice state
- Real-time probability updates

## Resources

- [Flutter Documentation](https://docs.flutter.dev/)
- [Dart Programming Language](https://dart.dev/)
- [Material Design](https://material.io/)
- [Probability Theory](https://en.wikipedia.org/wiki/Probability_theory)

## License

This project is licensed under the MIT License - see the LICENSE file for details.
```