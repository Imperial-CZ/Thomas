import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thomas/ui/screens/audio/cubit/audio_cubit.dart';
import 'package:thomas/ui/screens/audio/cubit/audio_state.dart';

class AudioScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cubit = AudioCubit();

    return BlocBuilder<AudioCubit, AudioState>(
      bloc: cubit,
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Color(0xff1d4b4d),
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
                      color: Colors.white,
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
                      color: Colors.white,
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
                            "Je suis là pour t'accompagner tout au long de ta visite et te fournir des fun-fact, des détails ... bref des informations supplémentaire pour mieux comprendre les oeuvres que tu regardes !",
                            style: TextStyle(
                              color: Colors.white,
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
                          color: Color(0xff583f2d),
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Color(0xffaa7338),
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(10),
                                          bottomRight: Radius.circular(10))),
                                  child: Container(
                                    margin: EdgeInsets.only(
                                      top: MediaQuery.of(context).size.height *
                                          1 /
                                          100,
                                      bottom:
                                          MediaQuery.of(context).size.height *
                                              1 /
                                              100,
                                    ),
                                    child: Ink(
                                      decoration: BoxDecoration(
                                          color: Colors.transparent),
                                      child: Text(
                                        "Audios",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  child: Container(
                                    margin: EdgeInsets.only(
                                      top: MediaQuery.of(context).size.height *
                                          1 /
                                          100,
                                      bottom:
                                          MediaQuery.of(context).size.height *
                                              1 /
                                              100,
                                    ),
                                    child: Ink(
                                      decoration: BoxDecoration(
                                          color: Colors.transparent),
                                      child: Text(
                                        "Vidéos",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  child: Container(
                                    margin: EdgeInsets.only(
                                      top: MediaQuery.of(context).size.height *
                                          1 /
                                          100,
                                      bottom:
                                          MediaQuery.of(context).size.height *
                                              1 /
                                              100,
                                    ),
                                    child: Ink(
                                      decoration: BoxDecoration(
                                          color: Colors.transparent),
                                      child: Text(
                                        "Textes",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          Container(
                            color: Colors.red,
                            child: Text("data"),
                          ),
                          Text("data"),
                          Text("data"),
                          Text("data"),
                          Text("data"),
                          Text("data"),
                          Text("data"),
                          Text("data"),
                          Text("data"),
                          Text("data"),
                        ],
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
