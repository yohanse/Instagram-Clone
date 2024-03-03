import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/features/auth/presentation/bloc/check_username/check_username_bloc.dart';
import '../widgets/username_field.dart';

// ignore: must_be_immutable
class UserNamePage extends StatelessWidget {
  UserNamePage({super.key});
  TextEditingController nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CheckUsernameBloc, CheckUsernameState>(
      listener: (context, state) {
        if 
      },
      builder: (context, state) {

      },
    );
  }
}
