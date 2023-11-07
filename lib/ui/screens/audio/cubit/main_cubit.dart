import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thomas/ui/screens/audio/cubit/main_state.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit() : super(MainInitial());

  void testEmit() {
    print("FONCTION");
    emit(MainAudioLoaded());
  }

  void loadAudioFiles() {
    List<String> filesNames;
  }

  @override
  void onChange(Change<MainState> change) {
    // TODO: implement onChange
    super.onChange(change);
    print(change);
  }
}
