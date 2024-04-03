import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/features/profile/presentation/bloc/profile/profile_bloc.dart';
import 'package:mobile/features/profile/presentation/widget/custom_score.dart';
import 'package:mobile/features/profile/presentation/widget/custom_user_dispaly.dart';

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
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            child: Text("Edit profile"),
                            onPressed: () {},
                          ),
                        ),
                        Expanded(
                          child: ElevatedButton(
                            child: Text("Share profile"),
                            onPressed: () {},
                          ),
                        ),
                        Expanded(
                          child: IconButton(
                            icon: Icon(Icons.person_2_rounded),
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      leading: Text("Discover people"),
                      trailing: Text("Discover people"),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return CustomUserDisplay(
                            image: state.profileImage, name: "Yohanse");
                      },
                    ),
                  ),
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
