import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/features/common/post/domain/entities/post_entitie.dart';
import 'package:mobile/features/common/presentation/bloc/post/post_bloc.dart';

import '../widget/SinglePostWidget.dart';

class ListPostPage extends StatelessWidget {
  const ListPostPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        profileImageUrl:
            "http://127.0.0.1:8000/media/profile/images/profile.webp",
      ),
      body: Container(
        color: Colors.black,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              BlocConsumer<PostBloc, PostState>(
                  builder: (context, state) {
                    print("State ----->");
                    print(state);
                    if (state is PostError) {
                      return Text(state.message);
                    } else if (state is PostLoading) {
                      return Text("Loading ......");
                    } else if (state is PostLoaded) {
                      return SingleChildScrollView(
                        child: Column(
                          children: displayPosts(state.post),
                        ),
                      );
                    }
                    BlocProvider.of<PostBloc>(context).add(
                      GetAllPostsEvent(),
                    );
                    return Text("Loading ......");
                  },
                  listener: (context, state) {}),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> displayPosts(List<PostEntite> posts) {
    final List<Widget> result = [];
    for (int i = 0; i < posts.length; i++) {
      result.add(SignlePostWidget(
        numberOfComment: posts[i].comments!.length,
        numberOfLike: posts[i].numberOfLike!,
        time: posts[i].created_at!,
        text: posts[i].text,
        imageUrl: posts[i].images[1],
        authName: posts[i].author!.name,
        profileImageUrl: posts[i].author!.profile_image,
      ));
      result.add(SizedBox(
        height: 20,
      ));
    }
    return result;
  }
}

class BottomNavigationBar extends StatelessWidget {
  final String profileImageUrl;
  const BottomNavigationBar({super.key, required this.profileImageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            Icons.home,
            color: Colors.white,
          ),
          Icon(
            Icons.search,
            color: Colors.white,
          ),
          Icon(
            Icons.add_circle_outline,
            color: Colors.white,
          ),
          Icon(
            Icons.video_collection_outlined,
            color: Colors.white,
          ),
          CircleAvatar(
            backgroundImage: NetworkImage(profileImageUrl),
            radius: 12,
          ),
        ],
      ),
    );
  }
}
