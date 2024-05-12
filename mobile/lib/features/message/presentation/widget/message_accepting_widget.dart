import 'package:flutter/material.dart';
import 'package:mobile/features/message/Domain/entitie/message_entitie.dart';

class MessageAcceptingWidget extends StatelessWidget {
  final MessageEntitie message;
  const MessageAcceptingWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          flex: 6,
          child: Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.blue,
            ),
            child: Text(
              message.content,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        const Expanded(
          flex: 4,
          child: SizedBox(),
        ),
      ],
    );
  }
}
