import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/features/reels/presentation/bloc/get%20all%20reel/get_all_reel_bloc.dart';

import '../../../profile/presentation/widget/custom_bottom_bar_navigation.dart';
import '../widget/single_reel_.dart';

class ReelPage extends StatelessWidget {
  final _controller = PageController();
  ReelPage({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<GetAllReelBloc>(context).add(
      GetAllReelsEvent(),
    );
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: CustomBottomNavigationBar(),
        body: Container(
          color: Colors.black,
          child: BlocBuilder<GetAllReelBloc, GetAllReelState>(
              builder: (context, state) {
            if (state is GetAllReelLoadedState) {
              return PageView.builder(
                  itemCount: state.reels.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    return CustomVideoPlayer(
                      reelId: "${state.reels[index].id}",
                      videoUrl: state.reels[index].video,
                      authorName: state.reels[index].author!.name,
                      profileImageurl: state.reels[index].author!.profile_image,
                      isLiked: state.reels[index].isILiked!,
                      numberOfLike: state.reels[index].numberOfLike!,
                    );
                  });
            } else if (state is GetAllReelLoadingState) {
              return Text("Loading");
            }
            return Text("Error");
          }),
        ),
      ),
    );
  }
}
