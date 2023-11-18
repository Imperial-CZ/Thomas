import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thomas/ui/component/header.dart';
import 'package:thomas/ui/component/nav_button.dart';
import 'package:thomas/ui/component/video_overlay.dart';
import 'package:thomas/ui/screens/audio/main_screen.dart';
import 'package:thomas/ui/screens/test/cubit/video_cubit.dart';
import 'package:thomas/ui/screens/test/cubit/video_state.dart';
import 'package:video_player/video_player.dart';
import 'package:flame/flame.dart';

class VideoScreen extends StatelessWidget {
  final cubit = VideoCubit();
  List<String> videoList = [];
  String? videoName;
  Duration? currentVideoTimer;
  int? currentVideoId;

  VideoScreen({this.videoName, this.currentVideoTimer, this.currentVideoId});

  @override
  Widget build(BuildContext context) {
    ScrollController scrollController = ScrollController();
    VideoPlayerController _controller =
        VideoPlayerController.asset("assets/wide.mp4")..initialize();
    Duration? _position;
    int idVideoInPlayer = 0;

    return BlocBuilder<VideoCubit, VideoState>(
      bloc: cubit,
      builder: (context, state) {
        if (state is VideoInitial) {
          cubit.loadVideoFiles(videoName, currentVideoTimer, currentVideoId);
        }

        if (state is VideoLoaded) {
          print("CHANGING PLAYER ... MAINLOAD");
          _controller = state.playerController!;
          videoList = state.videoFileName;
        }

        if (state is VideoChangeSource) {
          print("CHANGING PLAYER ...");
          _controller = state.playerController!;
          idVideoInPlayer = state.videoSelected;
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
                                onClickFunction: () async {
                                  await _controller.pause();
                                  await Navigator.pushReplacement(
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
                                  await _controller.dispose();
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
                      Container(
                        child: _controller.value.isInitialized
                            ? AspectRatio(
                                aspectRatio: _controller.value.aspectRatio,
                                child: Stack(
                                  alignment: Alignment.bottomCenter,
                                  children: <Widget>[
                                    VideoPlayer(_controller),
                                    VideoOverlay(
                                      controller: _controller,
                                      cubit: cubit,
                                    ),
                                    VideoProgressIndicator(_controller,
                                        allowScrubbing: true),
                                  ],
                                ),
                              )
                            : Container(),
                      ),
                      TextButton(
                        onPressed: () async {
                          Flame.device
                              .setOrientation(DeviceOrientation.landscapeLeft);
                          await _controller.pause();
                          String videoName = videoList[idVideoInPlayer];
                          Duration currentVideoTimer =
                              await _controller.position ??
                                  Duration(seconds: 0);
                          await Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        VideoLandscapeScreen(
                                  videoName:
                                      "assets/" + videoList[idVideoInPlayer],
                                  currentVideoTimer: currentVideoTimer,
                                  currentVideoId: idVideoInPlayer,
                                ),
                                transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) {
                                  return child;
                                },
                              ));
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * 90 / 100,
                          decoration: BoxDecoration(
                            color: Color(0xffaa7338),
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                          padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 1 / 100,
                            bottom:
                                MediaQuery.of(context).size.height * 1 / 100,
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            "Fullscreen",
                            style: TextStyle(
                              color: Colors.white,
                            ),
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

class VideoLandscapeScreen extends StatelessWidget {
  final cubit = VideoLandscapeCubit();

  String videoName;
  Duration currentVideoTimer;
  int currentVideoId;

  VideoLandscapeScreen({
    required this.videoName,
    required this.currentVideoTimer,
    required this.currentVideoId,
  });

  @override
  Widget build(BuildContext context) {
    VideoPlayerController playerController =
        VideoPlayerController.asset("assets/wide.mp4");

    return BlocBuilder<VideoLandscapeCubit, VideoLandscapeState>(
      bloc: cubit,
      builder: (context, state) {
        if (state is VideoLandscapeInitial) {
          cubit.loadVideo(videoName, currentVideoTimer);
        }

        if (state is VideoLandscapeLoaded) {
          playerController = state.playerController!;
        }

        return Scaffold(
          body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Color(0xffece1cd),
            child: playerController.value.isInitialized
                ? Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(
                            right: MediaQuery.of(context).size.width * 1 / 100,
                            left: MediaQuery.of(context).size.width * 1 / 100,
                          ),
                          child: AspectRatio(
                            aspectRatio: playerController.value.aspectRatio,
                            child: Stack(
                              alignment: Alignment.bottomCenter,
                              children: <Widget>[
                                VideoPlayer(playerController),
                                VideoOverlay(
                                  controller: playerController,
                                  cubit: cubit,
                                ),
                                VideoProgressIndicator(playerController,
                                    allowScrubbing: true),
                              ],
                            ),
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () async {
                          await playerController.pause();
                          Flame.device
                              .setOrientation(DeviceOrientation.portraitUp);
                          Duration? currentVideoTimer =
                              await playerController.position;
                          await Navigator.pushReplacement(
                              context,
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        VideoScreen(
                                  videoName: videoName,
                                  currentVideoTimer: currentVideoTimer,
                                  currentVideoId: currentVideoId,
                                ),
                                transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) {
                                  return child;
                                },
                              ));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            color: Color(0xffaa7338),
                          ),
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "Exit Fullscreen",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  )
                : Container(),
          ),
        );
      },
    );
  }
}

class VideoLandscapeCubit extends Cubit<VideoLandscapeState> {
  VideoLandscapeCubit() : super(VideoLandscapeInitial());

  void loadVideo(String path, Duration timeCode) async {
    VideoPlayerController _controller = await VideoPlayerController.asset(path);
    await _controller.initialize();
    await _controller.seekTo(timeCode);

    emit(VideoLandscapeLoaded(playerController: _controller));
  }
}

abstract class VideoLandscapeState {
  VideoPlayerController? playerController;

  VideoLandscapeState({this.playerController});
}

class VideoLandscapeInitial extends VideoLandscapeState {
  VideoLandscapeInitial();
}

class VideoLandscapeLoaded extends VideoLandscapeState {
  VideoLandscapeLoaded({required super.playerController});
}

class VideoLandscapeChangePlayerState extends VideoLandscapeState {
  VideoLandscapeChangePlayerState();
}
