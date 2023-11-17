import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voleizinho/bloc/groups/group_bloc.dart';
import 'package:voleizinho/bloc/groups/group_events.dart';
import 'package:voleizinho/bloc/groups/group_states.dart';
import 'package:voleizinho/components/menu_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    GroupBloc bloc = BlocProvider.of<GroupBloc>(context);
    bloc.add(GroupsLoadEvent());
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
                Expanded(
                  child: BlocBuilder<GroupBloc, GroupState>(
                    builder: (context, state) {
                      if (state is GroupsLoadedState) {
                        final groups = state.groups;
                        return ListView.builder(
                          itemCount: groups.length,
                          itemBuilder: (context, index) {
                            return MenuButton(
                              padding: EdgeInsets.zero,
                              text: groups[index].name!,
                              onPressed: () => {
                                bloc.add(GroupSelectEvent(groups[index])),
                                Navigator.pushReplacementNamed(
                                    context, "/main_group"),
                              },
                            );
                          },
                        );
                      }
                      return Container();
                    },
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
