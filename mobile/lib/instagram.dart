import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:mobile/features/auth/presentation/pages/code.dart';
import 'package:mobile/features/auth/presentation/pages/email.dart';
import 'package:mobile/injection.dart';

class InstagramApp extends StatelessWidget {
  const InstagramApp({super.key});

  @override
  Widget build(BuildContext context) {
    final GoRouter _router = GoRouter(
      navigatorKey: GlobalKey<NavigatorState>(),
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => EmailPage(),
        ),
        GoRoute(
          path: '/confirmation',
          builder: (context, state) => CodePage(
            email: state.extra! as String,
          ),
        ),
      ],
    );
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<AuthBloc>(),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: _router,
      ),
    );
  }
}
