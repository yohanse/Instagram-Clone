import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/features/common/post/domain/entities/post_entitie.dart';
import 'package:mobile/features/common/presentation/bloc/post/post_bloc.dart';

import '../widget/SinglePostWidget.dart';

class ListPostPage extends StatelessWidget {
  const ListPostPage({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<PostBloc>(context).add(
      GetAllPostsEvent(),
    );
    return Scaffold(
      bottomNavigationBar: CustomBottomNavigationBar(
        profileImageUrl:
            "http://192.168.43.57:8000/media/profile/images/profile.webp",
      ),
      body: Container(
        color: Colors.black,
        child: BlocConsumer<PostBloc, PostState>(
            builder: (context, state) {
              if (state is PostError) {
                return Text(state.message);
              } else if (state is PostLoading) {
                return Text("Loading ......");
              } else if (state is PostLoaded) {
                return ListView.builder(
                    itemCount: state.post.length,
                    itemBuilder: (BuildContext context, int i) {
                      return SignlePostWidget(
                        numberOfComment: state.post[i].comments!.length,
                        numberOfLike: state.post[i].numberOfLike!,
                        time: state.post[i].created_at!,
                        text: state.post[i].text,
                        imageUrl: state.post[i].images[0],
                        authName: state.post[i].author!.name,
                        profileImageUrl: state.post[i].author!.profile_image,
                      );
                    });
              }
              return Text("Loading ......");
            },
            listener: (context, state) {}),
      ),
    );
  }
}

class CustomBottomNavigationBar extends StatelessWidget {
  final String profileImageUrl;
  const CustomBottomNavigationBar({super.key, required this.profileImageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {
              context.go("/posts");
            },
            icon: Icon(
              Icons.home,
              color: Colors.white,
              size: 30,
            ),
          ),
          Icon(
            Icons.search,
            color: Colors.white,
            size: 30,
          ),
          IconButton(
            icon: Icon(
              Icons.add_circle_outline,
              size: 40,
            ),
            color: Colors.white,
            onPressed: () {
              context.go("/pickImage");
            },
          ),
          Icon(
            Icons.video_collection_outlined,
            color: Colors.white,
            size: 30,
          ),
          GestureDetector(
            onTap: () {
              context.go("/");
            },
            child: CircleAvatar(
              backgroundImage: NetworkImage(profileImageUrl),
              radius: 15,
            ),
          ),
        ],
      ),
    );
  }
}
