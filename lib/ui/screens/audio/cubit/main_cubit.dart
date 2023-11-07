import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thomas/ui/screens/audio/cubit/main_state.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit() : super(MainInitial());

  AudioPlayer player = AudioPlayer();

  Future<void> loadAudioFiles() async {
    player = AudioPlayer();
    AssetSource test = AssetSource("test.mp3");
    await player.setSource(test);

    emit(MainAudioLoaded(player: player));
  }

  Future<void> changeAudio() async {
    player = AudioPlayer();
    AssetSource test = AssetSource("test.mp3");
    await player.setSource(test);

    emit(MainAudioLoaded(player: player));
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
