import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
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
        appBar: AppBar(
          backgroundColor: Colors.black,
          // assets/icons/IgNote.svg
          actions: [
            IconButton(
              icon: Icon(
                size: 30,
                Icons.favorite_outline_rounded,
                color: Colors.white,
              ),
              onPressed: () {},
            ),
            Transform.rotate(
              angle: -45 * 3.141592653589793 / 180,
              child: IconButton(
                icon: Icon(
                  size: 30,
                  Icons.send_outlined,
                  color: Colors.white,
                ),
                onPressed: () {
                  context.go("/message");
                },
              ),
            ),
          ],
          title: SizedBox(
            width: 150,
            height: 50,
            child: SvgPicture.asset(
              'assets/icons/IgNote.svg',
              color: Colors.white,
              fit: BoxFit.contain,
            ),
          ),
        ),
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
                          index: i,
                          numberOfComment: state.post[i].comments!.length,
                          numberOfLike: state.post[i].numberOfLike!,
                          time: state.post[i].created_at!,
                          text: state.post[i].text,
                          imageUrl: state.post[i].images[0],
                          authName: state.post[i].author!.name,
                          profileImageUrl: state.post[i].author!.profile_image,
                          isILiked: state.post[i].isILiked!,
                          postId: state.post[i].id!,
                          likeId: state.post[i].likeIdILike,
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
