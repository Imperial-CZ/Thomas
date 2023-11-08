import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thomas/ui/screens/audio/cubit/main_cubit.dart';
import 'package:thomas/ui/screens/audio/cubit/main_state.dart';

class MainScreen extends StatelessWidget {
  final cubit = MainCubit();
  List<String> audioList = [];

  @override
  Widget build(BuildContext context) {
    AudioPlayer player = AudioPlayer();
    bool _isPlaying = false;
    bool _isPaused = false;
    bool _isAudioInPlayer = false;
    Duration? _position;

    return BlocBuilder<MainCubit, MainState>(
      bloc: cubit,
      builder: (context, state) {
        if (state is MainInitial) {
          cubit.loadAudioFiles();
        }

        if (state is MainAudioLoaded) {
          print("CHANGING PLAYER ... MAINLOAD");
          player = state.player!;
          audioList = state.audioFileName;
          _isAudioInPlayer = true;
        }

        if (state is MainAudioChangeSource) {
          print("CHANGING PLAYER ...");
          player = state.player!;
          _isAudioInPlayer = true;
        }

        return Scaffold(
          backgroundColor:
              state is MainAudioChangeSource ? Color(0xffece1cd) : Colors.red,
          body: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 3 / 100,
                    left: MediaQuery.of(context).size.width * 10 / 100,
                  ),
                  child: Text(
                    "THOMAS",
                    style: TextStyle(
                      color: Color(0xff1d4b4d),
                      fontWeight: FontWeight.bold,
                      fontSize: 48,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 18 / 100,
                  ),
                  child: Text(
                    "The history of minorities in America",
                    style: TextStyle(
                      color: Color(0xff1d4b4d),
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 4 / 100,
                    left: MediaQuery.of(context).size.width * 2 / 100,
                    right: MediaQuery.of(context).size.width * 2 / 100,
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        'lib/ui/component/images/logo_without_title.png',
                        scale: 2,
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 4 / 100,
                          ),
                          child: Text(
                            "Je suis là pour t'accompagner tout au long de ta visite et te fournir des fun-fact, des détails ... bref des informations supplémentaires pour mieux comprendre les oeuvres que tu regardes !",
                            style: TextStyle(
                              color: Color(0xff1d4b4d),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  color: Colors.transparent,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 3 / 100),
                        child: Container(
                          color: Colors.transparent,
                          child: Row(
                            children: [
                              Expanded(
                                child: Ink(
                                  color: Color(0xff583f2d),
                                  padding: EdgeInsets.all(0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: state is MainAudioLoaded
                                          ? Color(0xffaa7338)
                                          : Colors.transparent,
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(20),
                                        bottomRight: Radius.circular(20),
                                      ),
                                    ),
                                    child: TextButton(
                                      style: ButtonStyle(
                                        overlayColor: MaterialStateProperty
                                            .resolveWith<Color>(
                                          (Set<MaterialState> states) {
                                            return Colors.transparent;
                                          },
                                        ),
                                        padding: MaterialStateProperty
                                            .resolveWith<EdgeInsetsGeometry>(
                                          (Set<MaterialState> states) {
                                            return EdgeInsets.only(
                                              top: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  1 /
                                                  100,
                                              bottom: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  1 /
                                                  100,
                                            );
                                          },
                                        ),
                                        backgroundColor: MaterialStateProperty
                                            .resolveWith<Color>(
                                          (Set<MaterialState> states) {
                                            return Colors.transparent;
                                          },
                                        ),
                                        side: MaterialStateProperty.resolveWith<
                                            BorderSide>(
                                          (Set<MaterialState> states) {
                                            return BorderSide(
                                              width: 0,
                                              color: Colors.transparent,
                                            );
                                          },
                                        ),
                                        tapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                      ),
                                      onPressed: () {
                                        if (state is! MainAudioLoaded) {
                                          cubit.loadAudioFiles();
                                        }
                                      },
                                      child: Text(
                                        "Audios",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Ink(
                                  color: Color(0xff583f2d),
                                  padding: EdgeInsets.all(0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: state is MainVideoLoaded
                                          ? Color(0xffaa7338)
                                          : Colors.transparent,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(20),
                                      ),
                                    ),
                                    child: TextButton(
                                      style: ButtonStyle(
                                        overlayColor: MaterialStateProperty
                                            .resolveWith<Color>(
                                          (Set<MaterialState> states) {
                                            return Colors.transparent;
                                          },
                                        ),
                                        padding: MaterialStateProperty
                                            .resolveWith<EdgeInsetsGeometry>(
                                          (Set<MaterialState> states) {
                                            return EdgeInsets.only(
                                              top: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  1 /
                                                  100,
                                              bottom: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  1 /
                                                  100,
                                            );
                                          },
                                        ),
                                        backgroundColor: MaterialStateProperty
                                            .resolveWith<Color>(
                                          (Set<MaterialState> states) {
                                            return Colors.transparent;
                                          },
                                        ),
                                        side: MaterialStateProperty.resolveWith<
                                            BorderSide>(
                                          (Set<MaterialState> states) {
                                            return BorderSide(
                                              width: 0,
                                              color: Colors.transparent,
                                            );
                                          },
                                        ),
                                        tapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                      ),
                                      onPressed: () {
                                        if (state is! MainVideoLoaded) {
                                          BlocProvider.of<MainCubit>(context)
                                              .emit(MainVideoLoaded());
                                        }
                                      },
                                      child: Text(
                                        "Vidéos",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Ink(
                                  color: Color(0xff583f2d),
                                  padding: EdgeInsets.all(0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: state is MainTextLoaded
                                          ? Color(0xffaa7338)
                                          : Colors.transparent,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        bottomLeft: Radius.circular(20),
                                      ),
                                    ),
                                    child: TextButton(
                                      style: ButtonStyle(
                                        overlayColor: MaterialStateProperty
                                            .resolveWith<Color>(
                                          (Set<MaterialState> states) {
                                            return Colors.transparent;
                                          },
                                        ),
                                        padding: MaterialStateProperty
                                            .resolveWith<EdgeInsetsGeometry>(
                                          (Set<MaterialState> states) {
                                            return EdgeInsets.only(
                                              top: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  1 /
                                                  100,
                                              bottom: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  1 /
                                                  100,
                                            );
                                          },
                                        ),
                                        backgroundColor: MaterialStateProperty
                                            .resolveWith<Color>(
                                          (Set<MaterialState> states) {
                                            return Colors.transparent;
                                          },
                                        ),
                                        side: MaterialStateProperty.resolveWith<
                                            BorderSide>(
                                          (Set<MaterialState> states) {
                                            return BorderSide(
                                              width: 0,
                                              color: Colors.transparent,
                                            );
                                          },
                                        ),
                                        tapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                      ),
                                      onPressed: () {
                                        if (state is! MainTextLoaded) {
                                          BlocProvider.of<MainCubit>(context)
                                              .emit(MainTextLoaded());
                                        }
                                      },
                                      child: Text(
                                        "Textes",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
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
                            color: Color(0xff1d4b4d),
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
                            color: Color(0xff1d4b4d),
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
                                  }
                                : null,
                            iconSize: 48.0,
                            icon: const Icon(Icons.stop),
                            color: Color(0xff1d4b4d),
                          ),
                        ],
                      ),
                      ListView.builder(
                        itemCount: audioList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            width:
                                MediaQuery.of(context).size.height * 10 / 100,
                            child: Text("TEMP"),
                          );
                        },
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
