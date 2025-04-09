import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';
import 'package:supabase_chat/controller/message_controller.dart';
import 'package:supabase_chat/custom_widgets/message_bubble.dart';
import 'package:supabase_chat/models/message_model.dart';
import 'package:supabase_chat/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ChatScreen extends StatefulWidget {
  final UserModel user;
  const ChatScreen({super.key, required this.user});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundColor: Colors.black12,
              backgroundImage: NetworkImage(widget.user.profileUrl),
            ),
            SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.user.fullName),
                Text(
                  widget.user.gmail,
                  style: TextStyle(fontWeight: FontWeight.w300, fontSize: 16),
                ),
              ],
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder<List<MessageModel>>(
                stream: MessageController().getMessages(
                  Supabase.instance.client.auth.currentUser!.id.toString(),
                  widget.user.uid,
                ),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text("Error Occoured"));
                  } else {
                    final messages = snapshot.data;
                    return ListView.builder(
                      itemCount: messages?.length,
                      itemBuilder: (context, index) {
                        return MessageBubble(
                          uid:
                              Supabase.instance.client.auth.currentUser!.id
                                  .toString(),
                          messageModel: messages![index],
                        );
                      },
                    );
                  }
                },
              ),
            ),
            _chatInput(),
          ],
        ),
      ),
    );
  }

  Widget _chatInput() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      child: Row(
        children: [
          Expanded(
            child: Card(
              elevation: 0,
              color: const Color.fromARGB(77, 196, 196, 196),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0),
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.emoji_emotions),
                  ),
                  Expanded(
                    child: TextField(
                      controller: messageController,
                      style: const TextStyle(color: Colors.black),
                      maxLines: null,
                      onTap: () {},
                      keyboardType: TextInputType.multiline,
                      decoration: const InputDecoration(
                        hintText: "Type your Message....",
                        hintStyle: TextStyle(color: Colors.black26),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      String messageId = randomAlphaNumeric(12);
                      final message = MessageModel(
                        messageId: messageId,
                        message: messageController.text,
                        senderId:
                            Supabase.instance.client.auth.currentUser!.id
                                .toString(),
                        reciverId: widget.user.uid,
                        sendAt: DateTime.now().toString(),
                      );
                      await MessageController().sendMessage(message);
                      messageController.clear();
                    },
                    icon: Icon(Icons.send),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
