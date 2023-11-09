import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

abstract class MainState {
  AudioPlayer? player;
  List<String> audioFileName;
  int audioSelected;
  MainState(
      {this.player = null,
      this.audioFileName = const [],
      this.audioSelected = -1});
}

class MainInitial extends MainState {
  MainInitial();
}

class MainAudioLoaded extends MainState {
  MainAudioLoaded({
    required super.player,
    required super.audioSelected,
  });
}

class MainAudioChangeSource extends MainState {
  MainAudioChangeSource({
    required super.player,
    required super.audioSelected,
  });
}

class AudioListFileNameChange extends MainState {
  AudioListFileNameChange({required super.audioFileName});
}

class MainAudioChangePlayerState extends MainState {
  MainAudioChangePlayerState();
}
