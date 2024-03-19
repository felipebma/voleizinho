import 'package:flutter/material.dart';

class SkillGauge extends StatelessWidget {
  const SkillGauge(
      {super.key,
      required this.value,
      required this.onChanged,
      required this.label});

  final num value;
  final num maxValue = 10;
  final String label;
  final void Function(double) onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(label,
              style: const TextStyle(fontSize: 10, fontFamily: "poller_one")),
        ),
        Expanded(
          child: Slider(
            value: value.toDouble(),
            min: 0,
            max: 10,
            divisions: 10,
            label: value.toString(),
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}
