import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:voleizinho/components/drawer.dart';
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
          Expanded(
            child: GestureDetector(
              onTap: () => {
                setState(() {
                  time1Score++;
                  saveScores();
                })
              },
              onHorizontalDragEnd: (details) => {
                if (details.primaryVelocity! > 0)
                  {
                    setState(() {
                      time1Score++;
                      saveScores();
                    })
                  }
                else
                  {
                    setState(() {
                      time1Score--;
                      saveScores();
                    })
                  }
              },
              child: Container(
                color: Colors.red,
                child: Center(
                  child: Text(
                    time1Score.toString(),
                    style: const TextStyle(
                      fontSize: 300,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => {
                setState(() {
                  time2Score++;
                  saveScores();
                })
              },
              onHorizontalDragEnd: (details) => {
                if (details.primaryVelocity! > 0)
                  {
                    setState(() {
                      time2Score++;
                      saveScores();
                    })
                  }
                else
                  {
                    setState(() {
                      time2Score--;
                      saveScores();
                    })
                  }
              },
              child: Container(
                color: Colors.blue,
                child: Center(
                  child: Text(
                    time2Score.toString(),
                    style: const TextStyle(
                      fontSize: 300,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
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
        onPressed: () {
          setState(() {
            time1Score = 0;
            time2Score = 0;
          });
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
