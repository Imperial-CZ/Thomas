import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thomas/ui/component/header.dart';
import 'package:thomas/ui/component/nav_button.dart';
import 'package:thomas/ui/screens/audio/main_screen.dart';
import 'package:thomas/ui/screens/test/cubit/video_cubit.dart';
import 'package:thomas/ui/screens/test/cubit/video_state.dart';

class VideoScreen extends StatelessWidget {
  final cubit = VideoCubit();
  List<String> audioList = [];

  @override
  Widget build(BuildContext context) {
    AudioPlayer player = AudioPlayer();
    ScrollController scrollController = ScrollController();
    bool _isPlaying = false;
    bool _isPaused = false;
    bool _isAudioInPlayer = false;
    Duration? _position;
    int idAudioInPlayer = 0;

    return BlocBuilder<VideoCubit, VideoState>(
      bloc: cubit,
      builder: (context, state) {
        if (state is VideoInitial) {
          cubit.loadAudioFiles();
        }

        if (state is VideoLoaded) {
          print("CHANGING PLAYER ... MAINLOAD");
          player = state.player!;
          audioList = state.audioFileName;
          _isAudioInPlayer = true;
        }

        if (state is VideoChangeSource) {
          print("CHANGING PLAYER ...");
          player = state.player!;
          _isAudioInPlayer = true;
          idAudioInPlayer = state.audioSelected;
        }

        return Scaffold(
          backgroundColor: Color(0xffece1cd),
          body: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Header(),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 3 / 100),
                        child: Container(
                          color: Color(0xff583f2d),
                          child: Row(
                            children: [
                              NavButton(
                                text: "Audios",
                                buttonColor: Colors.transparent,
                                onClickFunction: () {
                                  Navigator.pushReplacement(
                                      context,
                                      PageRouteBuilder(
                                        pageBuilder: (context, animation,
                                                secondaryAnimation) =>
                                            MainScreen(),
                                        transitionsBuilder: (context, animation,
                                            secondaryAnimation, child) {
                                          return child;
                                        },
                                      ));
                                },
                                borderRadius: null,
                              ),
                              NavButton(
                                text: "Vidéos",
                                buttonColor: Color(0xffaa7338),
                                onClickFunction: null,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20),
                                ),
                              ),
                              NavButton(
                                text: "Textes",
                                buttonColor: Colors.transparent,
                                onClickFunction: null,
                                borderRadius: null,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
