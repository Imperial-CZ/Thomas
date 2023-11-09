import 'dart:async';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:thomas/ui/screens/audio/cubit/main_cubit.dart';

class GameManager extends FlameGame {
  MainCubit cubit;
  AudioPlayer player;
  int totalAudioDuration = 0;
  double screenWidth;
  double screenHeight;
  double timeCount = 0;
  double printSpeed = 0.5;
  TextComponent texteCompo = TextComponent(text: "");

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
    } else {
      totalAudioDuration = 0;
    }
  }

  @override
  FutureOr<void> onLoad() {
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
          texteCompo.text = duration.inSeconds.toString() +
              " / " +
              totalAudioDuration.toString();
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
