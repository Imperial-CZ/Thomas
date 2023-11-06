import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
          body: SizedBox(height: 10),
        );
      },
    );
  }
}
