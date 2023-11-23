import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

abstract class VideoState {
  VideoPlayerController? playerController;
  List<String> videoFileName;
  int videoSelected;
  bool isLandscaped;
  VideoState({
    this.playerController = null,
    this.videoFileName = const [],
    this.videoSelected = -1,
    this.isLandscaped = false,
  });
}

class VideoInitial extends VideoState {
  VideoInitial();
}

class VideoLoaded extends VideoState {
  VideoLoaded({
    required super.playerController,
    required super.videoFileName,
    required super.videoSelected,
  });
}

class VideoChangeSource extends VideoState {
  VideoChangeSource({
    required super.playerController,
    required super.videoSelected,
  });
}

class VideoChangePlayerState extends VideoState {
  VideoChangePlayerState();
}

class VideoUpdateScreenOrientationState extends VideoState {
  VideoUpdateScreenOrientationState({required super.isLandscaped});
}
