import 'dart:async';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:thomas/ui/screens/audio/cubit/main_cubit.dart';

class GameManager extends FlameGame {
  MainCubit cubit;
  AudioPlayer player;
  int totalAudioDuration = 0;
  String totalAudioDurationString = "0";
  RegExp durationRegex = RegExp("[0-9]{2}:[0-9]{2}");
  double screenWidth;
  double screenHeight;
  double timeCount = 0;
  double printSpeed = 0.5;

  TextComponent texteCompo = TextComponent(
    text: "",
    textRenderer: TextPaint(style: TextStyle(fontSize: 15)),
    anchor: Anchor.center,
    position: Vector2(0, 0),
  );
  RectangleComponent currentPositionRetangle = RectangleComponent(
    anchor: Anchor.topLeft,
    position: Vector2(0, 0),
    size: Vector2(0, 0),
    paint: Paint()..color = Color.fromARGB(255, 39, 101, 104),
  );

  GameManager(
      {required this.cubit,
      required this.player,
      required this.screenWidth,
      required this.screenHeight});

  void audioChange(AudioPlayer newPlayer) {
    player = newPlayer;
    refreshTotalAudioDuration();
  }

  void refreshTotalAudioDuration() async {
    Duration? tempDuration = await player.getDuration();
    if (tempDuration != null) {
      totalAudioDuration = tempDuration.inSeconds;
      totalAudioDurationString =
          durationRegex.stringMatch(tempDuration.toString()) ?? "";
    } else {
      totalAudioDuration = 0;
    }
  }

  @override
  FutureOr<void> onLoad() {
    texteCompo.position = Vector2((screenWidth * 90 / 100) / 2, 7.5);
    add(RectangleComponent(
      anchor: Anchor.topLeft,
      position: Vector2(0, 0),
      size: Vector2(screenWidth * 90 / 100, screenHeight * 2 / 100),
      paint: Paint()..color = Color(0xff1d4b4d),
    ));
    add(currentPositionRetangle);
    add(texteCompo);
  }

  @override
  void update(double dt) async {
    super.update(dt);
    timeCount += dt;
    if (this.isAttached == true) {
      if (timeCount >= printSpeed) {
        Duration? duration = await player.getCurrentPosition();
        if (duration != null) {
          texteCompo.text =
              (durationRegex.stringMatch(duration.toString()) ?? "") +
                  " / " +
                  totalAudioDurationString;

          currentPositionRetangle.size = Vector2(
              ((screenWidth * 90 / 100) / totalAudioDuration) *
                  duration.inSeconds,
              screenHeight * 2 / 100);
        } else {
          print("DURATION NULL !");
        }
        timeCount = 0;
      }
    } else {
      removeFromParent();
    }
  }
}
