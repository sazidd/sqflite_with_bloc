import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflit/bloc/sqflit_bloc.dart';
import 'package:sqflit/screens/add_new.dart';

import 'db/student_provider.dart';

void main() {
  runApp(BlocProvider(
    create: (_) => SqflitBloc(studentProvider: StudentProvider()),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AddNew(
        edit: false,
      ),
    );
  }
}
