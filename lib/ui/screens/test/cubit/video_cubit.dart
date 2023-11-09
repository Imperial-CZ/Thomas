import 'dart:convert';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thomas/ui/screens/test/cubit/video_state.dart';

class VideoCubit extends Cubit<VideoState> {
  VideoCubit() : super(VideoInitial());

  List<String> fileNames = [];

  Future<void> loadAudioFiles() async {
    final manifestContent = await rootBundle.loadString('AssetManifest.json');
    final Map<String, dynamic> manifestMap = json.decode(manifestContent);
    // >> To get paths you need these 2 lines

    List<String> filePath = manifestMap.keys
        .where((String key) => key.contains('assets/'))
        .where((String key) => key.contains('.mp3'))
        .toList();

    RegExp fileRegex = RegExp("([a-z]|[A-Z]|[0-9]| )+\.mp3");
    for (String element in filePath) {
      String? regexRes = fileRegex.stringMatch(element);
      if (regexRes != null) {
        fileNames.add(fileRegex.stringMatch(element)!);
      }
    }

    AudioPlayer player = AudioPlayer();
    AssetSource newSource = AssetSource(fileNames[0]);
    await player.setSource(newSource);

    emit(VideoLoaded(
        player: player, audioFileName: fileNames, audioSelected: 0));
  }

  Future<void> changeAudio(int audioSelected) async {
    AudioPlayer player = AudioPlayer();
    AssetSource newSource = AssetSource(fileNames[audioSelected]);
    await player.setSource(newSource);

    emit(VideoChangeSource(player: player, audioSelected: audioSelected));
  }

  @override
  void onChange(Change<VideoState> change) {
    // TODO: implement onChange
    super.onChange(change);
    print(change);
  }
}
