import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sqflit/db/student_provider.dart';
import 'package:sqflit/models/student.dart';

part 'sqflit_event.dart';
part 'sqflit_state.dart';

class SqflitBloc extends Bloc<SqflitEvent, SqflitState> {
  final StudentProvider studentProvider;
  List<Student> st;

  SqflitBloc({this.studentProvider}) : super(SqflitInitial());

  @override
  Stream<SqflitState> mapEventToState(
    SqflitEvent event,
  ) async* {
    // yield SqflitLoading();
    if (event is GetStudentList) {
      yield SqflitLoading();
      try {
        final student = await studentProvider.getStudentList();
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
      try {
        final student = await studentProvider.updateStudent(event.student);
        print('update------------------------- ${student}');
        yield SqflitLoaded(student: student);
        yield SqflitLoading();
      } catch (e) {
        yield SqflitError(errorMessage: e.toString());
      }
    } else if (event is DeleteStudent) {
      final id = await studentProvider.deleteStudent(event.student.id);
      if (id == 1) {
        st = await studentProvider.getStudentList();
        yield SqflitLoaded(student: st);
      }
      // try {
      //   final student = await studentProvider.deleteStudent(event.student);
      //   List<Student> students = [];

      //   // students.where((st) => st.id == student.id);

      //   // students.firstWhere((st) => st.id == student.id, orElse: () => null);
      //   print('delete------------------------- ${student}');
      //   yield SqflitLoaded(student: students);
      // } catch (e) {
      //   yield SqflitError(errorMessage: e.toString());
      // }
    }
  }
}
