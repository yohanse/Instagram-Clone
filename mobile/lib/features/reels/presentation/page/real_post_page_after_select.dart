import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/features/auth/presentation/widgets/dialog.dart';
import 'package:mobile/features/reels/presentation/bloc/add_reel/add_reel_bloc.dart';
import 'package:photo_manager/photo_manager.dart';

import '../widget/video_Player.dart';

class ReelPostPageAfterSelect extends StatelessWidget {
  TextEditingController _tagController = TextEditingController();
  final File path;
  ReelPostPageAfterSelect({
    super.key,
    required this.path,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddReelBloc, AddReelState>(
      builder: (context, state) {
        return Stack(
          children: [
            Scaffold(
              backgroundColor: Colors.black,
              appBar: AppBar(
                leading: IconButton(
                  icon: Icon(Icons.arrow_back_ios_new_rounded),
                  color: Colors.white,
                  onPressed: () {
                    context.go("/");
                  },
                ),
                title: Text(
                  "New Reel",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                backgroundColor: Colors.black,
              ),
              body: Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: VideoApp(
                      path: path,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          TextField(
                            controller: _tagController,
                            decoration: InputDecoration(
                              hintText: "Write a caption ...",
                              hintStyle:
                                  TextStyle(color: Colors.grey, fontSize: 14),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                            ),
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          Container(
                            color: Colors.grey,
                            width: double.infinity,
                            height: 1,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Center(
                            child: SizedBox(
                              height: 50,
                              width: 120,
                              child: ElevatedButton(
                                onPressed: () {
                                  BlocProvider.of<AddReelBloc>(context).add(
                                    AddReelClick(
                                        content: _tagController.text,
                                        filePath: path.path),
                                  );
                                },
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.blue),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                ),
                                child: Text(
                                  "Next",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 19,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (state is AddReelLoading)
              Container(
                height: double.maxFinite,
                width: double.maxFinite,
                color: Colors.black.withOpacity(0.5),
                child: Center(
                child: Container(
                  height: 60,
                  width: 60,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  ),
                ),
              ),
              ),
          ],
        );
      },
      listener: (context, state) {
        if (state is AddReelSuccess) {
          context.go("/reel");
        }
      },
    );
  }
}
