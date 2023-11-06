import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thomas/ui/screens/audio/cubit/audio_state.dart';

class AudioCubit extends Cubit<AudioState> {
  AudioCubit() : super(AudioInitial());
}
