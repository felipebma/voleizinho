import 'package:flutter/material.dart';

class Score extends StatelessWidget {
  const Score(
      {super.key,
      required this.score,
      required this.incrementScore,
      required this.decrementScore,
      required this.backgroundColor});

  final int score;
  final Function() incrementScore;
  final Function() decrementScore;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () => incrementScore(),
        onHorizontalDragEnd: (details) => {
          if (details.primaryVelocity! > 0)
            {incrementScore()}
          else
            {decrementScore()}
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
