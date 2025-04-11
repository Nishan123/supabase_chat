import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:supabase_chat/models/message_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MessageController {
  final messageTable = Supabase.instance.client.from("message_table");
  Future<void> sendMessage(MessageModel message) async {
    try {
      await messageTable.insert(message.toMap());
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Stream<List<MessageModel>> getMessages(String senderUid, String receiverUid) {
    try {
      return messageTable
          .stream(primaryKey: ["messageId"])
          .order('sendAt', ascending: true)
          .map(
            (data) =>
                data
                    .where((msg) {
                      final s = msg['senderId'] as String;
                      final r = msg['reciverId'] as String;
                      return (s == senderUid && r == receiverUid) ||
                          (s == receiverUid && r == senderUid);
                    })
                    .map((m) => MessageModel.fromMap(m))
                    .toList(),
          );
    } catch (e) {
      debugPrint(e.toString());
      throw Exception("Error while retrieving message: ${e.toString()}");
    }
  }

  Future<void> sendImageMessage(File image, MessageModel message) async {
    try {
      Supabase.instance.client.auth.currentUser!.id.toString();
      final fileExt = image.path.split(".").last;
      final fileName = "${message.senderId}_${message.messageId}.$fileExt";
      await Supabase.instance.client.storage
          .from("images")
          .upload(fileName, image);

      final imageUrl = Supabase.instance.client.storage
          .from("images")
          .getPublicUrl(fileName);

      sendMessage(message.copyWith(message: imageUrl));
    } catch (e) {
      debugPrint("Field to send image message: ${e.toString()}");
      throw Exception("Field to send image message: ${e.toString()}");
    }
  }
}
