import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thomas/ui/component/header.dart';
import 'package:thomas/ui/component/nav_button.dart';
import 'package:thomas/ui/component/video_overlay.dart';
import 'package:thomas/ui/screens/audio/audio_screen.dart';
import 'package:thomas/ui/screens/video/cubit/video_cubit.dart';
import 'package:thomas/ui/screens/video/cubit/video_state.dart';
import 'package:video_player/video_player.dart';
import 'package:flame/flame.dart';

class VideoScreen extends StatelessWidget {
  final cubit = VideoCubit();
  List<String> videoList = [];
  String? videoName;
  Duration? currentVideoTimer;
  int? currentVideoId;
  bool isLandscaped = false;

  VideoScreen({this.videoName, this.currentVideoTimer, this.currentVideoId});

  @override
  Widget build(BuildContext context) {
    ScrollController scrollController = ScrollController();
    VideoPlayerController _controller =
        VideoPlayerController.asset("assets/wide.mp4")..initialize();
    VideoPlayer player = VideoPlayer(_controller);
    Duration? _position;
    int idVideoInPlayer = 0;
    RegExp fileRegex = RegExp("([a-z]|[A-Z]|[0-9]| )+");

    return BlocBuilder<VideoCubit, VideoState>(
      bloc: cubit,
      builder: (context, state) {
        if (state is VideoInitial) {
          cubit.loadVideoFiles(videoName, currentVideoTimer, currentVideoId);
        }

        if (state is VideoUpdateScreenOrientationState) {
          isLandscaped = state.isLandscaped;
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

        if (isLandscaped == false) {
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
                              top:
                                  MediaQuery.of(context).size.height * 3 / 100),
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
                                              AudioScreen(),
                                          transitionsBuilder: (context,
                                              animation,
                                              secondaryAnimation,
                                              child) {
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
                        Expanded(
                          child: ListView(
                            shrinkWrap: true,
                            controller: scrollController,
                            children: [
                              for (int i = 0; i < videoList.length; i++)
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
                                      color: i == idVideoInPlayer
                                          ? Color(0xffaa7338)
                                          : Color(0xff583f2d),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                    ),
                                    child: ListTile(
                                      leading: Image.asset(
                                        "assets/chien.png",
                                        height: 50,
                                        width: 50,
                                      ),
                                      title: Text(
                                        fileRegex.stringMatch(videoList[i]) ??
                                            "ERREUR LECTURE TITRE",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                        ),
                                      ),
                                      subtitle: Text(
                                        "Autor : Imagine Dragon's",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                        ),
                                      ),
                                      onTap: () async {
                                        player.controller.pause();
                                        await cubit.changeVideo(i);
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
        } else {
          return Scaffold(
            backgroundColor: Color(0xffece1cd),
            body: Center(
              child: Container(
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
            ),
          );
        }
      },
    );
  }
}
