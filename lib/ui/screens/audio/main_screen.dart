import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thomas/ui/component/game_manager.dart';
import 'package:thomas/ui/component/header.dart';
import 'package:thomas/ui/component/nav_button.dart';
import 'package:thomas/ui/screens/audio/cubit/main_cubit.dart';
import 'package:thomas/ui/screens/audio/cubit/main_state.dart';
import 'package:thomas/ui/screens/test/video_screen.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';

class MainScreen extends StatelessWidget {
  final cubit = MainCubit();
  List<String> audioList = [];
  RegExp fileRegex = RegExp("([a-z]|[A-Z]|[0-9]| )+");

  @override
  Widget build(BuildContext context) {
    AudioPlayer player = AudioPlayer();
    GameManager gm = GameManager(
        cubit: cubit,
        player: player,
        screenWidth: MediaQuery.of(context).size.width,
        screenHeight: MediaQuery.of(context).size.height);
    ScrollController scrollController = ScrollController();
    bool _isPlaying = false;
    bool _isPaused = false;
    bool _isAudioInPlayer = false;
    Duration? _position;
    int idAudioInPlayer = 0;

    return BlocBuilder<MainCubit, MainState>(
      bloc: cubit,
      builder: (context, state) {
        if (state is MainInitial) {
          cubit.init();
        }

        if (state is AudioListFileNameChange) {
          audioList = state.audioFileName;
        }

        if (state is MainAudioLoaded) {
          print("CHANGING PLAYER ... MAINLOAD");
          player = state.player!;
          gm.audioChange(player);
          _isAudioInPlayer = true;
        }

        if (state is MainAudioChangeSource) {
          print("CHANGING PLAYER ...");
          player = state.player!;
          gm.audioChange(player);
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
                      Container(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 3 / 100),
                        color: Colors.transparent,
                        child: Row(
                          children: [
                            NavButton(
                              text: "Audios",
                              buttonColor: Color(0xffaa7338),
                              onClickFunction: () {},
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(20),
                                bottomRight: Radius.circular(20),
                              ),
                            ),
                            NavButton(
                              text: "Vidéos",
                              buttonColor: Color(0xff583f2d),
                              onClickFunction: () {
                                gm.detach();
                                player.dispose();
                                Navigator.pushReplacement(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder: (context, animation,
                                              secondaryAnimation) =>
                                          VideoScreen(),
                                      transitionsBuilder: (context, animation,
                                          secondaryAnimation, child) {
                                        return child;
                                      },
                                    ));
                              },
                              borderRadius: null,
                            ),
                            NavButton(
                              text: "Audios",
                              buttonColor: Color(0xff583f2d),
                              onClickFunction: () {},
                              borderRadius: null,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 10 / 100,
                        child: GameWidget(
                          game: gm,
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: _isPlaying || (!_isAudioInPlayer)
                                ? null
                                : () async {
                                    final position = _position;
                                    if (position != null &&
                                        position.inMilliseconds > 0) {
                                      await player.seek(position);
                                    }
                                    await player.resume();
                                    _isPlaying = true;
                                    _isPaused = false;
                                    cubit.emit(MainAudioChangePlayerState());
                                  },
                            iconSize: 48.0,
                            icon: const Icon(Icons.play_arrow),
                            color: Color(0xffaa7338),
                            disabledColor: Color(0xff583f2d),
                          ),
                          IconButton(
                            onPressed: _isPlaying
                                ? () async {
                                    await player.pause();
                                    _isPlaying = false;
                                    _isPaused = true;
                                    cubit.emit(MainAudioChangePlayerState());
                                  }
                                : null,
                            iconSize: 48.0,
                            icon: const Icon(Icons.pause),
                            color: Color(0xffaa7338),
                            disabledColor: Color.fromARGB(255, 62, 45, 32),
                          ),
                          IconButton(
                            onPressed: _isPlaying || _isPaused
                                ? () async {
                                    await player.stop();
                                    _position = Duration.zero;
                                    _isPlaying = false;
                                    _isPaused = false;
                                    _isAudioInPlayer = false;
                                    cubit.emit(MainAudioChangePlayerState());
                                    cubit.changeAudio(idAudioInPlayer);
                                  }
                                : null,
                            iconSize: 48.0,
                            icon: const Icon(Icons.stop),
                            color: Color(0xffaa7338),
                            disabledColor: Color.fromARGB(255, 62, 45, 32),
                          ),
                        ],
                      ),
                      Expanded(
                        child: ListView(
                          shrinkWrap: true,
                          controller: scrollController,
                          children: [
                            for (int i = 0; i < audioList.length; i++)
                              Padding(
                                padding: EdgeInsets.only(
                                  top: MediaQuery.of(context).size.height *
                                      1 /
                                      100,
                                  bottom: MediaQuery.of(context).size.height *
                                      1 /
                                      100,
                                  right: MediaQuery.of(context).size.width *
                                      4 /
                                      100,
                                  left: MediaQuery.of(context).size.width *
                                      4 /
                                      100,
                                ),
                                child: Container(
                                  width: MediaQuery.of(context).size.width *
                                      10 /
                                      100,
                                  decoration: BoxDecoration(
                                    color: i == idAudioInPlayer
                                        ? Color(0xffaa7338)
                                        : Color(0xff583f2d),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                  child: TextButton(
                                    child: Text(
                                        fileRegex.stringMatch(audioList[i]) ??
                                            "ERREUR LECTURE TITRE"),
                                    onPressed: () async {
                                      if (_isPlaying || _isPaused) {
                                        await player.stop();
                                        _position = Duration.zero;
                                        _isPlaying = false;
                                        _isPaused = false;
                                        _isAudioInPlayer = false;
                                        cubit
                                            .emit(MainAudioChangePlayerState());
                                      }
                                      cubit.changeAudio(i);
                                    },
                                  ),
                                ),
                              ),
                          ],
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
