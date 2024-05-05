import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/features/message/presentation/bloc/list%20users/list_users_bloc.dart';

class ListUsers extends StatelessWidget {
  const ListUsers({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body:
          BlocBuilder<ListUsersBloc, ListUsersState>(builder: (context, state) {
        if (state is ListUsersLoadedState) {
          return ListView.builder(
            itemBuilder: (context, index) => ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(state.users[index].profile_image),
              ),
              title: Text(
                state.users[index].name,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          );
        }
        return Center(
          child: Text(
            "Loading.....",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        );
      }),
    );
  }
}
