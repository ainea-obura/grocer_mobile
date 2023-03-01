import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocerygo/pages/landing.dart';
import 'package:grocerygo/repository/login_repository.dart';
import 'package:grocerygo/repository/sign_up_repository.dart';

import 'modules/login/login_cubit.dart';
import 'modules/signup/sign_up_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginCubit(LoginRepository()),
        ),
        BlocProvider(
          create: (context) => SignUpCubit(SignUpRepository()),
        ),
      ],
      child: const MaterialApp(
        home: Landing(),
      ),
    );
  }

  // This widget is the root of your application.
  // @override
  // Widget build(BuildContext context) {
  //   return BlocProvider(create: (context)=> LoginCubit(LoginRepository()),
  //     child: const MaterialApp(
  //       home:  Landing(),
  //     ),
  //   );
  // }
}
