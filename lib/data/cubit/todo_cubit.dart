
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:amplified_todos/data/models/Todo.dart';
import 'package:amplified_todos/data/repository/todo_repository.dart';


part 'todo_state.dart';

class TodoCubit extends Cubit<TodoState> {
  final _todoRepo = TodoRepository();
  final String userId;

  TodoCubit({required this.userId}) : super(LoadingTodos());

  void getTodos() async {
    if (state is ListTodosSuccess == false) {
      emit(LoadingTodos());
    }
    try {
      final todos = await _todoRepo.getTodos(userId);
      emit(ListTodosSuccess(todo: todos));
    } catch (e) {
      emit(ListTodosFailure(e.toString()));
    }
  }

  void observeTodo() {
    final todosStream = _todoRepo.observeTodos();
    todosStream.listen((_) => getTodos());
  }

  void createTodo(String title, String description) async {
    await _todoRepo.createTodo(title, description, userId);
  }

  void updateTodosIsComplete(Todo todo, bool isComplete) async {
    await _todoRepo.updateTodosIsComplete(todo, isComplete);
  }

  void deleteTodos(Todo todo) async {
    await _todoRepo.deleteTodo(todo);
  }
}
