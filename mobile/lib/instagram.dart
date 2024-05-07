import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile/features/auth/presentation/bloc/check_email/check_email_bloc.dart';
import 'package:mobile/features/auth/presentation/bloc/check_confirmation/check_confirmation_bloc.dart';
import 'package:mobile/features/auth/presentation/bloc/check_username/check_username_bloc.dart';
import 'package:mobile/features/auth/presentation/bloc/login/login_bloc.dart';
import 'package:mobile/features/auth/presentation/pages/Finally.dart';
import 'package:mobile/features/auth/presentation/pages/birth_date.dart';
import 'package:mobile/features/auth/presentation/pages/create_password.dart';
import 'package:mobile/features/auth/presentation/pages/finalConfirmation.dart';
import 'package:mobile/features/auth/presentation/pages/name.dart';
import 'package:mobile/features/common/Ui/picker.dart';
import 'package:mobile/features/common/presentation/bloc/AddingPost/adding_post_bloc.dart';
import 'package:mobile/features/common/presentation/bloc/Image/image_manager_bloc.dart';
import 'package:mobile/features/common/presentation/bloc/IsMultipleSelected/is_multiple_selected_bloc.dart';
import 'package:mobile/features/common/presentation/bloc/post/post_bloc.dart';
import 'package:mobile/features/common/presentation/page/ImagePickerPage.dart';
import 'package:mobile/features/message/presentation/bloc/list%20users/list_users_bloc.dart';
import 'package:mobile/features/message/presentation/page/list_of_user.dart';
import 'package:mobile/features/message/presentation/page/message_with_user.dart';
import 'package:mobile/features/message/presentation/page/test.dart';
import 'package:mobile/features/profile/presentation/bloc/profile/profile_bloc.dart';
import 'package:mobile/features/profile/presentation/page/profile_page.dart';
import 'package:mobile/features/reels/presentation/bloc/add_reel/add_reel_bloc.dart';
import 'package:mobile/features/reels/presentation/bloc/get%20all%20reel/get_all_reel_bloc.dart';
import 'package:mobile/features/reels/presentation/bloc/real%20manager%20select%20all%20albums/real_manager_fetch_all_albums_bloc.dart';
import 'package:mobile/features/reels/presentation/bloc/real%20manager%20selected%20album/real_manager_selected_album_bloc.dart';
import 'package:mobile/features/reels/presentation/bloc/reel%20manger%20selected%20album%20medias/reel_manager_selected_labum_medias_bloc.dart';
import 'package:mobile/features/reels/presentation/page/real_post_page_after_select.dart';
import 'package:mobile/features/reels/presentation/page/reel_page.dart';
import 'package:mobile/injection.dart';
import 'package:photo_manager/photo_manager.dart';

import 'features/auth/presentation/bloc/signup/singup_bloc.dart';
import 'features/auth/presentation/pages/code.dart';
import 'features/auth/presentation/pages/email.dart';
import 'features/auth/presentation/pages/login.dart';
import 'features/auth/presentation/pages/username.dart';
import 'features/common/presentation/page/AfterImagePicke.dart';
import 'features/common/presentation/page/ListPostPage.dart';
import 'features/reels/presentation/bloc/get single reel/get_single_reel_bloc.dart';
import 'features/reels/presentation/bloc/like reel/like_reel_bloc.dart';
import 'features/reels/presentation/page/reel_post_page.dart';

class InstagramApp extends StatelessWidget {
  const InstagramApp({super.key});

  @override
  Widget build(BuildContext context) {
    final GoRouter _router = GoRouter(
      navigatorKey: GlobalKey<NavigatorState>(),
      routes: [
        // GoRoute(
        //   path: '/',
        //   builder: (context, state) => LoginPage(),
        // ),
        // GoRoute(
        //   path: '/signup',
        //   builder: (context, state) => EmailPage(),
        // ),
        // GoRoute(
        //   path: '/signup/confirmation',
        //   builder: (context, state) => CodePage(
        //     email: state.extra! as String,
        //   ),
        // ),
        // GoRoute(
        //   path: '/signup/confirmation/password',
        //   builder: (context, state) => CreatePasswordPage(
        //     email: state.extra! as String,
        //   ),
        // ),
        // GoRoute(
        //   path: '/signup/confirmation/password/birthday',
        //   builder: (context, state) => BirthDatePage(
        //     extra: state.extra! as ExtraPassword,
        //   ),
        // ),
        // GoRoute(
        //   path: '/signup/confirmation/password/birthday/name',
        //   builder: (context, state) => NamePage(
        //     extra: state.extra! as ExtraBirthDate,
        //   ),
        // ),
        // GoRoute(
        //   path: "/signup/confirmation/password/birthday/name/username",
        //   builder: (context, state) => UserNamePage(
        //     extra: state.extra! as ExtraName,
        //   ),
        // ),
        // GoRoute(
        //   path:
        //       "/signup/confirmation/password/birthday/name/username/finalConfirmation",
        //   builder: (context, state) => FinalConfirmationPage(
        //     extra: state.extra! as ExtraUserName,
        //   ),
        // ),
        // GoRoute(
        //   path: '/',
        //   builder: (context, state) => const ListPostPage(),
        // ),
        // GoRoute(
        //   path: '/',
        //   builder: (context, state) => const PickerImageVideo(),
        // ),
        // GoRoute(
        //   path: '/pickImage/post',
        //   builder: (context, state) => AfterImagwPickerPage(
        //     medias: state.extra as List<AssetEntity>,
        //   ),
        // ),
        // GoRoute(
        //   path: "/profile",
        //   builder: (context, state) => const ProfilePage(),
        // ),

        // GoRoute(
        //   path: "/Reel",
        //   builder: (context, state) => ReelPage(),
        // ),

        // // GoRoute(
        // //   path: "/",
        // //   builder: (context, state) => SelectReelVideoPage(),
        // // ),
        // GoRoute(
        //   path: "/next",
        //   builder: (context, state) => ReelPostPageAfterSelect(
        //     path: state.extra as File,
        //   ),
        // ),
        GoRoute(
          path: "/",
          builder: (context, state) => ListUsersPage(),
        ),
        GoRoute(
          path: "/chat",
          builder: (context, state) => ChatPage(
            userParams: state.extra as UserParams,
          ),
        ),
        // GoRoute(
        //   path: "/",
        //   builder: (context, state) => WebsocketDemo(),
        // ),
      ],
    );
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<CheckEmailBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<CheckConfirmationBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<CheckUsernameBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<SingupBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<LoginBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<PostBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<ImageManagerBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<IsMultipleSelectedBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<AddingPostBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<ProfileBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<GetAllReelBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<LikeReelBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<GetSingleReelBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<RealManagerFetchAllAlbumsBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<ReelManagerSelectedLabumMediasBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<RealManagerSelectedAlbumBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<AddReelBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<ListUsersBloc>(),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: _router,
      ),
    );
  }
}
