import 'package:amplified_todos/data/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: const Text('Sign in'),
          onPressed: () => BlocProvider.of<AuthCubit>(context).signIn(),
        ),
      ),
    );
  }
}
