import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ScoreBoardScreen extends StatefulWidget {
  const ScoreBoardScreen({super.key});

  @override
  State<ScoreBoardScreen> createState() => _ScoreBoardScreenState();
}

class _ScoreBoardScreenState extends State<ScoreBoardScreen> {
  @override
  void initState() {
    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: const Color(0x0000000),
        elevation: 0,
        foregroundColor: Colors.black,
        title: GestureDetector(
          onTap: () => {
            setState(() {
              time1Score = 0;
              time2Score = 0;
            })
          },
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.green,
            ),
            // child: const Column(
            //   children: [
            //     Text(
            //       "reset",
            //       style: TextStyle(
            //         color: Colors.white,
            //         fontSize: 30,
            //         fontFamily: "poller_one",
            //       ),
            //     ),
            //   ],
            // ),
          ),
        ),
      ),
      body: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => {
                setState(() {
                  time1Score++;
                })
              },
              onHorizontalDragEnd: (details) => {
                if (details.primaryVelocity! > 0)
                  {
                    setState(() {
                      time1Score++;
                    })
                  }
                else
                  {
                    setState(() {
                      time1Score--;
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
                })
              },
              onHorizontalDragEnd: (details) => {
                if (details.primaryVelocity! > 0)
                  {
                    setState(() {
                      time2Score++;
                    })
                  }
                else
                  {
                    setState(() {
                      time2Score--;
                    })
                  }
              },
              child: Container(
                color: Colors.blue,
                child: Center(
                  child: Container(
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
