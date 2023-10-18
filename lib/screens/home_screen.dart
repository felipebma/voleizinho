import 'package:flutter/material.dart';
import 'package:voleizinho/components/menu_button.dart';
import 'package:voleizinho/model/group.dart';
import 'package:voleizinho/repositories/group_repository.dart';
import 'package:voleizinho/screens/group_home_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final List<Group> groups = GroupRepository().getGroups();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                    // Navigator.pushNamed(context, "/group_creation"),
                  },
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: groups.length,
                  itemBuilder: (context, index) {
                    return MenuButton(
                      text: groups[index].name!,
                      onPressed: () => {
                        Navigator.pushNamed(context, "/main_group",
                            arguments: GroupMainScreenArguments(
                                groupId: groups[index].id,
                                groupName: groups[index].name!)),
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: 20.0),
            ],
          ),
        ),
      ),
    );
  }
}
