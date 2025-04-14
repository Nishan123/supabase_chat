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
        ? senderBubble()
        : receiverBubble();
  }

  senderBubble() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(messageModel.sendAt.toString()),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.black12,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.zero,
            ),
          ),
          child: Center(
            child:
                messageModel.isImage
                    ? SizedBox(
                      height: 200,
                      width: 120,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                          messageModel.message,
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                    : Text(messageModel.message),
          ),
        ),
      ],
    );
  }

  receiverBubble() {
    return Row(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomLeft: Radius.zero,
              bottomRight: Radius.circular(10),
            ),
          ),
          child: Center(
            child:
                messageModel.isImage
                    ? SizedBox(
                      height: 200,
                      width: 120,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          messageModel.message,
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                    : Text(
                      messageModel.message,
                      style: TextStyle(color: Colors.white),
                    ),
          ),
        ),
        Text(messageModel.sendAt.toString()),
      ],
    );
  }
}
