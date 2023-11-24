import 'package:flutter/material.dart';

class Score extends StatelessWidget {
  const Score(
      {super.key,
      required this.score,
      required this.updateScore,
      required this.backgroundColor});

  final int score;
  final void Function(int) updateScore;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () => {
          updateScore(score + 1),
        },
        onHorizontalDragEnd: (details) => {
          updateScore(
            details.primaryVelocity! > 0 ? score + 1 : score - 1,
          ),
        },
        child: Container(
          color: backgroundColor,
          child: Center(
            child: Text(
              score.toString(),
              style: const TextStyle(
                fontSize: 300,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
