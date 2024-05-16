import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/features/common/presentation/bloc/post/post_bloc.dart';

import '../../../profile/presentation/widget/custom_bottom_bar_navigation.dart';
import '../widget/SinglePostWidget.dart';

class ListPostPage extends StatelessWidget {
  const ListPostPage({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<PostBloc>(context).add(
      GetAllPostsEvent(),
    );
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: CustomBottomNavigationBar(),
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
      ),
    );
  }
}
