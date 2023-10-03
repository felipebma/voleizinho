import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:voleizinho/components/player_view.dart';
import 'package:voleizinho/model/player.dart';
import 'package:voleizinho/model/skills.dart';

class NewPlayerForm extends StatefulWidget {
  NewPlayerForm({
    super.key,
    required this.onNewPlayer,
    required this.onCancel,
    required this.onSave,
  });

  final void Function(Player player) onNewPlayer;
  final void Function() onCancel;
  final void Function(Player player) onSave;

  final Player player = Player(
    name: "Jogador",
    skills: {
      Skill.spike: 2,
      Skill.agility: 2,
      Skill.block: 2,
      Skill.receive: 2,
      Skill.serve: 2,
      Skill.set: 2,
    },
  );

  void resetNewPlayer() {
    player.name = "Jogador";
    player.skills = {
      Skill.spike: 2,
      Skill.agility: 2,
      Skill.block: 2,
      Skill.receive: 2,
      Skill.serve: 2,
      Skill.set: 2,
    };
  }

  @override
  State<NewPlayerForm> createState() => _NewPlayerFormState();
}

class _NewPlayerFormState extends State<NewPlayerForm> {
  List<Widget> playerDetails(Player player) {
    List<Widget> widgets = [];

    for (Skill skill in Skill.values) {
      widgets.add(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
          child: Row(
            textBaseline: TextBaseline.alphabetic,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                skill.toShortString(),
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  textBaseline: TextBaseline.alphabetic,
                ),
              ),
              RatingBar(
                itemSize: 30,
                glowColor: Colors.amber,
                initialRating: player.skills[skill]!.toDouble(),
                ratingWidget: RatingWidget(
                  full: const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  half: const Icon(
                    Icons.star_half,
                    color: Colors.amber,
                  ),
                  empty: const Icon(
                    Icons.star_border,
                    color: Colors.black,
                  ),
                ),
                onRatingUpdate: (rating) {
                  setState(() {
                    player.skills[skill] = rating.toInt();
                  });
                },
              )
            ],
          ),
        ),
      );
    }

    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          PlayerView(
            player: widget.player,
            editable: true,
          ),
          Material(
            elevation: 3,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.rectangle,
                ),
                child: Column(
                  children: [
                    ...playerDetails(widget.player),
                    const Divider(),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextButton(
                          style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.black,
                          ),
                          onPressed: () {
                            setState(() {
                              widget.resetNewPlayer();
                              widget.onCancel();
                            });
                          },
                          child: const Text(
                            "Cancelar",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.black,
                          ),
                          onPressed: () {
                            setState(() {
                              widget.onSave(
                                Player(
                                  name: widget.player.name,
                                  skills: {...widget.player.skills},
                                ),
                              );
                              widget.resetNewPlayer();
                            });
                          },
                          child: const Text(
                            "Salvar",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
