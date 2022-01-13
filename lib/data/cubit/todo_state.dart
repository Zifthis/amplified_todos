part of 'todo_cubit.dart';

@immutable
abstract class TodoState {}

class LoadingTodos extends TodoState {}

class ListTodosSuccess extends TodoState {
  final List<Todo> todo;

  ListTodosSuccess({required this.todo});
}

class ListTodosFailure extends TodoState {
  final String exception;

  ListTodosFailure(this.exception);

  List<Object> get props => [exception];

  @override
  String toString() => 'SearchStateError { error: $exception }';
}
