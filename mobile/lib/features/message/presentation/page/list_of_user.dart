import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/features/message/presentation/bloc/list%20users/list_users_bloc.dart';

import 'message_with_user.dart';

class ListUsersPage extends StatelessWidget {
  const ListUsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ListUsersBloc>(context).add(GetUsersEvent());
    return Scaffold(
      backgroundColor: Colors.black,
      body:
          BlocBuilder<ListUsersBloc, ListUsersState>(builder: (context, state) {
        if (state is ListUsersLoadedState) {
          return ListView.builder(
            itemCount: state.users.length,
            itemBuilder: (context, index) => GestureDetector(
              onTap: () => context.go('/chat', extra: UserParams(
                id: "${state.users[index].user_id}",
                name: state.users[index].name,
                profile_image: state.users[index].profile_image,
              ),),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage:
                      NetworkImage(state.users[index].profile_image),
                  radius: 35,
                ),
                title: Text(
                  state.users[index].name,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
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
