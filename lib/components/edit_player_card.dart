import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:voleizinho/components/player_card.dart';
import 'package:voleizinho/model/player.dart';
import 'package:voleizinho/model/skills.dart';

class EditPlayerCard extends StatefulWidget {
  const EditPlayerCard({
    super.key,
    required this.onCancel,
    required this.onSave,
    required this.player,
  });

  final void Function() onCancel;
  final void Function(Player player) onSave;

  final Player player;

  @override
  State<EditPlayerCard> createState() => _EditPlayerCardState();
}

class _EditPlayerCardState extends State<EditPlayerCard> {
  List<Widget> playerDetails(Player player) {
    List<Widget> widgets = [];
    List<Skill> skills = [...Skill.values];
    skills.sort((a, b) => a.toShortString().compareTo(b.toShortString()));

    for (Skill skill in skills) {
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
                  fontFamily: "poller_one",
                  fontWeight: FontWeight.bold,
                  textBaseline: TextBaseline.alphabetic,
                ),
              ),
              RatingBar(
                itemSize: 30,
                glowColor: Colors.amber,
                initialRating: player.skills[skill]!.toDouble(),
                allowHalfRating: true,
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
                    player.skills[skill] = rating.toDouble();
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
    return Column(
      children: [
        PlayerCard(
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
                            widget.onCancel();
                          });
                        },
                        child: const Text(
                          "Cancelar",
                          style: TextStyle(
                            fontFamily: "poller_one",
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
                              Player.withArgs(
                                name: widget.player.name,
                                skills: {...widget.player.skills},
                                groupId: widget.player.groupId,
                              ),
                            );
                          });
                        },
                        child: const Text(
                          "Salvar",
                          style: TextStyle(
                            fontFamily: "poller_one",
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
    );
  }
}
