import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voleizinho/bloc/group/groups_bloc.dart';
import 'package:voleizinho/bloc/group/groups_event.dart';
import 'package:voleizinho/bloc/group/groups_state.dart';
import 'package:voleizinho/components/menu_button.dart';
import 'package:voleizinho/model/group.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<GroupsBloc>(context).add(LoadGroups());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Image(image: AssetImage('assets/logo.png'), height: 200),
                const Text(
                  "VOLEIZINHO",
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    fontFamily: "poller_one",
                  ),
                ),
                const SizedBox(height: 20.0),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 50.0),
                  child: MenuButton(
                    leftWidget: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.green,
                      ),
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                    text: "Criar Grupo",
                    onPressed: () => {
                      Navigator.pushReplacementNamed(
                          context, "/group_creation"),
                    },
                  ),
                ),
                const SizedBox(height: 20.0),
                BlocConsumer<GroupsBloc, GroupsState>(
                    listener: (context, state) {
                  if (state.status == GroupsStatus.selected) {
                    Navigator.pushReplacementNamed(context, "/main_group");
                  }
                }, builder: (context, state) {
                  if (state.status == GroupsStatus.loading) {
                    return const CircularProgressIndicator();
                  }
                  List<Group> groups = state.groups;
                  return Expanded(
                    child: ListView.builder(
                      itemCount: groups.length,
                      itemBuilder: (context, index) {
                        return MenuButton(
                          padding: EdgeInsets.zero,
                          text: groups[index].name!,
                          onPressed: () => context
                              .read<GroupsBloc>()
                              .add(SetActiveGroupEvent(groups[index])),
                        );
                      },
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
