import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  int spikeWeight = 0;
  int blockWeight = 0;
  int serveWeight = 0;
  int receiveWeight = 0;
  int setterWeight = 0;
  int agilityWeight = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFFCDE8DE),
          elevation: 0,
          foregroundColor: Colors.black,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(50.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Peso Por Skill",
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: "poller_one",
                          fontWeight: FontWeight.bold),
                    ),
                    SkillGauge(
                      label: "Ataque",
                      onChanged: (double value) {
                        setState(() {
                          spikeWeight = value.toInt();
                        });
                      },
                      value: spikeWeight,
                    ),
                    SkillGauge(
                      label: "Bloqueio",
                      onChanged: (double value) {
                        setState(() {
                          blockWeight = value.toInt();
                        });
                      },
                      value: blockWeight,
                    ),
                    SkillGauge(
                      label: "Saque",
                      onChanged: (double value) {
                        setState(() {
                          serveWeight = value.toInt();
                        });
                      },
                      value: serveWeight,
                    ),
                    SkillGauge(
                      label: "Recepção",
                      onChanged: (double value) {
                        setState(() {
                          receiveWeight = value.toInt();
                        });
                      },
                      value: receiveWeight,
                    ),
                    SkillGauge(
                      label: "Levantamento",
                      onChanged: (double value) {
                        setState(() {
                          setterWeight = value.toInt();
                        });
                      },
                      value: setterWeight,
                    ),
                    SkillGauge(
                      label: "Movimentação",
                      onChanged: (double value) {
                        setState(() {
                          agilityWeight = value.toInt();
                        });
                      },
                      value: agilityWeight,
                    ),
                  ],
                ),
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.all(20),
                  ),
                  child: const Text(
                    "Salvar",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontFamily: "poller_one",
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

class SkillGauge extends StatelessWidget {
  const SkillGauge(
      {super.key,
      required this.value,
      required this.onChanged,
      required this.label});

  final int value;
  final int maxValue = 10;
  final String label;
  final void Function(double) onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontFamily: "poller_one")),
        Slider(
          value: value.toDouble(),
          min: 0,
          max: 10,
          divisions: 10,
          label: value.toString(),
          onChanged: onChanged,
        ),
      ],
    );
  }
}
