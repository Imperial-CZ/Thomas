import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thomas/ui/screens/audio/cubit/main_cubit.dart';
import 'package:thomas/ui/screens/audio/cubit/main_state.dart';

class MainScreen extends StatelessWidget {
  final cubit = MainCubit();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MainCubit()..testEmit(),
      child: BlocBuilder<MainCubit, MainState>(
        builder: (context, state) {
          print("REBUILD : " + state.toString());
          if (state is MainInitial) {
            print("EMIT");
            cubit.testEmit();
          }
          if (state is MainAudioLoaded) {
            print("TEST");
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
                              "Je suis là pour t'accompagner tout au long de ta visite et te fournir des fun-fact, des détails ... bref des informations supplémentaire pour mieux comprendre les oeuvres que tu regardes !",
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
                                          BlocProvider.of<MainCubit>(context);
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
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    MainScreen()),
                                          );
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
                                        color: state is MainTexteLoaded
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
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    MainScreen()),
                                          );
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
                        ListView.builder(
                          itemCount: state.listViewContent.length,
                          itemBuilder: (context, index) {},
                        )
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
