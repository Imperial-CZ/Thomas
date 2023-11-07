import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thomas/ui/screens/audio/cubit/main_cubit.dart';
import 'package:thomas/ui/screens/audio/cubit/main_state.dart';

class MainScreen extends StatelessWidget {
  final cubit = MainCubit();

  @override
  Widget build(BuildContext context) {
    AudioPlayer player = AudioPlayer();
    bool _isPlaying = false;
    bool _isPaused = false;
    Duration? _position;

    return BlocProvider(
      create: (context) => MainCubit()..loadAudioFiles(),
      child: BlocBuilder<MainCubit, MainState>(
        builder: (context, state) {
          if (state is MainInitial) {
            BlocProvider.of<MainCubit>(context).loadAudioFiles();
          }

          if (state.player != null) {
            player = state.player!;
          }

          return Scaffold(
            backgroundColor: Color(0xffece1cd),
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
                              top:
                                  MediaQuery.of(context).size.height * 3 / 100),
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
                                          side: MaterialStateProperty
                                              .resolveWith<BorderSide>(
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
                                            BlocProvider.of<MainCubit>(context)
                                                .loadAudioFiles();
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
                                          side: MaterialStateProperty
                                              .resolveWith<BorderSide>(
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
                                          side: MaterialStateProperty
                                              .resolveWith<BorderSide>(
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
                              onPressed: _isPlaying
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
                                      BlocProvider.of<MainCubit>(context)
                                          .emit(MainAudioChangePlayerState());
                                    },
                              iconSize: 48.0,
                              icon: const Icon(Icons.play_arrow),
                              color: Colors.blue,
                            ),
                            IconButton(
                              onPressed: _isPlaying
                                  ? () async {
                                      await player.pause();
                                      _isPlaying = false;
                                      _isPaused = true;
                                      BlocProvider.of<MainCubit>(context)
                                          .emit(MainAudioChangePlayerState());
                                    }
                                  : null,
                              iconSize: 48.0,
                              icon: const Icon(Icons.pause),
                              color: Colors.blue,
                            ),
                            IconButton(
                              onPressed: _isPlaying || _isPaused
                                  ? () async {
                                      await player.stop();
                                      _position = Duration.zero;
                                      _isPlaying = false;
                                      _isPaused = false;
                                      BlocProvider.of<MainCubit>(context)
                                          .emit(MainAudioChangePlayerState());
                                    }
                                  : null,
                              iconSize: 48.0,
                              icon: const Icon(Icons.stop),
                              color: Colors.blue,
                            ),
                          ],
                        ),
                        TextButton(
                          onPressed: () async {
                            await cubit.changeAudio();
                          },
                          child: Text("TEST"),
                        ),
                        TextButton(
                          onPressed: () async {
                            await player.stop();
                          },
                          child: Text("TEST"),
                        ),
                        // ListView.builder(
                        //   itemCount: state.listViewContent.length,
                        //   itemBuilder: (context, index) {},
                        // )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
