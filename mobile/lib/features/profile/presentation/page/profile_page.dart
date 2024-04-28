import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/features/profile/presentation/bloc/profile/profile_bloc.dart';
import 'package:mobile/features/profile/presentation/widget/custom_posts_profile_widget.dart';
import 'package:mobile/features/profile/presentation/widget/custom_score.dart';
import 'package:mobile/features/profile/presentation/widget/custom_user_dispaly.dart';

import '../../../common/presentation/page/ListPostPage.dart';
import '../widget/custom_bottom_bar_navigation.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ProfileBloc>(context).add(GetProfileDetailEvent());
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoadedState) {
          return Scaffold(
            bottomNavigationBar: CustomBottomNavigationBar(),
            appBar: AppBar(
              title: Text(
                state.name,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w700),
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
                    flex: 18,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 40,
                            child: Image(
                              image: NetworkImage(
                                state.profileImage,
                              ),
                            ),
                          ),
                          CustomScore(score: "2", field: "posts"),
                          CustomScore(score: "2", field: "followers"),
                          CustomScore(score: "2", field: "following"),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          flex: 4,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      8), // Set desired radius
                                ),
                              ),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                Color.fromARGB(50, 255, 255, 255),
                              ),
                            ),
                            child: Text(
                              "Edit profile",
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {},
                          ),
                        ),
                        SizedBox(
                          width: 6,
                        ),
                        Expanded(
                          flex: 4,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      8), // Set desired radius
                                ),
                              ),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                Color.fromARGB(50, 255, 255, 255),
                              ),
                            ),
                            child: Text(
                              "Share profile",
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {},
                          ),
                        ),
                        SizedBox(
                          width: 6,
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color.fromARGB(50, 255, 255, 255),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: IconButton(
                              color: Colors.white,
                              icon: Icon(
                                Icons.person_2_rounded,
                              ),
                              onPressed: () {},
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: ListTile(
                      leading: Text("Discover people"),
                      trailing: TextButton(
                        child: Text(
                          "See All",
                          style: TextStyle(
                            color: Colors.blue,
                          ),
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 21,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.separated(
                        separatorBuilder: (context, index) =>
                            SizedBox(width: 10.0),
                        scrollDirection: Axis.horizontal,
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return CustomUserDisplay(
                              image: state.profileImage, name: "Yohanse");
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 10,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    width: 1.0,
                                    style: BorderStyle.solid,
                                  ),
                                ),
                                child: IconButton(
                                  icon: Icon(
                                    Icons.add,
                                    size: 45,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {},
                                ),
                              ),
                              Text(
                                "New",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 49,
                    child: DefaultTabController(
                      length: 2,
                      child: Column(
                        children: [
                          TabBar(
                            indicator: BoxDecoration(
                              border: null,
                            ), // Remove the underline
                            labelColor: Colors.white,
                            tabAlignment: TabAlignment.center,
                            indicatorColor: Colors.white,
                            tabs: [
                              Tab(
                                icon: Icon(Icons.grid_4x4),
                              ),
                              Tab(
                                icon: Icon(Icons.person),
                              ),
                            ],
                          ),

                          Expanded(
                            child: TabBarView(
                              children: [
                                GridView.builder(
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      mainAxisSpacing: 2,
                                      crossAxisSpacing: 2,
                                    ),
                                    itemCount: 10,
                                    itemBuilder: (context, index) {
                                      return CutsomPostsProfileWidget(
                                          imageUrl: state.profileImage);
                                    }),
                                Container(color: Colors.blue)
                              ],
                            ),
                          ),
                          // Row(children: [Icon(Icons.grid_4x4), Icons()],)
                        ],
                      ),
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
