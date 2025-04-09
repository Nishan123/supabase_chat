import 'package:flutter/material.dart';
import 'package:supabase_chat/models/message_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MessageBubble extends StatelessWidget {
  final String uid;
  final MessageModel messageModel;
  const MessageBubble({
    super.key,
    required this.uid,
    required this.messageModel,
  });

  @override
  Widget build(BuildContext context) {
    return messageModel.senderId ==
            Supabase.instance.client.auth.currentUser!.id.toString()
        ? Container(
          margin: EdgeInsets.all(8),
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.black12,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.zero,
            ),
          ),
          child: Center(child: Text(messageModel.message)),
        )
        : Container(
          
          margin: EdgeInsets.all(8),
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.black12,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomLeft: Radius.zero,
              bottomRight: Radius.circular(10),
            ),
          ),
          child: Center(child: Text(messageModel.message)),
        );
  }
}
