import 'package:flutter/material.dart';

abstract class MainState {
  List<Widget> listViewContent;
  MainState({this.listViewContent = const []});
}

class MainInitial extends MainState {
  MainInitial();
}

class MainAudioLoaded extends MainState {
  MainAudioLoaded();
}

class MainVideoLoaded extends MainState {
  MainVideoLoaded();
}

class MainTexteLoaded extends MainState {
  MainTexteLoaded();
}
