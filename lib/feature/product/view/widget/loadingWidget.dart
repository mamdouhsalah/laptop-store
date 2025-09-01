import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:state_mangement/core/manger/cubit/style_cubit.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.read<ThemeCubit>().state;

    return Center(child: CircularProgressIndicator(color: theme.buttonColor));
  }
}
