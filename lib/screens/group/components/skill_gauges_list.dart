import 'package:flutter/material.dart';
import 'package:voleizinho/model/group.dart';
import 'package:voleizinho/model/skills.dart';
import 'package:voleizinho/screens/group/components/skill_gauge.dart';

class SkillGaugesList extends StatefulWidget {
  const SkillGaugesList({super.key, required this.group});

  final Group group;

  @override
  State<SkillGaugesList> createState() => _SkillGaugesListState();
}

class _SkillGaugesListState extends State<SkillGaugesList> {
  Group get group => widget.group;

  List<SkillGauge> skillGauges() {
    List<SkillGauge> skillGauges = [];
    for (Skill skill in Skill.values) {
      skillGauges.add(SkillGauge(
        label: skill.toShortString(),
        onChanged: (double value) {
          setState(() {
            group.skillsWeights[skill] = value.toInt();
          });
        },
        value: group.skillsWeights[skill] ?? 1,
      ));
    }
    skillGauges.sort((a, b) => a.label.compareTo(b.label));
    return skillGauges;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...skillGauges(),
      ],
    );
  }
}
