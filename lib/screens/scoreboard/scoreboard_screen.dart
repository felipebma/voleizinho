import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:voleizinho/components/drawer.dart';
import 'package:voleizinho/screens/scoreboard/components/score.dart';
import 'package:voleizinho/services/user_preferences.dart';

class ScoreBoardScreen extends StatefulWidget {
  const ScoreBoardScreen({super.key});

  @override
  State<ScoreBoardScreen> createState() => _ScoreBoardScreenState();
}

class _ScoreBoardScreenState extends State<ScoreBoardScreen> {
  @override
  void initState() {
    super.initState();
    initializeScore();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  @override
  void deactivate() {
    super.deactivate();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]).then((value) => null);
  }

  int team1Score = 0;
  int team2Score = 0;

  void initializeScore() {
    UserPreferences.getScores().then((value) => {
          setState(() {
            team1Score = value[0];
            team2Score = value[1];
          })
        });
  }

  void resetScore() {
    setState(() {
      team1Score = 0;
      team2Score = 0;
    });
  }

  void incrementScore(int team) {
    if (team == 1) {
      setState(() {
        team1Score++;
      });
    } else {
      setState(() {
        team2Score++;
      });
    }
    UserPreferences.saveScores(team1Score, team2Score);
  }

  void decrementScore(int team) {
    if (team == 1) {
      setState(() {
        team1Score--;
      });
    } else {
      setState(() {
        team2Score--;
      });
    }
    UserPreferences.saveScores(team1Score, team2Score);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: const Color(0x00000000),
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      drawer: const CustomDrawer(),
      body: Row(
        children: [
          Score(
              score: team1Score,
              incrementScore: () => incrementScore(1),
              decrementScore: () => decrementScore(1),
              backgroundColor: Colors.red),
          Score(
              score: team2Score,
              incrementScore: () => incrementScore(2),
              decrementScore: () => decrementScore(2),
              backgroundColor: Colors.blue),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        backgroundColor: Colors.green,
        label: const Text(
          "RESET",
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontFamily: "poller_one",
          ),
        ),
        onPressed: resetScore,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
