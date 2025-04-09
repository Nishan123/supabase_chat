import 'dart:io';

import 'package:flutter/rendering.dart';
import 'package:supabase_chat/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserController {
  final usersTable = Supabase.instance.client.from("users_table");

  Future<UserModel> getProfileData(String uid) async {
    try {
      final profileData = await usersTable.select().eq("uid", uid).single();
      return UserModel.fromMap(profileData);
    } catch (e) {
      debugPrint(e.toString());
      throw Exception("Failed to get User Data");
    }
  }

  Stream<List<UserModel>> getAllUsers() {
    try {
      final currentUserId = Supabase.instance.client.auth.currentUser?.id;
      return usersTable
          .stream(primaryKey: ["uid"])
          .map(
            (data) =>
                data
                    .map((user) => UserModel.fromMap(user))
                    .where((user) => user.uid != currentUserId)
                    .toList(),
          );
    } catch (e) {
      debugPrint(e.toString());
      throw Exception("Failed to load users");
    }
  }

  Future<void> updateProfilePic(File image) async {
    try {
      final userId = Supabase.instance.client.auth.currentUser!.id.toString();
      final fileExt = image.path.split('.').last;
      final fileName = "$userId.$fileExt";
      await Supabase.instance.client.storage
          .from("images")
          .upload(fileName, image);

      final imageUrl = Supabase.instance.client.storage
          .from("images")
          .getPublicUrl(fileName);

      await usersTable.update({"profileUrl": imageUrl}).eq("uid", userId);
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
