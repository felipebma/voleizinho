import 'package:flutter/material.dart';
import 'package:voleizinho/model/group.dart';
import 'package:voleizinho/model/skills.dart';
import 'package:voleizinho/services/group_service.dart';

class GroupCreationScreen extends StatefulWidget {
  const GroupCreationScreen({super.key});

  @override
  State<GroupCreationScreen> createState() => _GroupCreationScreenState();
}

class _GroupCreationScreenState extends State<GroupCreationScreen> {
  bool usePositionalBalancing = false;

  Group group = Group();

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

  void cancel() {
    Navigator.pushReplacementNamed(context, "/");
  }

  void saveChanges() {
    if (group.name == null || group.name!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red[700],
          content: const Text(
            "O nome do grupo não pode estar vazio!",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      );
      return;
    }
    GroupService.updateGroup(group);
    Navigator.pushReplacementNamed(context, "/");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFCDE8DE),
        elevation: 0,
        foregroundColor: Colors.black,
        leading: Container(),
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
                  TextField(
                    controller: TextEditingController(text: group.name),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Nome do Grupo',
                      labelStyle: TextStyle(
                        fontFamily: "poller_one",
                        color: Colors.grey,
                      ),
                    ),
                    style: const TextStyle(
                      color: Colors.grey,
                      fontFamily: "poller_one",
                    ),
                    onChanged: (text) {
                      group.name = text;
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "BALANCEAMENTO POSICIONAL:",
                        style:
                            TextStyle(fontSize: 12, fontFamily: "poller_one"),
                      ),
                      Checkbox(
                          value: usePositionalBalancing,
                          onChanged: (value) {
                            setState(() {
                              usePositionalBalancing = value!;
                            });
                          })
                    ],
                  ),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () => {
                      Navigator.pushReplacementNamed(context, "/"),
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.all(20),
                      elevation: 6,
                    ),
                    child: const Text(
                      "Cancelar",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily: "poller_one",
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: saveChanges,
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
            ],
          ),
        ),
      ),
    );
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
