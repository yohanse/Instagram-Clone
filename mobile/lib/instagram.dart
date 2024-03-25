import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/features/auth/presentation/bloc/check_email/check_email_bloc.dart';
import 'package:mobile/features/auth/presentation/bloc/check_confirmation/check_confirmation_bloc.dart';
import 'package:mobile/features/auth/presentation/bloc/check_username/check_username_bloc.dart';
import 'package:mobile/features/auth/presentation/bloc/login/login_bloc.dart';
import 'package:mobile/features/auth/presentation/pages/Finally.dart';
import 'package:mobile/features/auth/presentation/pages/birth_date.dart';
import 'package:mobile/features/auth/presentation/pages/create_password.dart';
import 'package:mobile/features/auth/presentation/pages/finalConfirmation.dart';
import 'package:mobile/features/auth/presentation/pages/name.dart';
import 'package:mobile/injection.dart';

import 'features/auth/presentation/bloc/signup/singup_bloc.dart';
import 'features/auth/presentation/pages/code.dart';
import 'features/auth/presentation/pages/email.dart';
import 'features/auth/presentation/pages/login.dart';
import 'features/auth/presentation/pages/username.dart';

class InstagramApp extends StatelessWidget {
  const InstagramApp({super.key});

  @override
  Widget build(BuildContext context) {
    final GoRouter _router = GoRouter(
      navigatorKey: GlobalKey<NavigatorState>(),
      routes: [
        // GoRoute(
        //   path: '/',
        //   builder: (context, state) => LoginPage(),
        // ),
        GoRoute(
          path: '/signup',
          builder: (context, state) => EmailPage(),
        ),
        GoRoute(
          path: '/signup/confirmation',
          builder: (context, state) => CodePage(
            email: state.extra! as String,
          ),
        ),
        GoRoute(
          path: '/signup/confirmation/password',
          builder: (context, state) => CreatePasswordPage(
            email:  state.extra! as String,
          ),
        ),
        GoRoute(
          path: '/signup/confirmation/password/birthday',
          builder: (context, state) => BirthDatePage(
            extra: state.extra! as ExtraPassword,
          ),
        ),
        GoRoute(
          path: '/signup/confirmation/password/birthday/name',
          builder: (context, state) => NamePage(
            extra: state.extra! as ExtraBirthDate,
          ),
        ),
        GoRoute(
          path: "/signup/confirmation/password/birthday/name/username",
          builder: (context, state) => UserNamePage(
            extra: state.extra! as ExtraName,
          ),
        ),
        GoRoute(
          path: "/signup/confirmation/password/birthday/name/username/finalConfirmation",
          builder: (context, state) => FinalConfirmationPage(
            extra: state.extra! as ExtraUserName,
          ),
        ),
        GoRoute(
          path: '/',
          builder: (context, state) => const Finally(),
        ),
      ],
    );
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<CheckEmailBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<CheckConfirmationBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<CheckUsernameBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<SingupBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<LoginBloc>(),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: _router,
      ),
    );
  }
}
