part of 'sqflit_bloc.dart';

abstract class SqflitState extends Equatable {
  const SqflitState();

  @override
  List<Object> get props => [];
}

class SqflitInitial extends SqflitState {
  const SqflitInitial();

  @override
  List<Object> get props => [];
}

class SqflitLoading extends SqflitState {
  const SqflitLoading();

  @override
  List<Object> get props => [];
}

class SqflitLoaded extends SqflitState {
  final List<Student> student;

  const SqflitLoaded({this.student});

  @override
  List<Object> get props => [student];
}

class SqflitError extends SqflitState {
  final String errorMessage;

  const SqflitError({this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
