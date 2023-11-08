import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

abstract class MainState {
  AudioPlayer? player;
  List<String> audioFileName;
  MainState({this.player = null, this.audioFileName = const []});
}

class MainInitial extends MainState {
  MainInitial();
}

class MainAudioLoaded extends MainState {
  MainAudioLoaded({required super.player, required super.audioFileName});
}

class MainAudioChangeSource extends MainState {
  MainAudioChangeSource({required super.player});
}

class MainAudioChangePlayerState extends MainState{
  MainAudioChangePlayerState();
}

class MainVideoLoaded extends MainState {
  MainVideoLoaded();
}

class MainTextLoaded extends MainState {
  MainTextLoaded();
}
