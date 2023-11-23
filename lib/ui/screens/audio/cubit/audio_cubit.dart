import 'dart:convert';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thomas/ui/screens/audio/cubit/audio_state.dart';

class AudioCubit extends Cubit<AudioState> {
  AudioCubit() : super(AudioInitial());

  List<String> fileNames = [];

  Future<void> init() async {
    await loadAudioFiles();

    AudioPlayer player = AudioPlayer();
    AssetSource newSource = AssetSource(fileNames[0]);
    await player.setSource(newSource);

    emit(AudioLoaded(player: player, audioSelected: 0));
  }

  Future<void> loadAudioFiles() async {
    List<String> tempFileNames = [];

    final manifestContent = await rootBundle.loadString('AssetManifest.json');
    final Map<String, dynamic> manifestMap = json.decode(manifestContent);
    // >> To get paths you need these 2 lines

    List<String> filePath = manifestMap.keys
        .where((String key) => key.contains('assets/'))
        .where((String key) => key.contains('.mp3'))
        .toList();

    RegExp fileRegex = RegExp("([a-z]|[A-Z]|[0-9]| |')+\.mp3");
    for (String element in filePath) {
      String? regexRes = fileRegex.stringMatch(element);
      if (regexRes != null) {
        tempFileNames.add(regexRes);
      }
    }

    fileNames = tempFileNames;

    emit(AudioListFileNameChange(audioFileName: fileNames));
  }

  Future<void> changeAudio(int audioSelected) async {
    await loadAudioFiles();

    AudioPlayer player = AudioPlayer();
    AssetSource newSource = AssetSource(fileNames[audioSelected]);
    await player.setSource(newSource);

    emit(AudioChangeSource(player: player, audioSelected: audioSelected));
  }

  Future<Duration?> getCurrentAudioTime(AudioPlayer inputAudioPlayer) async {
    return await inputAudioPlayer.getCurrentPosition();
  }

  @override
  void onChange(Change<AudioState> change) {
    // TODO: implement onChange
    super.onChange(change);
    print(change);
  }
}
