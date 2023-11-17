import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voleizinho/bloc/groups/group_bloc.dart';
import 'package:voleizinho/bloc/groups/group_events.dart';
import 'package:voleizinho/bloc/groups/group_states.dart';
import 'package:voleizinho/components/drawer.dart';
import 'package:voleizinho/screens/group/components/skill_gauge.dart';
import 'package:voleizinho/model/group.dart';
import 'package:voleizinho/model/skills.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  Group? group;

  @override
  void initState() {
    super.initState();
    group = BlocProvider.of<GroupBloc>(context).state.activeGroup!;
  }

  List<SkillGauge> _skillGauges() {
    List<SkillGauge> skillGauges = [];
    for (Skill skill in Skill.values) {
      skillGauges.add(SkillGauge(
        label: skill.toShortString(),
        onChanged: (double value) {
          setState(() {
            group!.skillsWeights[skill] = value.toInt();
          });
        },
        value: group!.skillsWeights[skill] ?? 1,
      ));
    }
    skillGauges.sort((a, b) => a.label.compareTo(b.label));
    return skillGauges;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GroupBloc, GroupState>(
      listener: (context, state) => {
        if (state is GroupDeletedState)
          {
            Navigator.pushReplacementNamed(context, "/"),
          }
        else if (state is GroupUpdatedState)
          {
            Navigator.pushReplacementNamed(context, "/main_group"),
          }
      },
      builder: (context, state) => Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFFCDE8DE),
          elevation: 0,
          foregroundColor: Colors.black,
          actions: [
            PopupMenuButton(
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 0,
                  child: Text("Deletar Grupo"),
                ),
              ],
              onSelected: (value) {
                if (value == 0) {
                  BlocProvider.of<GroupBloc>(context)
                      .add(GroupDeleteEvent(state.activeGroup!));
                }
              },
            ),
          ],
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
                    TextField(
                      controller: TextEditingController(text: group!.name),
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
                        group!.name = text;
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
                            value: group!.usePositionalBalancing,
                            onChanged: (value) {
                              setState(() {
                                group!.usePositionalBalancing = value!;
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
                    ..._skillGauges(),
                  ],
                ),
                TextButton(
                  onPressed: () => BlocProvider.of<GroupBloc>(context)
                      .add(GroupUpdateEvent(group!)),
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
        ),
      ),
    );
  }
}
