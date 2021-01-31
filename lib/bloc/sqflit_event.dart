part of 'sqflit_bloc.dart';

abstract class SqflitEvent {
  const SqflitEvent();

  @override
  List<Object> get props => [];
}

class GetStudentList extends SqflitEvent {
  const GetStudentList();

  @override
  List<Object> get props => [];
}

class InsertStudent extends SqflitEvent {
  final Student student;

  const InsertStudent({this.student});

  @override
  List<Object> get props => [student];
}

class UpdateStudent extends SqflitEvent {
  final Student student;

  const UpdateStudent({this.student});

  @override
  List<Object> get props => [student];
}

class DeleteStudent extends SqflitEvent {
  final Student student;

  const DeleteStudent({this.student});

  @override
  List<Object> get props => [student];
}

class SearchStudent extends SqflitEvent {
  final String query;

  const SearchStudent({this.query});

  @override
  List<Object> get props => [query];
}
