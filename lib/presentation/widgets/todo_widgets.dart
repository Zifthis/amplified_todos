import 'package:amplified_todos/data/cubit/todo_cubit.dart';
import 'package:amplified_todos/data/models/Todo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ErrorView extends StatelessWidget {
  const ErrorView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

class EmptyTodosView extends StatelessWidget {
  const EmptyTodosView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('No todos yet'),
    );
  }
}

class TodosListView extends StatelessWidget {
  final List<Todo> todos;

  const TodosListView({Key? key, required this.todos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: todos.length,
      itemBuilder: (context, index) {
        final todo = todos[index];
        return Card(
          child: CheckboxListTile(
            title: Text(
              todo.name.toString(),
            ),
            subtitle: Text(
              todo.description.toString(),
            ),
            secondary: IconButton(
              icon: const Icon(
                Icons.close,
                color: Colors.red,
              ),
              onPressed: () {
                BlocProvider.of<TodoCubit>(context).deleteTodos(todo);
              },
            ),
            value: todo.isComplete,
            onChanged: (newValue) {
              BlocProvider.of<TodoCubit>(context)
                  .updateTodosIsComplete(todo, newValue!);
            },
          ),
        );
      },
    );
  }
}

class LoadingView extends StatelessWidget {
  const LoadingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
