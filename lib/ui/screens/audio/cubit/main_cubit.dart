import 'dart:convert';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thomas/ui/screens/audio/cubit/main_state.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit() : super(MainInitial());

  Future<void> loadAudioFiles() async {
    List<String> fileNames = [];
    
    final manifestContent = await rootBundle.loadString('AssetManifest.json');
    final Map<String, dynamic> manifestMap = json.decode(manifestContent);
    // >> To get paths you need these 2 lines

    List<String> filePath = manifestMap.keys
        .where((String key) => key.contains('assets/'))
        .where((String key) => key.contains('.mp3'))
        .toList();

    RegExp fileRegex = RegExp("([a-z]|[A-Z]|[0-9])+\.mp3");
    for(String element in filePath){
      String? regexRes = fileRegex.stringMatch(element);
      if(regexRes != null){
        fileNames.add(fileRegex.stringMatch(element)!);
      }
    }

    AudioPlayer player = AudioPlayer();
    AssetSource newSource = AssetSource(fileNames[0]);
    await player.setSource(newSource);

    emit(MainAudioLoaded(player: player, audioFileName: fileNames));
  }

  Future<void> changeAudio() async {
    AudioPlayer player = AudioPlayer();
    AssetSource newSource = AssetSource("test2.mp3");
    await player.setSource(newSource);

    emit(MainAudioChangeSource(player: player));
  }

  void loadVideoFiles() {
    List<String> filesNames;

    emit(MainVideoLoaded());
  }

  void loadTextFiles() {
    List<String> filesNames;

    emit(MainTextLoaded());
  }

  @override
  void onChange(Change<MainState> change) {
    // TODO: implement onChange
    super.onChange(change);
    print(change);
  }
}
