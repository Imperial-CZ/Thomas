import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

abstract class AudioState {
  AudioPlayer? player;
  List<String> audioFileName;
  int audioSelected;
  AudioState(
      {this.player = null,
      this.audioFileName = const [],
      this.audioSelected = -1});
}

class AudioInitial extends AudioState {
  AudioInitial();
}

class AudioLoaded extends AudioState {
  AudioLoaded({
    required super.player,
    required super.audioSelected,
  });
}

class AudioChangeSource extends AudioState {
  AudioChangeSource({
    required super.player,
    required super.audioSelected,
  });
}

class AudioListFileNameChange extends AudioState {
  AudioListFileNameChange({required super.audioFileName});
}

class AudioChangePlayerState extends AudioState {
  AudioChangePlayerState();
}
