import 'package:flutter/material.dart';
import 'package:voleizinho/components/drawer.dart';
import 'package:voleizinho/model/skills.dart';
import 'package:voleizinho/services/group_service.dart';

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

  Map<Skill, int> weights = GroupService.getSkillsWeights();

  List<SkillGauge> skillGauges() {
    List<SkillGauge> skillGauges = [];
    for (Skill skill in Skill.values) {
      skillGauges.add(SkillGauge(
        label: skill.toShortString(),
        onChanged: (double value) {
          setState(() {
            weights[skill] = value.toInt();
          });
        },
        value: weights[skill] ?? 1,
      ));
    }
    skillGauges.sort((a, b) => a.label.compareTo(b.label));
    return skillGauges;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFFCDE8DE),
          elevation: 0,
          foregroundColor: Colors.black,
        ),
        drawer: const CustomDrawer(),
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
                    ...skillGauges(),
                  ],
                ),
                TextButton(
                  onPressed: () {
                    GroupService.updateSkillsWeights(weights);
                    Navigator.pop(context);
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.all(20),
                    elevation: 6,
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
