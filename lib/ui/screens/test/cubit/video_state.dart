import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

abstract class VideoState {
  AudioPlayer? player;
  List<String> audioFileName;
  int audioSelected;
  VideoState(
      {this.player = null,
      this.audioFileName = const [],
      this.audioSelected = -1});
}

class VideoInitial extends VideoState {
  VideoInitial();
}

class VideoLoaded extends VideoState {
  VideoLoaded({
    required super.player,
    required super.audioFileName,
    required super.audioSelected,
  });
}

class VideoChangeSource extends VideoState {
  VideoChangeSource({
    required super.player,
    required super.audioSelected,
  });
}

class VideoChangePlayerState extends VideoState {
  VideoChangePlayerState();
}
