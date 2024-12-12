import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'object_bloc/object_bloc.dart';

class BlocProviders {
  static MultiBlocProvider getProviders({required Widget child}) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ObjectBloc>(
          create: (context) => ObjectBloc(),
        ),
      ],
      child: child,
    );
  }
}