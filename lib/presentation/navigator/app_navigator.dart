import 'package:amplified_todos/data/cubit/auth_cubit.dart';
import 'package:amplified_todos/data/cubit/todo_cubit.dart';
import 'package:amplified_todos/presentation/screens/auth_screen.dart';
import 'package:amplified_todos/presentation/screens/todo_screen.dart';
import 'package:amplified_todos/presentation/widgets/todo_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppNavigator extends StatelessWidget {
  const AppNavigator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return Navigator(
          pages: [
            if (state is Unauthenticated)
              const MaterialPage(
                child: AuthScreen(),
              ),
            if (state is Authenticated)
              MaterialPage(
                child: BlocProvider(
                  create: (context) => TodoCubit(userId: state.userId)
                    ..getTodos()
                    ..observeTodo(),
                  child: const TodosScreen(),
                ),
              ),
            if (state is UnknownAuthState)
              const MaterialPage(
                child: LoadingView(),
              ),
          ],
          onPopPage: (route, result) => route.didPop(result),
        );
      },
    );
  }
}
