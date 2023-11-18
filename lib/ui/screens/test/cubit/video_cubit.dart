import 'dart:convert';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thomas/ui/screens/test/cubit/video_state.dart';
import 'package:video_player/video_player.dart';

class VideoCubit extends Cubit<VideoState> {
  VideoCubit() : super(VideoInitial());

  List<String> fileNames = [];

  Future<void> loadVideoFiles(String? videoName, Duration? currentVideoTimer,
      int? currentVideoId) async {
    final manifestContent = await rootBundle.loadString('AssetManifest.json');
    final Map<String, dynamic> manifestMap = json.decode(manifestContent);

    List<String> filePath = manifestMap.keys
        .where((String key) => key.contains('assets/'))
        .where((String key) => key.contains('.mp4'))
        .toList();

    RegExp fileRegex = RegExp("([a-z]|[A-Z]|[0-9]| )+\.mp4");
    for (String element in filePath) {
      String? regexRes = fileRegex.stringMatch(element);
      if (regexRes != null) {
        fileNames.add(fileRegex.stringMatch(element)!);
      }
    }

    VideoPlayerController _controller;

    if (videoName != null &&
        currentVideoTimer != null &&
        currentVideoId != null) {
      _controller = await VideoPlayerController.asset(videoName);
      await _controller.initialize();
      await _controller.seekTo(currentVideoTimer);
    } else {
      _controller = await VideoPlayerController.asset("assets/" + fileNames[0]);
      await _controller.initialize();
    }

    emit(VideoLoaded(
        playerController: _controller,
        videoFileName: fileNames,
        videoSelected: 0));
  }

  Future<void> changeAudio(int videoSelected) async {
    VideoPlayerController _controller =
        VideoPlayerController.asset(fileNames[videoSelected])..initialize();

    emit(VideoChangeSource(
        playerController: _controller, videoSelected: videoSelected));
  }

  @override
  void onChange(Change<VideoState> change) {
    super.onChange(change);
    print(change);
  }
}
