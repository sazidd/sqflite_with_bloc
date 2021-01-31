import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:sqflit/db/student_provider.dart';
import 'package:sqflit/models/student.dart';

part 'sqflit_event.dart';
part 'sqflit_state.dart';

class SqflitBloc extends Bloc<SqflitEvent, SqflitState> {
  final StudentProvider studentProvider;
  List<Student> student = [];
  List<Student> studentUpdate = [];

  SqflitBloc({this.studentProvider}) : super(SqflitInitial());

  @override
  Stream<SqflitState> mapEventToState(SqflitEvent event) async* {
    if (event is GetStudentList) {
      yield SqflitLoading();
      try {
        student = await studentProvider.getStudentList();
        print('getstudent------------------------- $student');
        yield student != null
            ? SqflitLoaded(student: student)
            : SqflitError(errorMessage: 'Something went wrong');
      } catch (e) {
        yield SqflitError(errorMessage: e.toString());
      }
    } else if (event is InsertStudent) {
      try {
        final student = await studentProvider.insertStudent(event.student);
        print('insert------------------------- ${student}');
        yield SqflitLoaded(student: student);
        yield SqflitLoading();
      } catch (e) {
        yield SqflitError(errorMessage: e.toString());
      }
    } else if (event is UpdateStudent) {
      studentUpdate = [];
      try {
        studentUpdate = await studentProvider.updateStudent(event.student);
        print('update------------------------- ${student}');
        yield SqflitLoading();
        yield SqflitLoaded(student: studentUpdate);
      } catch (e) {
        yield SqflitError(errorMessage: e.toString());
      }
    } else if (event is DeleteStudent) {
      final id = await studentProvider.deleteStudent(event.student.id);
      if (id == 1) {
        studentUpdate = [];
        studentUpdate = await studentProvider.getStudentList();
        yield SqflitLoaded(student: studentUpdate);
      }
    } else if (event is SearchStudent) {
      print('Query----------- ${event.query}');
      var dummyListData = List<Student>();
      student.forEach((stud) {
        var st2 = Student(id: stud.id, name: stud.name);
        print('st2-------------------------- ${st2.name}');
        if (st2.name.toLowerCase().contains(event.query.toLowerCase())) {
          dummyListData.add(stud);
        }
      });

      yield SqflitLoaded(student: dummyListData);
    }
  }
}
