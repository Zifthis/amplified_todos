import 'package:amplified_todos/data/cubit/auth_cubit.dart';
import 'package:amplified_todos/data/cubit/todo_cubit.dart';
import 'package:amplified_todos/presentation/widgets/todo_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodosScreen extends StatefulWidget {
  const TodosScreen({Key? key}) : super(key: key);

  @override
  _TodosScreenState createState() => _TodosScreenState();
}

class _TodosScreenState extends State<TodosScreen> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.logout),
          onPressed: () => BlocProvider.of<AuthCubit>(context).signOut(),
        ),
        title: const Text('My Todo List'),
      ),
      floatingActionButton: _floatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: BlocBuilder<TodoCubit, TodoState>(
        builder: (context, state) {
          if (state is ListTodosSuccess) {
            return state.todo.isEmpty
                ? const EmptyTodosView()
                : TodosListView(todos: state.todo);
          } else if (state is ListTodosFailure) {
            return const ErrorView();
          } else {
            return const LoadingView();
          }
        },
      ),
    );
  }

  Widget _floatingActionButton() {
    return FloatingActionButton.extended(
      onPressed: () {
        showModalBottomSheet(
            context: context, builder: (context) => _newTodoView());
      },
      tooltip: 'Add Todo',
      label: Row(
        children: const [Icon(Icons.add), Text('Add todo')],
      ),
    );
  }

  Widget _newTodoView() {
    return Column(
      children: [
        TextFormField(
          controller: _nameController,
          decoration: const InputDecoration(filled: true, labelText: 'Name'),
        ),
        TextFormField(
          controller: _descriptionController,
          decoration:
              const InputDecoration(filled: true, labelText: 'Description'),
        ),
        ElevatedButton(
            onPressed: () {
              BlocProvider.of<TodoCubit>(context).createTodo(
                  _nameController.text, _descriptionController.text);
              _nameController.text = '';
              Navigator.of(context).pop();
            },
            child: const Text('Save Todo'))
      ],
    );
  }
}
