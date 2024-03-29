import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/features/common/post/domain/entities/post_entitie.dart';
import 'package:mobile/features/common/presentation/bloc/post/post_bloc.dart';

class ListOfPost extends StatelessWidget {
  const ListOfPost({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
                return Text("Wait ......");
              },
              listener: (context, state) {}),
          ElevatedButton(
            onPressed: () {
              print("Clicked");
              BlocProvider.of<PostBloc>(context).add(
                GetAllPostsEvent(),
              );
            },
            child: Text("List!"),
          )
        ],
      ),
    );
  }

  List<Widget> displayPosts(List<PostEntite> posts) {
    final List<Widget> result = [];
    for (int i = 0; i < posts.length; i++) {
      result.add(MyWidget(post: posts[i]));
    }
    return result;
  }
}

class MyWidget extends StatelessWidget {
  final PostEntite post;
  const MyWidget({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Text(post.text);
  }
}
