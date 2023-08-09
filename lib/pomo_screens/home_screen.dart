import 'dart:async';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const twentyFiveMinutesInSeconds = 1500;
  int totalSeconds = twentyFiveMinutesInSeconds;
  int totalPomodoros = 0;
  late Timer timer;
  bool isRunning = false;

  void onTick() {
    if (totalSeconds == 0) {
      reset();
      setState(() {
        totalPomodoros++;
      });
    } else {
      setState(() {
        totalSeconds--;
      });
    }
  }

  void reset() {
    setState(() {
      isRunning = false;
      totalSeconds = twentyFiveMinutesInSeconds;
      timer.cancel();
    });
  }

  void onStartPressed() {
    setState(() {
      isRunning = true;
    });
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      onTick();
    });
  }

  void onPausePressed() {
    setState(() {
      isRunning = false;
    });
    timer.cancel();
  }

  String format(int seconds) {
    var duration = Duration(seconds: seconds);
    var minuteAndSeconds =
        duration.toString().split(".")[0].split(":").sublist(1);
    var minute = minuteAndSeconds[0];
    var second = minuteAndSeconds[1];
    return '$minute:$second';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(children: [
        Flexible(
          flex: 1,
          child: Container(
            alignment: Alignment.bottomCenter,
            child: Text(
              format(totalSeconds),
              style: TextStyle(
                color: Theme.of(context).cardColor,
                fontSize: 90,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        Flexible(
          flex: 3,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const SizedBox(
              height: 96,
            ),
            IconButton(
              iconSize: 120,
              color: Theme.of(context).cardColor,
              icon: isRunning
                  ? const Icon(Icons.pause_circle_outline)
                  : const Icon(Icons.play_circle_outlined),
              onPressed: isRunning ? onPausePressed : onStartPressed,
            ),
            isRunning
                ? IconButton(
                    iconSize: 80,
                    color: Theme.of(context).cardColor,
                    onPressed: reset,
                    icon: const Icon(Icons.refresh),
                  )
                : const SizedBox(
                    height: 96,
                  )
          ]),
        ),
        Flexible(
          flex: 1,
          child: Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(50)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Pomodoros',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context)
                                .textTheme
                                .displayLarge
                                ?.color),
                      ),
                      Text(
                        '$totalPomodoros',
                        style: TextStyle(
                            fontSize: 60,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context)
                                .textTheme
                                .displayLarge
                                ?.color),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
