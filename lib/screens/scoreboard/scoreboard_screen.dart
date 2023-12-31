import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:voleizinho/components/drawer.dart';
import 'package:voleizinho/screens/scoreboard/components/score.dart';
import 'package:voleizinho/services/user_preferences/user_preferences.dart';

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
    ]);
  }

  int time1Score = 0;
  int time2Score = 0;

  void initializeScore() {
    UserPreferences.getScores().then((value) => {
          setState(() {
            time1Score = value[0];
            time2Score = value[1];
          })
        });
  }

  void saveScores() {
    UserPreferences.saveScores(time1Score, time2Score);
  }

  void updateScore(int time, int score) {
    if (time == 1) {
      setState(() {
        time1Score = score;
      });
    } else {
      setState(() {
        time2Score = score;
      });
    }
    saveScores();
  }

  void resetScores() {
    setState(() {
      time1Score = 0;
      time2Score = 0;
    });
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
            score: time1Score,
            updateScore: (newScore) => updateScore(1, newScore),
            backgroundColor: Colors.red,
          ),
          Score(
            score: time2Score,
            updateScore: (newScore) => updateScore(2, newScore),
            backgroundColor: Colors.blue,
          ),
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
        onPressed: resetScores,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
