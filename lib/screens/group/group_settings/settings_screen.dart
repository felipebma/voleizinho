import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voleizinho/bloc/group/groups_bloc.dart';
import 'package:voleizinho/bloc/group/groups_event.dart';
import 'package:voleizinho/bloc/group/groups_state.dart';
import 'package:voleizinho/components/drawer.dart';
import 'package:voleizinho/screens/group/components/menu_button.dart';
import 'package:voleizinho/model/group.dart';
import 'package:voleizinho/screens/group/components/skill_gauges_list.dart';
import 'package:voleizinho/services/group_service.dart';

class GroupSettingsScreen extends StatefulWidget {
  const GroupSettingsScreen({super.key});

  @override
  State<GroupSettingsScreen> createState() => _GroupSettingsScreenState();
}

class _GroupSettingsScreenState extends State<GroupSettingsScreen> {
  Group group = GroupService.I.activeGroup();

  @override
  Widget build(BuildContext context) {
    return BlocListener<GroupsBloc, GroupsState>(
      listener: (context, state) {
        if (state.status == GroupsStatus.edited) {
          Navigator.pushReplacementNamed(context, "/main_group");
        } else if (state.status == GroupsStatus.deleted) {
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
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFFCDE8DE),
          elevation: 0,
          foregroundColor: Colors.black,
          actions: [
            PopupMenuButton(
              itemBuilder: (context) {
                return [
                  const PopupMenuItem(
                    value: 0,
                    child: Text("Deletar Grupo"),
                  ),
                ];
              },
              onSelected: (value) {
                if (value == 0) {
                  context.read<GroupsBloc>().add(DeleteGroupEvent(group));
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
                MenuButton(
                    text: "Salvar",
                    onPressed: () =>
                        context.read<GroupsBloc>().add(EditGroupEvent(group)),
                    backgroundColor: Colors.green),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
