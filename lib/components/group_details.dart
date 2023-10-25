import 'package:flutter/material.dart';
import 'package:voleizinho/model/group.dart';

class GroupDetails extends StatefulWidget {
  const GroupDetails({super.key, required this.group, required this.usePositionalBalancing});

  final Group group;
  final bool usePositionalBalancing;
  final List<Widget> Function() skillGauges;
  final void Function() saveChanges;
  final void Function() cancelAction;


  @override
  State<GroupDetails> createState() => _GroupDetailsState();
}

class _GroupDetailsState extends State<GroupDetails> {

  Group? group;
  bool? usePositionalBalancing;


  @override
  Widget build(BuildContext context) {
    group = widget.group;
    usePositionalBalancing = widget.usePositionalBalancing;


    return Center(
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
                          value: usePositionalBalancing,
                          onChanged: (value) {
                            setState(() {
                              usePositionalBalancing = value;
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
                  ...widget.skillGauges(),
                ],
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
        ),
      ),;
  }
}
