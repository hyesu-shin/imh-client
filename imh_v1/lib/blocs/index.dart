import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import 'object_bloc/object_bloc.dart';
import '../models/object_model.dart';

import 'record_bloc/record_bloc.dart';
import '../models/record_model.dart';

class BlocProviders {
  static MultiBlocProvider getProviders({required Widget child}) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ObjectBloc>(
          create: (context) {
            // Ensure that you pass a properly initialized Box to the Bloc
            final objectsBox = Hive.box<ObjectModel>('objects_box');
            return ObjectBloc(objectsBox);
          }
        ),
        BlocProvider<RecordBloc>(
          create: (context) {
            final recordsBox = Hive.box<RecordModel>('records_box');
            return RecordBloc(recordsBox);
          }
        ),
      ],
      child: child,
    );
  }
}