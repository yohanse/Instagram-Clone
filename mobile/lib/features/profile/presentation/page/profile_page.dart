import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/features/profile/presentation/bloc/profile/profile_bloc.dart';
import 'package:mobile/features/profile/presentation/widget/custom_score.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoadedState) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                state.name,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
              actions: [
                Icon(
                  Icons.menu_book_rounded,
                  color: Colors.white,
                ),
              ],
              backgroundColor: Colors.black,
            ),
            body: Container(
              color: Colors.black,
              child: Column(
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image(
                          image: NetworkImage(
                            state.profileImage,
                          ),
                        ),
                        CustomScore(score: "2", field: "posts"),
                        CustomScore(score: "2", field: "posts"),
                        CustomScore(score: "2", field: "posts"),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        }
        return Scaffold(
          body: Center(
            child: Text("Loading"),
          ),
        );
      },
    );
  }
}
