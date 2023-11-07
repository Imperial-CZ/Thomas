import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

abstract class MainState {
  AudioPlayer? player;
  MainState({this.player = null});
}

class MainInitial extends MainState {
  MainInitial();
}

class MainAudioLoaded extends MainState {
  MainAudioLoaded({required super.player});
}

class MainAudioChangePlayerState extends MainState {
  MainAudioChangePlayerState();
}

class MainVideoLoaded extends MainState {
  MainVideoLoaded();
}

class MainTextLoaded extends MainState {
  MainTextLoaded();
}
