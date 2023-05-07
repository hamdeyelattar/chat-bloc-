import 'package:chat_app1/pages/blocs/auth_bloc/auth_bloc.dart';
import 'package:chat_app1/pages/chat_page.dart';
import 'package:chat_app1/pages/cubits/auth_cubit/auth_cubit.dart';
import 'package:chat_app1/pages/cubits/chat_cubit/chat_cubit.dart';
import 'package:chat_app1/pages/login_page.dart';
import 'package:chat_app1/pages/register_page.dart';
import 'package:chat_app1/simple_bloc_observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  BlocOverrides.runZoned(
    () {
      runApp(const ScholorChat());
    },
    blocObserver: SimpleBlocObserver(),
  );
}

class ScholorChat extends StatelessWidget {
  const ScholorChat({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit()),
        BlocProvider(create: (context) => ChatCubit()),
        BlocProvider(create: (context) => AuthBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          LoginPage.id: (context) => LoginPage(),
          RegisterPage.id: (context) => RegisterPage(),
          ChatPage.id: (context) => ChatPage(),
        },
        initialRoute: LoginPage.id,
      ),
    );
  }
}
