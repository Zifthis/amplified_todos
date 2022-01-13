
import 'package:amplified_todos/data/models/Todo.dart';
import 'package:amplify_flutter/amplify.dart';

class TodoRepository {
  Future<List<Todo>> getTodos(String userId) async {
    try {
      final todos = await Amplify.DataStore.query(
        Todo.classType,
        where: Todo.USERID.eq(userId),
      );
      return todos;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> createTodo(
      String title, String description, String userId) async {
    final newTodo = Todo(
        name: title,
        description: description.isNotEmpty ? description : null,
        userID: userId,
        isComplete: false);
    try {
      await Amplify.DataStore.save(newTodo);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateTodosIsComplete(Todo todo, bool isComplete) async {
    final updatedTodo = todo.copyWith(isComplete: isComplete);
    try {
      await Amplify.DataStore.save(updatedTodo);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteTodo(Todo todo) async {
    try {
      await Amplify.DataStore.delete(todo);
    } catch (e) {
      rethrow;
    }
  }

  Stream observeTodos() {
    return Amplify.DataStore.observe(Todo.classType);
  }
}
