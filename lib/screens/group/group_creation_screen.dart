import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voleizinho/bloc/group/groups_bloc.dart';
import 'package:voleizinho/bloc/group/groups_event.dart';
import 'package:voleizinho/bloc/group/groups_state.dart';
import 'package:voleizinho/model/group.dart';
import 'package:voleizinho/screens/group/components/skill_gauges.dart';

class GroupCreationScreen extends StatefulWidget {
  const GroupCreationScreen({super.key});

  @override
  State<GroupCreationScreen> createState() => _GroupCreationScreenState();
}

class _GroupCreationScreenState extends State<GroupCreationScreen> {
  Group group = Group();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFCDE8DE),
        elevation: 0,
        foregroundColor: Colors.black,
        leading: Container(),
      ),
      body: BlocListener<GroupsBloc, GroupsState>(
        listener: (context, state) {
          if (state.status == GroupsStatus.created) {
            Navigator.pushReplacementNamed(context, "/");
          } else if (state.status == GroupsStatus.error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.red[700],
                content: Text(
                  state.errorMessage!,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            );
          }
        },
        child: Center(
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
                            value: group.usePositionalBalancing,
                            onChanged: (value) {
                              setState(() {
                                group.usePositionalBalancing = value!;
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
                    SkillGaugesList(
                      group: group,
                    )
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
                      onPressed: () => {
                        BlocProvider.of<GroupsBloc>(context)
                            .add(CreateGroupEvent(group)),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
