import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thomas/ui/screens/audio/audio_screen.dart';
import 'package:thomas/ui/screens/home/cubit/home_cubit.dart';
import 'package:thomas/ui/screens/home/cubit/home_state.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = HomeCubit();

    return BlocBuilder<HomeCubit, HomeState>(
      bloc: cubit,
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Color(0xffece1cd),
          body: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height * 10 / 100,
                    top: MediaQuery.of(context).size.height * 20 / 100,
                    right: MediaQuery.of(context).size.width * 3 / 100,
                  ),
                  child: Image.asset(
                      'lib/ui/component/images/logo_with_title.png'),
                ),
                TextButton(
                  style: ButtonStyle(
                    overlayColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                        return Colors.transparent;
                      },
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => AudioScreen()),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color(0xffaa7338),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Container(
                      margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 2 / 100,
                        bottom: MediaQuery.of(context).size.height * 2 / 100,
                        right: MediaQuery.of(context).size.width * 4 / 100,
                        left: MediaQuery.of(context).size.width * 4 / 100,
                      ),
                      child: Ink(
                        decoration: BoxDecoration(color: Colors.transparent),
                        child: Text(
                          "Commencer l'aventure",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
